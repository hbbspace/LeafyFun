import 'package:flutter/material.dart';
import 'package:leafyfun/widgets/backButton.dart';
import 'package:leafyfun/widgets/verify_button_otp.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background halaman putih
      body: Stack(
        children: [
          Positioned(
            top: 30, // Jarak dari atas
            left: 25, // Jarak dari kiri
            child: ArrowBackButton(
              onPressed: () {
                Navigator.pop(
                    context); // Navigasi kembali ke halaman sebelumnya
              },
              borderColor: Colors.black, // Warna border
            ),
          ),
          Positioned(
            top: 40, // Posisi dari atas untuk form
            left: 16, // Posisi dari kiri untuk form
            right: 16, // Posisi dari kanan untuk form
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min, // Supaya column tetap di tengah
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
