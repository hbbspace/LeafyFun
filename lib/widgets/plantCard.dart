import 'package:flutter/material.dart';

class PlantCard extends StatelessWidget {
  final String plantName;
  final String imagePath;

  const PlantCard({
    super.key,
    required this.plantName,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Frame putih di sekitar gambar
          Container(
            padding: const EdgeInsets.all(8), // Frame putih
            decoration: const BoxDecoration(
              color: Colors.white, // Warna frame
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(15), bottom: Radius.circular(15)),
            ),
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              plantName,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
