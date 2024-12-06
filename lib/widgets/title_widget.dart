import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title; // Teks utama seperti "Welcome Back!"
  final String subtitle; // Teks kecil seperti "Sign in to continue"
  final Color titleColor; // Warna teks utama
  final Color subtitleColor; // Warna teks kecil
  final double titleFontSize; // Ukuran font teks utama
  final double subtitleFontSize; // Ukuran font teks kecil
  final double paddingTop; // Padding atas
  final double paddingLeft; // Padding kiri
  final double paddingRight; // Padding kanan
  final double spacing; // Jarak antara teks utama dan kecil

  const TitleWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.titleColor = Colors.white,
    this.subtitleColor = Colors.white,
    this.titleFontSize = 40,
    this.subtitleFontSize = 16,
    this.paddingTop = 100,
    this.paddingLeft = 20,
    this.paddingRight = 20,
    this.spacing = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          paddingLeft, paddingTop, paddingRight, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
          SizedBox(height: spacing),
          Text(
            subtitle,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: subtitleFontSize,
              color: subtitleColor,
            ),
          ),
        ],
      ),
    );
  }
}
