import 'package:flutter/material.dart';

class SuccessPopup extends StatelessWidget {
  final Function onTap;

  const SuccessPopup({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/success_icon.png', // Replace with your asset path
            height: 80,
            width: 80,
          ),
          SizedBox(height: 16),
          Text(
            'Login Berhasil!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              onTap();
            },
            child: Text('Lanjutkan'),
          ),
        ],
      ),
    );
  }
}
