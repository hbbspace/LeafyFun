import 'package:flutter/material.dart';
import 'package:leafyfun/widgets/arrowBack_button.dart';

class Article2 extends StatelessWidget {
  const Article2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Konten utama halaman
          Container(
            color: Colors.white, // Background halaman putih
            child: Center(
              child: Text(
                'Halaman Artikel 2',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Button kembali
          ArrowBackButton(
            onPressed: () {
              Navigator.pop(context); // Navigasi kembali
            },
          ),
        ],
      ),
    );
  }
}

