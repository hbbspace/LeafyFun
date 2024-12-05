import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:leafyfun/Screens/homepage.dart';
import 'package:leafyfun/Screens/register.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:leafyfun/widgets/header_text.dart';
import 'package:leafyfun/widgets/login_button.dart';
import 'package:leafyfun/widgets/login_form.dart';
import 'package:leafyfun/widgets/signup_text_button.dart';
import 'package:leafyfun/widgets/social_login_button.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool _obscureText = true;

  // Menambahkan controller untuk username dan password
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/Background_LogIn.jpg',
              fit: BoxFit.cover,
            ),
          ),

          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 100, 20, 0),
              child: Column(
                // Menempatkan teks di sebelah kiri
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Teks "Welcome Back" dan "Sign in Again"
                  Text(
                    'Welcome \nBack!',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 250, 250, 250),
                    ),
                  ),
                  SizedBox(height: 10), // Memberikan jarak antar teks
                  Text(
                    'Sign in to continue',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      // fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Align(
              alignment: Alignment.bottomCenter,
              // Container berwarna putih untuk form login
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.65,
                child: ListView(
                  children: [
                    //Text Login
                    HeaderText(
                      text: 'Login',
                      fontSize: 24, // Ubah ukuran teks
                      color: Colors.black, // Ubah warna teks
                    ),

                    SizedBox(height: 20),

                    //Kolom Input
                    LoginForm(
                        usernameController: _usernameController,
                        passwordController: _passwordController),
                    SizedBox(height: 30),

                    //Tombol Login
                    LoginButton(
                        usernameController: _usernameController,
                        passwordController: _passwordController),
                    SizedBox(height: 30),

                    //Teks
                    ContinueWithText(),
                    SizedBox(height: 15),

                    //Button login google
                    SocialLoginButton(
                      assetPath: 'assets/images/devicon_google.png',
                      label: 'Login with Google',
                    ),
                    SizedBox(height: 10),

                    //Button login apple
                    SocialLoginButton(
                      assetPath: 'assets/images/devicon_apple.png',
                      label: 'Login with Apple',
                    ),
                    SizedBox(height: 20),

                    //Text SignUp
                    SignUpText(),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class ContinueWithText extends StatelessWidget {
  const ContinueWithText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'or continue with',
        style: TextStyle(
          fontFamily: 'Poppins',
          color: Color.fromRGBO(81, 89, 120, 1),
          fontSize: 12,
        ),
      ),
    );
  }
}

Future<String?> login(String username, String password) async {
  try {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String token = data['token']; // Mengambil token dari response

      // Menyimpan token ke secure storage
      final storage = FlutterSecureStorage();
      await storage.write(key: 'auth_token', value: token);

      return token; // Kembalikan token jika perlu
    } else {
      debugPrint('Login failed: ${response.body}');
      return null;
    }
  } catch (e) {
    debugPrint('Error: $e');
    return null;
  }
}
