import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: const Text("hello \n user12331"),
          ),
      body: Column(
        children: [
          // Carousel Banner menggunakan ArticleCarousel
          ArticleCarousel(),

          // Konten utama lainnya
          const Expanded(
            child: Center(
              child: Text("Main content here"),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget untuk ArticleCarousel
class ArticleCarousel extends StatelessWidget {
  ArticleCarousel({super.key});

  final List<String> bannerImages = [
    'assets/images/artikel1.png',
    'assets/images/artikel1.png',
    'assets/images/artikel1.png',
  ];

  final List<String> bannerTitles = [
    'Article 1',
    'Article 2',
    'Article 3',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 2.0,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        initialPage: 0,
        autoPlay: true,
      ),
      items: List.generate(bannerImages.length, (index) {
        return Stack(
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
              left: 12,
              child: Container(
                // padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                // decoration: BoxDecoration(
                //   color: Colors.white.withOpacity(
                //       0.8), // Background warna putih dengan transparansi
                //   borderRadius: BorderRadius.circular(5),
                // ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    bannerTitles[index],
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
