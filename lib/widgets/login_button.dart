import 'package:flutter/material.dart';
import 'package:leafyfun/Screens/homepage.dart';
import 'package:leafyfun/providers/auth_provider.dart';
import 'package:provider/provider.dart';

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
            // Mengambil instance AuthProvider
            final authProvider = Provider.of<AuthProvider>(context, listen: false);

            // Mengambil username dan password dari controller
            final username = usernameController.text;
            final password = passwordController.text;

            // Panggil metode login dari AuthProvider dan simpan hasilnya di success
            final success = await authProvider.login(username, password);

            if (success == true) {
              // Pastikan Navigator dipanggil jika widget masih terpasang
              if (context.mounted) {
                // Navigasi ke HomePage jika login berhasil
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePageScreen(
                      token: authProvider.token ?? '',  // Nilai default jika token null
                    ),
                  ),
                );
              }
            } else {
              // Tampilkan pesan error jika login gagal
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Login failed")),
                );
              }
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