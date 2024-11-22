import 'package:flutter/material.dart';
import 'package:leafyfun/Screens/new_password.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _otpControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  void dispose() {
    for (final controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white, // Background halaman putih
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Supaya column tetap di tengah
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Posisi teks di tengah
                children: [
                  const SizedBox(height: 40),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Email Verification',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Image.asset(
                            'assets/images/mailbox.png', // Path logo Anda
                            width: 24,
                            height: 24,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'We\'ve sent a verification code to',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '***man03@gmail.com',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      _otpControllers.length,
                      (index) => _buildOtpInput(index: index),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Didn't receive the code? ",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigasi ke...
                        },
                        child: const Text(
                          'Resend',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  const VerifyButton(),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0, // Jarak dari atas
            left: 25, // Jarak dari kiri
            child: ArrowBackButton(
              onPressed: () {
                Navigator.pop(
                    context); // Navigasi kembali ke halaman sebelumnya
              },
              borderColor: Colors.black, // Warna border
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpInput({required int index}) {
    return SizedBox(
      width: 50,
      child: TextFormField(
        controller: _otpControllers[index],
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          counterText: '',
        ),
        maxLength: 1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '';
          }
          return null;
        },
        onChanged: (value) {
          if (value.length == 1 && index < _otpControllers.length - 1) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }
}

class VerifyButton extends StatelessWidget {
  const VerifyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            // Add navigation
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NewPassword()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(10, 66, 63, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Verify',
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

class ArrowBackButton extends StatelessWidget {
  final VoidCallback onPressed; // Fungsi fleksibel untuk navigasi atau aksi
  final String iconPath; // Path ke gambar icon
  final Color borderColor; // Warna border stroke

  const ArrowBackButton({
    super.key,
    required this.onPressed,
    this.iconPath = 'assets/images/ArrowLeftBlack.png', // Path default
    this.borderColor = Colors.grey, // Warna default
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Container luar sebagai "stroke"
          Container(
            width:
                35, // Lebar dan tinggi lebih besar dari gambar untuk "stroke"
            height: 35,
            decoration: BoxDecoration(
              color: Colors.transparent, // Warna latar belakang stroke
              borderRadius: BorderRadius.circular(10), // Border rounded
              border: Border.all(
                color: borderColor, // Warna "stroke"
                width: 1, // Ketebalan "stroke"
              ),
            ),
          ),
          // Container dalam berisi gambar icon
          Container(
            width: 20, // Lebar dan tinggi sesuai dengan ukuran gambar
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), // Border rounded gambar
            ),
            child: Image.asset(
              iconPath, // Path gambar icon custom
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
