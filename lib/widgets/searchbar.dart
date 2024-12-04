// TODO Implement this library.
import 'package:flutter/material.dart';

class SearchBarQuiz extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String) onChanged;

  const SearchBarQuiz({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            color: Colors.grey,
          ),
          border: InputBorder.none,
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: () {
                    controller.clear();
                    onChanged(''); // Trigger perubahan untuk reset
                  },
                )
              : null,
        ),
      ),
    );
  }
}
