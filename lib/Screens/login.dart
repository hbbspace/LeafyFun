import 'package:flutter/material.dart';
import 'package:leafyfun/widgets/header_text.dart';
import 'package:leafyfun/widgets/login_button.dart';
import 'package:leafyfun/widgets/login_form.dart';
import 'package:leafyfun/widgets/signup_text_button.dart';
import 'package:leafyfun/widgets/social_login_button.dart';
import 'package:leafyfun/widgets/title_widget.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  // Controller untuk username dan password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Gambar latar belakang
          Positioned.fill(
            child: Image.asset(
              'assets/images/Background_LogIn.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Judul Halaman
          const Align(
            alignment: Alignment.topLeft,
            child: TitleWidget(
              title: 'Welcome \nBack!',
              subtitle: 'Sign in to continue',
              titleColor: Colors.white,
              subtitleColor: Colors.white,
              titleFontSize: 36,
              subtitleFontSize: 14,
              paddingTop: 85,
              paddingLeft: 20,
              paddingRight: 20,
              spacing: 8,
            ),
          ),

          // Kontainer Login
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              height: size.height * 0.65,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Teks Login
                    const HeaderText(
                      text: 'Login',
                      fontSize: 24,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 20),

                    // Form Input Login
                    LoginForm(
                      usernameController: _emailController,
                      passwordController: _passwordController,
                    ),
                    const SizedBox(height: 30),

                    // Tombol Login
                    LoginButton(
                      emailController: _emailController,
                      passwordController: _passwordController,
                    ),
                    const SizedBox(height: 30),

                    // Teks Lanjutkan
                    const ContinueWithText(),
                    const SizedBox(height: 15),

                    // Tombol Sosial Media Login
                    SocialLoginButton(
                      assetPath: 'assets/images/devicon_google.png',
                      label: 'Login with Google',
                    ),
                    const SizedBox(height: 10),
                    SocialLoginButton(
                      assetPath: 'assets/images/devicon_apple.png',
                      label: 'Login with Apple',
                    ),
                    const SizedBox(height: 20),

                    // Teks Sign Up
                    const SignUpText(),
                  ],
                ),
              ),
            ),
          ),
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
