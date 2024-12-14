import 'package:flutter/material.dart';

class PopupWidget extends StatelessWidget {
  final String title;
  final String desc;
  final String buttonText;
  final String imagePath;
  final Function onTap;

  const PopupWidget({
    super.key,
    required this.title,
    required this.desc,
    required this.buttonText,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imagePath, // Path gambar yang dapat disesuaikan
            height: 80,
            width: 80,
          ),
          SizedBox(height: 16),
          Text(
            title, // Teks judul yang dapat disesuaikan
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            desc, // Teks judul yang dapat disesuaikan
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              onTap();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(10, 66, 63, 1), // Warna tombol
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            ),
            child: Text(
              buttonText, // Teks tombol yang dapat disesuaikan
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
