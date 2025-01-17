import 'package:flutter/material.dart';

class AddLeafygardenButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddLeafygardenButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(10, 66, 63, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(360),
            ),
            padding: const EdgeInsets.symmetric(vertical: 25), // Padding atas dan bawah
          ),
          child: const Text(
            "Add To LeafyGarden",
            style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
          ),
        ),
      ),
    );
  }
}
