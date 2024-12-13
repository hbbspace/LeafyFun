import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class UserProvider extends ChangeNotifier {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  String? token;
  int? userId;
  String? userName;
  String? email;
  bool _hasUserPlant = false;

  bool get hasUserPlant => _hasUserPlant;

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
          'ngrok-skip-browser-warning':
              'true', // Menambahkan header ini untuk menghindari halaman warning
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
        userId = payload['user_id'];
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

  Future<bool> checkUserPlant(int userId) async {
  try {
    // Buat URL endpoint dengan query parameter user_id
    final url = Uri.parse('${dotenv.env['ENDPOINT_URL']}/get_user_plants/$userId');

    // Kirim permintaan HTTP GET
    final response = await http.get(
      url,
      headers: {
        'ngrok-skip-browser-warning':
              'true', // Menambahkan header ini untuk menghindari halaman warning
      },
    );

    switch (response.statusCode) {
      case 200:
        // Parse respons dari server dan periksa data
        final data = jsonDecode(response.body) as List<dynamic>;
        _hasUserPlant = data.isNotEmpty;

        debugPrint('User has plants: $_hasUserPlant');
        break;

      case 401:
        // Token invalid atau expired
        await secureStorage.delete(key: 'jwt_token');
        debugPrint('Authorization failed. Token removed.');
        break;

      default:
        // Status code lain
        debugPrint('Failed to fetch user plant data: ${response.body}');
        break;
    }

    notifyListeners(); // Memperbarui UI setelah status berubah
    return response.statusCode == 200;
  } catch (e) {
    debugPrint('Error fetching user plant data: $e');
    notifyListeners(); // Memperbarui UI setelah status berubah
    return false;
  }
}


}
