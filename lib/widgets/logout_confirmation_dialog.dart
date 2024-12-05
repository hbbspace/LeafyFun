import 'package:flutter/material.dart';
import 'package:leafyfun/Screens/login.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  const LogoutConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text("Konfirmasi Logout"),
      content: const Text("Apakah anda yakin ingin keluar?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Tutup dialog
          },
          child: const Text(
            "Tidak",
            style: TextStyle(color: Colors.black),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Tutup dialog
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LogInScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text(
            "Ya",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
