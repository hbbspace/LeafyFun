import 'package:flutter/material.dart';
import 'package:leafyfun/Screens/otp_verification.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            // Add navigation or ForgotPassword functionality here
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OtpVerificationPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(10, 66, 63, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Reset Password',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}