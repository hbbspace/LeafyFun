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
              icon: Image.asset(
                _obscureText1
                    ? 'assets/images/eye_on.png'
                    : 'assets/images/eye_off.png',
                width: 24,
                height: 24,
              ),
              onPressed: _togglePasswordVisibility1,
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
              icon: Image.asset(
                _obscureText2
                    ? 'assets/images/eye_on.png'
                    : 'assets/images/eye_off.png',
                width: 24,
                height: 24,
              ),
              onPressed: _togglePasswordVisibility2,
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
