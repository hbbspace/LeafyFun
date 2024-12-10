import 'package:flutter/material.dart';
import 'package:leafyfun/widgets/header_text.dart';
import 'package:leafyfun/widgets/login_text.dart';
import 'package:leafyfun/widgets/register_button.dart';
import 'package:leafyfun/widgets/register_form.dart';
import 'package:leafyfun/widgets/title_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/Background_LogIn.jpg',
              fit: BoxFit.cover,
            ),
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: TitleWidget(
              title: 'Welcome \nUser!',
              subtitle: 'Sign up to join',
              titleColor: Color.fromARGB(255, 255, 255, 255),
              subtitleColor: Color.fromARGB(255, 255, 255, 255),
              titleFontSize: 36,
              subtitleFontSize: 14,
              paddingTop: 100,
              paddingLeft: 20,
              paddingRight: 20,
              spacing: 8,
            ),
          ),
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
              height: MediaQuery.of(context).size.height * 0.65,
              child: ListView(
                children: [
                  HeaderText(
                    text: 'Register',
                    fontSize: 24,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 20),
                  RegisterForm(
                    usernameController: _usernameController,
                    emailController: _emailController,
                    passwordController: _passwordController,
                  ),
                  const SizedBox(height: 30),
                  RegisterButton(
                    usernameController: _usernameController,
                    emailController: _emailController,
                    passwordController: _passwordController,
                  ),
                  const SizedBox(height: 30),
                  const LogInText(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
