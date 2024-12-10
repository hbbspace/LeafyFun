import 'package:flutter/material.dart';

class PlantDescription extends StatelessWidget {
  final String commonName; // Nama umum tanaman
  final String latinName; // Nama latin tanaman
  final String description; // Deskripsi tanaman
  final String fruitContent; // Kandungan buah
  final String fruitSeason; // Musim buah
  final String region; // Wilayah persebaran
  final String priceRange; // Kisaran harga

  const PlantDescription({
    super.key,
    required this.commonName,
    required this.latinName,
    required this.description,
    required this.fruitContent,
    required this.fruitSeason,
    required this.region,
    required this.priceRange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nama umum dan nama latin tanaman
          Text(
            commonName.isNotEmpty ? commonName : 'Nama Umum Tidak Tersedia',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            latinName.isNotEmpty ? latinName : 'Nama Latin Tidak Tersedia',
            style: const TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          // Deskripsi tanaman
          _buildSection(title: 'Description', content: description.isNotEmpty ? description : 'Deskripsi Tidak Tersedia'),
          const SizedBox(height: 20),
          // Kandungan buah
          _buildSection(title: 'Fruit Content', content: fruitContent.isNotEmpty ? fruitContent : 'Kandungan Buah Tidak Tersedia'),
          const SizedBox(height: 20),
          // Musim buah
          _buildSection(title: 'Fruit Season', content: fruitSeason.isNotEmpty ? fruitSeason : 'Musim Buah Tidak Tersedia'),
          const SizedBox(height: 20),
          // Wilayah persebaran
          _buildSection(title: 'Region', content: region.isNotEmpty ? region : 'Wilayah Persebaran Tidak Tersedia'),
          const SizedBox(height: 20),
          // Kisaran harga
          _buildSection(title: 'Price Range', content: priceRange.isNotEmpty ? priceRange : 'Kisaran Harga Tidak Tersedia'),
        ],
      ),
    );
  }

  // Widget untuk membangun setiap bagian informasi
  Widget _buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          content,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
