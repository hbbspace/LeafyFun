import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:leafyfun/Screens/article1.dart';
import 'package:leafyfun/Screens/article2.dart';
import 'package:leafyfun/Screens/leafyQuiz.dart';
import 'package:leafyfun/Screens/profile.dart';
import 'package:leafyfun/Screens/scanPage.dart';
import 'package:leafyfun/widgets/floating_navbar.dart';

class LeafyGarden extends StatefulWidget {
  const LeafyGarden({super.key});

  @override
  State<LeafyGarden> createState() => _LeafyGardenState();
}

class _LeafyGardenState extends State<LeafyGarden> {
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Tambahkan logika navigasi di sini
    switch (index) {
      case 0:
        // Navigasi ke HomePage
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LeafyQuiz()),
        );
        break;
      case 1:
        // Navigasi ke LeafyQuiz
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LeafyQuiz()),
        );
        break;
      case 2:
        // Navigasi ke ScanPage
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ScanPage()),
        );
        break;
      case 3:
        // Navigasi ke LeafyGarden
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LeafyGarden()),
        );
        break;
      case 4:
        // Navigasi ke Profile
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Konten Utama
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Carousel Banner menggunakan ArticleCarousel
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'My Garden',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 20, top: 8), // Tambahkan padding untuk jarak
                      child: Text(
                        'You have 3 plants.',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color:
                              Colors.black54, // Warna teks sedikit lebih terang
                        ),
                      ),
                    ),
                    const SizedBox(height: 20), // Spasi sebelum carousel
                    ArticleCarousel(),
                  ],
                ),

                const SizedBox(height: 30),

                // Tips and Trick
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Tips & Trick',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    // Tambahkan widget TipsAndTrick
                    TipsAndTrick(
                      tittle: "5 tips & trick to keep your plants healthy",
                      image: 'assets/images/tipsntrick1.png',
                    ),
                    TipsAndTrick(
                      tittle: "How to plant the right seeds",
                      image: 'assets/images/tipsntrick2.png',
                    ),
                  ],
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),

          // Floating Navigation Bar Tetap di Bawah
          Positioned(
            bottom: 15,
            left: 20,
            right: 20,
            child: FloatingNavigationButtonBar(
              currentIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            ),
          ),
        ],
      ),
    );
  }
}

class ArticleCarousel extends StatelessWidget {
  ArticleCarousel({super.key});

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
          autoPlay: false,
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
      appBar: AppBar(title: Text('Artikel 3')),
      body: Center(child: Text('Halaman Artikel 3')),
    );
  }
}

class TipsAndTrick extends StatelessWidget {
  final String tittle;
  final String image;

  const TipsAndTrick({
    super.key,
    required this.tittle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
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
              image,
              height: 100,
              width: 100,
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
                  tittle,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
