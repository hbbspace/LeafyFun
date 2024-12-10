import 'package:flutter/material.dart';
import 'package:leafyfun/Screens/homepage.dart';
import 'package:leafyfun/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  // Fungsi untuk validasi input
  bool _validateInput(String email, String password) {
    return email.isNotEmpty && password.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            final email = emailController.text.trim();
            final password = passwordController.text.trim();

            // Validasi input
            if (!_validateInput(email, password)) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("email and password cannot be empty")),
              );
              return;
            }
            final navigator = Navigator.of(context);
            final scaffoldMessenger = ScaffoldMessenger.of(context);

            final authProvider = Provider.of<AuthProvider>(context, listen: false);

            try {
              final success = await authProvider.login(email, password);

              if (success == true && context.mounted) {
                navigator.pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomePageScreen()),
                );
              } else {
                scaffoldMessenger.showSnackBar(
                  const SnackBar(content: Text("Invalid email or password")),
                );
              }
            } catch (e) {
              // Menangani error koneksi atau lainnya
              scaffoldMessenger.showSnackBar(
                SnackBar(content: Text("Login failed: ${e.toString()}")),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(10, 66, 63, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 15),
          ),
          child: const Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
