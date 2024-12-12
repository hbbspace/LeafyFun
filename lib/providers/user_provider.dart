import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class UserProvider extends ChangeNotifier {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  String? token;
  String? userId;
  String? userName;
  String? email;

  Future<String?> getToken() async {
    return await secureStorage.read(key: 'jwt_token');
  }

  Future<Map<String, dynamic>?> getCurrentUser() async {
    String? token = await getToken();
    if (token == null) {
      return null;
    }

    try {
      final response = await http.get(
        Uri.parse('${dotenv.env['ENDPOINT_URL']}/user'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        // Token invalid atau expired
        await secureStorage.delete(key: 'jwt_token');
        return null;
      } else {
        debugPrint('Failed to fetch user data: ${response.body}');
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching user data: $e');
      return null;
    }
  }

  // Fungsi untuk mengambil informasi pengguna dari token
  Future<void> loadUserInfo() async {
    try {
      String? storedToken = await secureStorage.read(key: 'auth_token');
      if (storedToken != null) {
        token = storedToken;

        // Decode dan verifikasi token menggunakan jsonwebtoken
        final jwt = JWT.verify(storedToken, SecretKey('${dotenv.env['SECRET_KEY']}'));
        final payload = jwt.payload;

        // Debugging print statements
        debugPrint('Stored Token: $storedToken');
        debugPrint('JWT Payload: $payload');

        // Ambil user_id, username dan email dari payload
        userId = payload['user_id']?.toString();
        userName = payload['username'] ?? 'User';
        email = payload['email'] ?? 'unknown@example.com';

        // Debugging print statements
        debugPrint('UserName: $userName');
        debugPrint('Email: $email');
      } else {
        debugPrint('No token found');
      }
      notifyListeners(); // Notifikasi perubahan state
    } catch (e) {
      debugPrint('Error loading token: $e');
    }
  }
}
