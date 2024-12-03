import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  String? _token;

  String? get token => _token;

  // Future<bool> login(String email, String password) async {
  //   final url = Uri.parse('http://localhost:8000/login/login');
  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: {'Content-Type': 'application/json'},
  //       body: json.encode({'email': email, 'password': password}),
  //     );

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       _token = data['token'];
  //       notifyListeners();
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (error) {
  //     debugPrint('Error during login: $error');
  //     return false;
  //   }
  // }

  Future<String?> login(String username, String password) async {
  try {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/Login/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['token']; // Return token
    } else {
      debugPrint('Login failed: ${response.body}');
      return null;
    }
  } catch (e) {
    debugPrint('Error: $e');
    return null;
  }
}
}
