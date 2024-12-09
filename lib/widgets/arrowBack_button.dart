import 'package:flutter/material.dart';

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
