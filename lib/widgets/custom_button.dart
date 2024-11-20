import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed; // Fungsi fleksibel untuk berbagai aksi
  final Color backgroundColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final IconData icon; // Ikon yang akan ditampilkan
  final double iconSize;
  final Color iconColor;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.icon, // Ikon wajib diisi
    this.backgroundColor = const Color.fromARGB(255, 255, 255, 255),
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.all(12), // Default padding
    this.iconSize = 24.0,
    this.iconColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: padding,
        minimumSize: Size.zero, // Menghindari ukuran minimum default
      ),
      onPressed: onPressed,
      child: Icon(
        icon,
        size: iconSize,
        color: iconColor,
      ),
    );
  }
}
