import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          // Top Bar Widget
          const TopBarWidget(
            greeting: "Hello,",
            userName: "User123",
            profileImagePath: 'assets/images/profile.png',
          ),
          const SizedBox(height: 20),

          // Carousel Banner menggunakan ArticleCarousel
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Article',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ArticleCarousel(),
            ],
          ),
          const SizedBox(height: 30),

          // Carousel Banner menggunakan ArticleCarousel
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'New Added Plants',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ArticleCarousel(),
            ],
          ),
          const SizedBox(height: 30),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'New Added Plants',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ArticleCarousel(),
            ],
          ),

          // Konten utama lainnya
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Text(
                "Main content here",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
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
    'Cara Mudah Menanam Jeruk di Rumah!',
    'Cara Mudah Menanam Jeruk di Rumah!',
    'Cara Mudah Menanam Jeruk di Rumah!',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: double.maxFinite,
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 2.0,
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          initialPage: 0,
          autoPlay: false,
          viewportFraction: 0.8, // Mengatur ukuran item carousel
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
                left: 20,
                child: Container(
                  width: 375, // Batas lebar teks agar dapat membungkus
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
          );
        }),
      ),
    );
  }
}

class TopBarWidget extends StatelessWidget {
  final String greeting;
  final String userName;
  final String profileImagePath;

  const TopBarWidget({
    Key? key,
    required this.greeting,
    required this.userName,
    required this.profileImagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Kata sambutan
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  Text(
                    userName,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 5), // Jarak antara teks dan gambar
                  Image.asset(
                    'assets/images/waving_hands.png',
                    height: 20,
                    width: 20,
                  ),
                ],
              ),
            ],
          ),
          // Gambar profil bulat kecil
          CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(profileImagePath),
          ),
        ],
      ),
    );
  }
}
