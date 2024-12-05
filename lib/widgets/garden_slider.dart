import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../Screens/article1.dart';
import '../Screens/article2.dart';

class GardenSlider extends StatelessWidget {
  GardenSlider({super.key});

  final List<String> bannerImages = [
    'assets/images/artikel1.png',
    'assets/images/artikel1.png',
    'assets/images/artikel1.png',
  ];

  final List<String> bannerTitles = [
    'Orange',
    'Apple',
    'Guava',
  ];

  final List<Widget> targetPages = [
    Article1(),
    Article2(),
    Page3(),
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
          viewportFraction: 0.8,
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
                    width: 375,
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
                        softWrap: true,
                        overflow: TextOverflow.visible,
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

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Artikel 3')),
      body: const Center(child: Text('Halaman Artikel 3')),
    );
  }
}
