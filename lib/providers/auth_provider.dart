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

  // Fungsi login untuk autentikasi pengguna
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
        // Jika login berhasil, ambil token dari response
        final responseData = json.decode(response.body);
        final token = responseData['token'];  // Pastikan nama field sesuai dengan response dari API Anda

        if (token != null) {
          // Menyimpan token di FlutterSecureStorage
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

  // Fungsi logout untuk menghapus token dan status autentikasi
  Future<void> logout() async {
    final storage = FlutterSecureStorage();
    await storage.delete(key: 'auth_token');
    _token = null;
    _isAuthenticated = false;
    
    notifyListeners();
  }

  // Fungsi untuk mengecek apakah pengguna sudah terautentikasi
  Future<void> checkAuthentication() async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'auth_token');
    _isAuthenticated = token != null;
    _token = token;
    notifyListeners();
  }
}