import 'package:flutter/material.dart';

class NewPasswordForm extends StatefulWidget {
  const NewPasswordForm({super.key});

  @override
  _NewPasswordFormState createState() => _NewPasswordFormState();
}

class _NewPasswordFormState extends State<NewPasswordForm> {
  // Variabel untuk mengontrol visibilitas masing-masing TextField
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  // Fungsi toggle untuk TextField pertama
  void _togglePasswordVisibility1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  // Fungsi toggle untuk TextField kedua
  void _togglePasswordVisibility2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        TextField(
          obscureText:
              _obscureText1, // Menggunakan variabel untuk TextField pertama
          decoration: InputDecoration(
            labelText: 'New Password',
            labelStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 13),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText1 ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed:
                  _togglePasswordVisibility1, // Menggunakan toggle pertama
            ),
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          obscureText:
              _obscureText2, // Menggunakan variabel untuk TextField kedua
          decoration: InputDecoration(
            labelText: 'Repeat Password',
            labelStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 13),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText2 ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: _togglePasswordVisibility2, // Menggunakan toggle kedua
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}