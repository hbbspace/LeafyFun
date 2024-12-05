import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:leafyfun/Screens/article1.dart';
import 'package:leafyfun/Screens/article2.dart';

class ArticleSlider extends StatelessWidget {
  ArticleSlider({super.key});

  final List<String> bannerImages = [
    'assets/images/artikel1.png',
    'assets/images/artikel1.png',
    'assets/images/artikel1.png',
  ];

  final List<String> bannerTitles = [
    'Cara Mudah Menanam Jeruk di Rumah!',
    'Tips Merawat Anggrek untuk Pemula',
    'Panduan Lengkap Berkebun di Lahan Sempit',
  ];

  final List<Widget> targetPages = [
    Article1(),
    Article2(),
    Article2(),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      width: double.maxFinite,
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 2.0,
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          initialPage: 0,
          autoPlay: true,
          viewportFraction: 0.8, // Mengatur ukuran item carousel
        ),
        items: List.generate(bannerImages.length, (index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => targetPages[index],
                ),
              );
            },
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: AssetImage(bannerImages[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 20,
                  child: SizedBox(
                    width: 350, // Batas lebar teks agar dapat membungkus
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        bannerTitles[index],
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                        softWrap: true, // Memungkinkan teks untuk pindah baris
                        overflow: TextOverflow.visible, // Teks tidak dipotong
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
