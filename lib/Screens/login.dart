import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:leafyfun/Screens/forgot_password.dart';
import 'package:leafyfun/Screens/homepage.dart';
import 'package:leafyfun/Screens/register.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool _obscureText = true;

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
                  children: const [
                    //Text Login
                    HeaderText(),
                    SizedBox(height: 20),

                    //Kolom Input
                    LoginForm(),
                    SizedBox(height: 30),

                    //Tombol Login
                    LoginButton(),
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

class HeaderText extends StatelessWidget {
  const HeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 10),
      child: Text(
        'Login',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Username / Email',
            labelStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 13),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          obscureText: _obscureText,
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 13),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: _togglePasswordVisibility,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () {
              // Add navigation or action for forgot password
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ForgotPassword()),
              );
            },
            child: const Text(
              'Forgot Password?',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            // Add navigation or login functionality here
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePageScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(10, 66, 63, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Login',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
            ),
          ),
        ),
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

class SocialLoginButton extends StatelessWidget {
  final String assetPath;
  final String label;

  const SocialLoginButton({
    super.key,
    required this.assetPath,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            // Add navigation or social login functionality here
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(350),
              side: const BorderSide(color: Colors.black),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                assetPath,
                height: 24,
                width: 24,
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpText extends StatelessWidget {
  const SignUpText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13,
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: () {
            // Navigasi ke halaman Sign Up di sini
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterScreen()),
            );
          },
          child: const Text(
            'Sign Up',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
      ],
    );
  }
}

Future<void> login(String username, String password) async {
  final response = await http.post(
    Uri.parse('/login/'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': username, 'password': password}),
  );

  if (response.statusCode == 200) {
    // Login berhasil
    jsonDecode(response.body);
    // Simpan token atau data user jika diperlukan
  } else {
    // Tampilkan pesan kesalahan
    print('Login gagal: ${response.body}');
  }
}
