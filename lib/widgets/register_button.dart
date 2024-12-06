import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback onRegister;

  const RegisterButton({super.key, required this.onRegister});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onRegister,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(10, 66, 63, 1),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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