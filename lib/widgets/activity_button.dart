import 'package:flutter/material.dart';

class ActivityButton extends StatelessWidget {
  final String title;
  final Color borderColor;
  final Color textColor;
  final VoidCallback onPressed;

  const ActivityButton({
    required this.title,
    required this.borderColor,
    required this.textColor,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        elevation: 0,
        side: BorderSide(color: borderColor, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
