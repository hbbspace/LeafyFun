import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<String?> getToken() async {
  final storage = FlutterSecureStorage();
  return await storage.read(key: 'auth_token');
}

Future<Map<String, dynamic>?> getCurrentUser() async {
  String? token = await getToken();
  if (token == null) {
    return null; // Jika token tidak ada, kembalikan null
  }

  try {
    final response = await http.get(
      Uri.parse('${dotenv.env['ENDPOINT_URL']}/home'), // Endpoint untuk mengambil data pengguna
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Failed to fetch user data: ${response.body}');
      return null;
    }
  } catch (e) {
    print('Error fetching user data: $e');
    return null;
  }
}