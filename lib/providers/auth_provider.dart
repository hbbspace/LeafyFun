import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;
  bool _isAuthenticated = false;

  String? get token => _token;
  bool get isAuthenticated => _isAuthenticated;

  Future<bool> login(String username, String password) async {
    final url = '${dotenv.env['ENDPOINT_URL']}/login';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'email': username,
          'password': password,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final token = responseData['access_token']; // Disesuaikan dengan field dari API

        if (token != null) {
          final storage = FlutterSecureStorage();
          await storage.write(key: 'auth_token', value: token);

          _token = token;
          _isAuthenticated = true;
          notifyListeners();
        }

        return true;
      } else {
        throw Exception('Login failed');
      }
    } catch (error) {
      throw Exception('Login failed: $error');
    }
  }

  Future<void> logout() async {
    final storage = FlutterSecureStorage();
    await storage.delete(key: 'auth_token');
    _token = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<void> checkAuthentication() async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'auth_token');
    _isAuthenticated = token != null;
    _token = token;
    notifyListeners();
  }
}