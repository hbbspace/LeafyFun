import 'package:flutter/material.dart';
import 'package:leafyfun/widgets/add_leafyGarden_button.dart';
import 'package:leafyfun/widgets/arrowBack_button.dart';
import 'dart:io';

import 'package:leafyfun/widgets/plantDescription.dart';

class ScanDetailPage extends StatelessWidget {
  final File capturedImage; // Parameter untuk menerima gambar

  const ScanDetailPage({super.key, required this.capturedImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Ubah warna dasar menjadi putih
      body: Stack(
        children: [
          // Tambahkan tombol back di posisi kiri atas
          Positioned(
            top: 20, // Jarak dari atas
            left: 20, // Jarak dari kiri
            child: ArrowBackButton(
              onPressed: () {
                Navigator.pop(context); // Navigasi kembali
              },
            ),
          ),
          // Konten halaman dengan tambahan jarak dari tombol back
          Padding(
            padding: const EdgeInsets.only(top: 80), // Tambahkan jarak ke bawah
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Image.file(
                      capturedImage, // Menampilkan gambar yang diterima
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    //     Image.asset(
                    //   'images/assets/3D_Plant.png', // Menampilkan gambar yang diterima
                    //   height: 200,
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  const SizedBox(height: 20),
                  PlantDescription(
                    title: 'Description',
                    description:
                        'Phasellus rhoncus enim ante. Aliquam pellentes rutrun dui, utdignissim erat egest shoes porta. Fusce ac and metus nonaugue mattis and aliquam. Vestibulum ut a nunc vel turpissemper on luctus. Suspendisse potenti. Sagittis finibusproduct eget, sodales blan man shoes. Interdum comfortablecasual sneakers.',
                  ),
                  const SizedBox(height: 50),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AddLeafygardenButton()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
