import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class RegisterButton extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const RegisterButton({
    super.key,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            final authProvider = Provider.of<AuthProvider>(context, listen: false);
            final username = usernameController.text.trim();
            final email = emailController.text.trim();
            final password = passwordController.text.trim();

            // Validasi form kosong
            if (username.isEmpty || email.isEmpty || password.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All fields are required')),
              );
              return;
            }

            // Indikator loading
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            );
              final navigator = Navigator.of(context);
              final scaffoldMessenger = ScaffoldMessenger.of(context);

            try {
              final success = await authProvider.register(username, email, password);
              if (success) {
                scaffoldMessenger.showSnackBar(
                  const SnackBar(content: Text('Registration successful')),
                );
                navigator.pop(); // Tutup dialog
                navigator.pop(); // Kembali ke layar login
              }
            } catch (error) {
              navigator.pop(); // Tutup dialog
              scaffoldMessenger.showSnackBar(
                SnackBar(content: Text('Error: $error')),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(10, 66, 63, 1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text(
            "Register",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
