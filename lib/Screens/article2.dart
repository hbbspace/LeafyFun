import 'package:flutter/material.dart';

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

class ArrowBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ArrowBackButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40, // Atur posisi vertikal
      left: 20, // Atur posisi horizontal
      child: GestureDetector(
        onTap: onPressed,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Container luar sebagai "stroke"
            Container(
              width: 46,
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
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset(
                'assets/images/arrow-left.png', // Path gambar icon custom
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
