import 'package:flutter/material.dart';
import 'package:leafyfun/Screens/forgot_password.dart';


class LoginForm extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const LoginForm({
    super.key,
    required this.usernameController,
    required this.passwordController,
  });

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
          controller: widget.usernameController,
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
          controller: widget.passwordController,
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
        // LoginButton(
        //   usernameController: widget.usernameController,
        //   passwordController: widget.passwordController,
        // ),
      ],
    );
  }
}