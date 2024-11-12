import 'package:flutter/material.dart';
import 'package:leafyfun/Screens/login.dart';

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
            child: GestureDetector(
              onTap: () {
                // Navigasi ke halaman Login atau kembali ke halaman sebelumnya
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LogInScreen()),
                );
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
                    'Forgot \nPassword',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 250, 250, 250),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Enter your email',
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
                  HeaderText(),
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

class HeaderText extends StatelessWidget {
  const HeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 10),
      child: Text(
        'Email Address',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Enter your email',
            labelStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 13),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

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
