import 'package:flutter/material.dart';
import 'package:leafyfun/Screens/homepage.dart';
import 'package:leafyfun/Screens/login.dart';

class LoginButton extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const LoginButton({
    super.key,
    required this.usernameController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            // Simulate login API call
            final username = usernameController.text;
            final password = passwordController.text;
            final token = await login(username, password);

            if (token != null) {
              // Navigate to HomePage with token
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePageScreen(token: token),
                ),
              );
            } else {
              // Show error message
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Login failed")),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(10, 66, 63, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            "Login",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}