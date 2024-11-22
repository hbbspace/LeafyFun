import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:leafyfun/Screens/article1.dart';
import 'package:leafyfun/Screens/article2.dart';
// import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Tambahkan logika navigasi di sini
    switch (index) {
      case 0:
        // Navigasi ke Home
        break;
      case 1:
        // Navigasi ke Search
        break;
      case 2:
        // Navigasi ke Favorite
        break;
      case 3:
        // Navigasi ke Profile
        break;
    }
  }

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
            profileImagePath: 'assets/images/plants1.png',
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
                    fontSize: 30,
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

          // New Added Plants
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'New Added Plants',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 10),
              NewAddedPlantItem(
                plantName: "Pohon Pepaya",
                plantImage: "assets/images/plants1.png",
                plantDescription: "Tanaman pepaya dengan rasa manis segar.",
              ),
              NewAddedPlantItem(
                plantName: "Pohon Jambu",
                plantImage: "assets/images/plants2.png",
                plantDescription:
                    "Tanaman Jambu yang menghasilkan buah besar dan manis.",
              ),
              NewAddedPlantItem(
                plantName: "Lemon",
                plantImage: "assets/images/plants3.png",
                plantDescription:
                    "Tanaman mangga yang menghasilkan buah besar dan manis.",
              ),
              NewAddedPlantItem(
                plantName: "Pohon Pepaya",
                plantImage: "assets/images/plants1.png",
                plantDescription: "Tanaman pepaya dengan rasa manis segar.",
              ),
              NewAddedPlantItem(
                plantName: "Pohon Jambu",
                plantImage: "assets/images/plants2.png",
                plantDescription:
                    "Tanaman Jambu yang menghasilkan buah besar dan manis.",
              ),
              NewAddedPlantItem(
                plantName: "Lemon",
                plantImage: "assets/images/plants3.png",
                plantDescription:
                    "Tanaman mangga yang menghasilkan buah besar dan manis.",
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Floating Navigation Bar
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: FloatingNavigationButtonBar(
                currentIndex: _selectedIndex,
                onItemTapped: _onItemTapped,
              ),
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
    'Cara Mudah Menanam Jeruk di Rumah!',
    'Tips Merawat Anggrek untuk Pemula',
    'Panduan Lengkap Berkebun di Lahan Sempit',
  ];

  final List<Widget> targetPages = [
    Article1(), // Ganti dengan halaman target Anda
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

class TopBarWidget extends StatelessWidget {
  final String greeting;
  final String userName;
  final String profileImagePath;

  const TopBarWidget({
    super.key,
    required this.greeting,
    required this.userName,
    required this.profileImagePath,
  });

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

class FloatingNavigationButtonBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTapped;

  const FloatingNavigationButtonBar({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(10, 66, 63, 1),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            assetPath: 'assets/images/plants1.png',
            index: 0,
            label: 'Home',
            isSelected: currentIndex == 0,
          ),
          _buildNavItem(
            assetPath: 'assets/images/plants1.png',
            index: 1,
            label: 'Quiz',
            isSelected: currentIndex == 1,
          ),
          _buildNavItem(
            assetPath: 'assets/images/plants1.png',
            index: 2,
            label: 'Scan',
            isSelected: currentIndex == 2,
          ),
          _buildNavItem(
            assetPath: 'assets/images/plants1.png',
            index: 3,
            label: 'Garden',
            isSelected: currentIndex == 3,
          ),
          _buildNavItem(
            assetPath: 'assets/images/plants1.png',
            index: 4,
            label: 'Profile',
            isSelected: currentIndex == 4,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required String assetPath,
    required int index,
    required String label,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding:
            isSelected ? const EdgeInsets.all(8.0) : const EdgeInsets.all(0.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius:
              BorderRadius.circular(360), // Radius untuk rounded corner
          border: Border.all(
            color:
                isSelected ? Colors.white : Colors.transparent, // Warna border
            width: 2  , // Lebar border
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              assetPath,
              height: 25,
              width: 25,
              color: isSelected
                  ? const Color.fromRGBO(10, 66, 63, 1)
                  : const Color.fromRGBO(255, 255, 255, 1),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: isSelected
                    ? 14
                    : 12, // Ukuran font berbeda untuk selected & unselected
                color: isSelected
                    ? const Color.fromRGBO(10, 66, 63, 1)
                    : const Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
