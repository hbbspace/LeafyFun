import 'package:flutter/material.dart';
import 'package:leafyfun/widgets/backButton.dart';
import 'package:leafyfun/widgets/forgot_password_button.dart';
import 'package:leafyfun/widgets/forgot_password_form.dart';
import 'package:leafyfun/widgets/header_text.dart';
import 'package:leafyfun/widgets/title_widget.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/Background_LogIn.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Button kembali atau navigasi ke halaman Login
          Positioned(
            top: 85,
            left: 20,
            child: ArrowBackButton(
              onPressed: () {
                Navigator.pop(context); // Navigasi kembali
              },
              iconPath: 'assets/images/arrow-left.png', // Path ikon custom
              borderColor: const Color.fromARGB(
                  255, 130, 130, 130), // Warna stroke custom
            ),
          ),

          const Align(
            alignment: Alignment.topLeft,
            child: TitleWidget(
              title: 'Forgot \nPassword',
              subtitle: 'Enter your email',
              titleColor: Color.fromARGB(255, 255, 255, 255),
              subtitleColor: Color.fromARGB(255, 255, 255, 255),
              titleFontSize: 40,
              subtitleFontSize: 16,
              paddingTop: 150,
              paddingLeft: 20,
              paddingRight: 20,
              spacing: 8,
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.35,
              child: ListView(
                children: const [
                  // HeaderText(),
                  HeaderText(
                    text: 'Email Address',
                    fontSize: 24, // Ubah ukuran teks
                    color: Colors.black, // Ubah warna teks
                  ),
                  SizedBox(height: 20),
                  ForgotPasswordForm(),
                  SizedBox(height: 30),
                  ForgotPasswordButton(),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
