import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class QuizSlider extends StatelessWidget {
  QuizSlider({super.key});

  final List<String> bannerImages = [
    'assets/images/quiz_apple.jpg',
    'assets/images/quiz_cherry.jpeg',
    'assets/images/quiz_grape.jpg',
    'assets/images/quiz_strawberry.jpeg',
    'assets/images/quiz_tomato.jpg',
  ];

  final List<String> bannerTitles = [
    'Apple',
    'Cherry',
    'Grape',
    'Strawberry',
    'Tomato',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      width: double.infinity,
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
          return Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: AssetImage(bannerImages[index]),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 20,
                child: SizedBox(
                  width: 350,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        // Shadow text
                        Text(
                          bannerTitles[index],
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black, // Shadow color
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            shadows: [
                              Shadow(
                                offset: Offset(1.0, 1.0), // X and Y offset
                                blurRadius: 3.0, // Blur radius
                                color: Colors.black, // Shadow color
                              ),
                            ],
                          ),
                        ),
                        // Foreground text
                        Text(
                          bannerTitles[index],
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Color.fromRGBO(
                                255, 255, 255, 1), // White color
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
