import 'package:flutter/material.dart';

class PlantDescription extends StatelessWidget {
  final String title;
  final String description;

  const PlantDescription({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
                fontFamily: 'Poppins', fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
