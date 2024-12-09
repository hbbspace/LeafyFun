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
            child: TitleWidget(
              title: 'Welcome \nBack!',
              subtitle: 'Sign in to continue',
              titleColor: Color.fromARGB(255, 255, 255, 255),
              subtitleColor: Color.fromARGB(255, 255, 255, 255),
              titleFontSize: 36,
              subtitleFontSize: 14,
              paddingTop: 85,
              paddingLeft: 20,
              paddingRight: 20,
              spacing: 8,
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
