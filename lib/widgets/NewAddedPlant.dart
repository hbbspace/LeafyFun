import 'package:flutter/material.dart';

class NewAddedPlantItem extends StatelessWidget {
  final String plantName;
  final String plantImage;
  final String plantDescription;

  const NewAddedPlantItem({
    super.key,
    required this.plantName,
    required this.plantImage,
    required this.plantDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Foto tanaman di sebelah kiri
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              plantImage,
              height: 70,
              width: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12), // Jarak antara foto dan teks
          // Nama tanaman dan deskripsi singkat
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plantName,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  plantDescription,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                  maxLines: 2,
                  overflow:
                      TextOverflow.ellipsis, // Jika deskripsi terlalu panjang
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}