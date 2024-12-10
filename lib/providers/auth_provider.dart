import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;
  bool _isAuthenticated = false;

  String? get token => _token;
  bool get isAuthenticated => _isAuthenticated;

  // Fungsi untuk memeriksa jika token sudah kadaluarsa
  bool _isTokenExpired(String token) {
    final decodedToken = JwtDecoder.decode(token);
    final expirationDate = DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);
    return expirationDate.isBefore(DateTime.now());
  }

  // Fungsi login yang memperbarui token
  Future<bool> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception("email dan password tidak boleh kosong");
    } else {
        final url = '${dotenv.env['ENDPOINT_URL']}/login';
        try {
          final response = await http.post(
            Uri.parse(url),
            body: json.encode({
              'email': email,
              'password': password,
            }),
            headers: {
              'Content-Type': 'application/json',
            },
          );

          if (response.statusCode == 200) {
            final responseData = json.decode(response.body);
            final token = responseData['access_token'];

            if (token != null) {
              final storage = FlutterSecureStorage();
              await storage.write(key: 'auth_token', value: token);
              _token = token;
              _isAuthenticated = true;
              notifyListeners();
              return true;
            } else {
              throw Exception(responseData['message'] ?? "Unknown error during login");
            }
          } else {
            throw Exception('HTTP Error: ${response.statusCode}');
          }
        } catch (error) {
          print("Login error: $error");
          rethrow;
        }
    }

  }


  // Fungsi logout yang menghapus token
  Future<void> logout() async {
    final storage = FlutterSecureStorage();
    await storage.delete(key: 'auth_token');
    _token = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  // Fungsi untuk memeriksa status autentikasi dan token
  Future<void> checkAuthentication() async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'auth_token');
    
    if (token != null && !_isTokenExpired(token)) {
      _token = token;
      _isAuthenticated = true;
    } else {
      _token = null;
      _isAuthenticated = false;
    }
    notifyListeners();
  }

  // Fungsi untuk mendapatkan token langsung dari Secure Storage
  Future<String?> getStoredToken() async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: 'auth_token');
  }

  // Fungsi untuk mengirimkan request dengan token di header
  Future<http.Response> authenticatedRequest(String url, {Map<String, String>? headers}) async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'auth_token');
    
    if (token == null || _isTokenExpired(token)) {
      throw Exception('Token expired or not found');
    }

    final requestHeaders = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      if (headers != null) ...headers,  // Menambahkan headers tambahan jika ada
    };

    return await http.get(Uri.parse(url), headers: requestHeaders);
  }

  Future<void> saveToken(String token) async {
  final storage = FlutterSecureStorage();
  await storage.write(key: 'auth_token', value: token);
  _token = token;
  _isAuthenticated = true;
  notifyListeners();
}

Future<void> clearToken() async {
  final storage = FlutterSecureStorage();
  await storage.delete(key: 'auth_token');
  _token = null;
  _isAuthenticated = false;
  notifyListeners();
}

}