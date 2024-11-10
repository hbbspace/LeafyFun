import 'package:flutter/material.dart';
import 'dart:async';
import 'log_in.dart'; // Import halaman sign-in

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const LogInScreen(), // Navigasi ke halaman sign-in
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(10, 66, 63, 1),
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height *
                0.20, // Atur posisi lebih ke atas
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/Logo_LeafyFun.png', // Gambar logo utama
                    height: 80,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'LeafyFun',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 150, 150, 150),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/College_Library.png', // Gambar dekorasi bawah
              width: MediaQuery.of(context).size.width,
              height:
                  MediaQuery.of(context).size.height * 0.5, // Setengah halaman
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
