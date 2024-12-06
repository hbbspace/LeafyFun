import 'package:flutter/material.dart';
import 'package:leafyfun/widgets/header_text.dart';
import 'package:leafyfun/widgets/new_password_button.dart';
import 'package:leafyfun/widgets/new_password_form.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
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
            child: GestureDetector(
              onTap: () {
                // Navigasi ke halaman Login atau kembali ke halaman sebelumnya
                Navigator.pop(context);
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Container luar sebagai "stroke"
                  Container(
                    width:
                        46, // Lebar dan tinggi lebih besar dari gambar untuk "stroke"
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.transparent, // Warna latar belakang stroke
                      borderRadius: BorderRadius.circular(10), // Border rounded
                      border: Border.all(
                        color: Colors.grey, // Warna "stroke"
                        width: 1.5, // Ketebalan "stroke"
                      ),
                    ),
                  ),
                  // Container dalam berisi gambar icon
                  Container(
                    width: 30, // Lebar dan tinggi sesuai dengan ukuran gambar
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(15), // Border rounded gambar
                    ),
                    child: Image.asset(
                      'assets/images/arrow-left.png', // Path gambar icon custom
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 150, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Teks "Forgot Password"
                  Text(
                    'New \nPassword',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 250, 250, 250),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Enter your new password',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              ),
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
                  // HeaderText(),`
                  HeaderText(
                    text: 'New Password',
                    fontSize: 24, // Ubah ukuran teks
                    color: Colors.black, // Ubah warna teks
                  ),
                  SizedBox(height: 20),
                  NewPasswordForm(),
                  SizedBox(height: 30),
                  NewPasswordButton(),
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
