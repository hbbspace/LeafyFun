import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserProvider extends ChangeNotifier {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  String? token;
  String? userName;

  Future<String?> getToken() async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: 'jwt_token');
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
        print('Failed to fetch user data: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }

  // Fungsi untuk mengambil token dan username
  Future<void> loadTokenAndUserName() async {
    try {
      String? storedToken = await secureStorage.read(key: 'auth_token');
      if (storedToken != null) {
        token = storedToken;

        // Decode token untuk mendapatkan username
        final parts = storedToken.split('.');
        if (parts.length == 3) {
          final payload = utf8.decode(
            base64Url.decode(base64Url.normalize(parts[1])),
          );
          final payloadMap = json.decode(payload);
          userName = payloadMap['username'] ?? 'User';
        }
      }
      notifyListeners(); // Notifikasi perubahan state
    } catch (e) {
      debugPrint('Error loading token: $e');
    }
  }
}
