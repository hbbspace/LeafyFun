import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const RegisterForm({
    super.key,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
  });

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool _obscureText = true; // Menambahkan state untuk password visibility

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText; // Toggle status obscureText
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.usernameController,
          decoration: InputDecoration(
            labelText: 'Username',
            labelStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 13),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          controller: widget.emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 13),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          controller: widget.passwordController,
          obscureText: _obscureText,
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 13),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            suffixIcon: IconButton(
              icon: Image.asset(
                _obscureText
                    ? 'assets/images/eye_on.png'
                    : 'assets/images/eye_off.png',
                width: 24,
                height: 24,
              ),
              onPressed: _togglePasswordVisibility,
            ),
          ),
        ),
      ],
    );
  }
}
