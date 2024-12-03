import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<String?> getToken() async {
  final storage = FlutterSecureStorage();
  return await storage.read(key: 'auth_token');
}

Future<Map<String, dynamic>?> getUserData() async {
  // Mengambil token dari secure storage
  String? token = await getToken();
  if (token == null) {
    return null; // Jika token tidak ada, kembalikan null
  }

  try {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/user/home'), // URL endpoint untuk mendapatkan data pengguna
      headers: {
        'Authorization': 'Bearer $token', // Menambahkan token pada header Authorization
        'Content-Type': 'application/json',
      },
    );

    // Cek jika status code 200 berarti berhasil
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data; // Mengembalikan data pengguna
    } else {
      print('Failed to load user data: ${response.body}');
      return null; // Jika gagal mengambil data
    }
  } catch (e) {
    print('Error: $e');
    return null; // Jika terjadi error
  }
}
