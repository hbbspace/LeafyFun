import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:leafyfun/Screens/homepage.dart';
import 'package:leafyfun/Screens/profile.dart';
import 'package:leafyfun/Widgets/floating_navbar.dart';

class LeafyQuiz extends StatefulWidget {
  const LeafyQuiz({super.key});

  @override
  _LeafyQuizState createState() => _LeafyQuizState();
}

class _LeafyQuizState extends State<LeafyQuiz> {
  int _selectedIndex = 1; // Set index sesuai dengan posisi di navbar
  final TextEditingController _searchController = TextEditingController();
  List<String> _allQuizItems = [
    'Aloe Vera',
    'Sunflower',
    'Cactus',
    'Rose',
    'Tulip',
    'Daisy'
  ];
  List<String> _filteredQuizItems = [];

  @override
  void initState() {
    super.initState();
    _filteredQuizItems = _allQuizItems; // Awalnya tampilkan semua item
  }

  void _onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredQuizItems = _allQuizItems;
      } else {
        _filteredQuizItems = _allQuizItems
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Logika navigasi antar halaman
    switch (index) {
      case 0:
        // Navigasi ke HomePage
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePageScreen()),
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
        Navigator.pushNamed(context, '/scan');
        break;
      case 3:
        Navigator.pushNamed(context, '/garden');
        break;
      case 4:
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
      body: Stack(
        children: [
          // Background hijau
          Container(
            color: const Color.fromRGBO(10, 66, 63, 1), // Warna hijau
          ),

          // Gambar di bagian atas
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height:
                  MediaQuery.of(context).size.height * 0.6, // Setengah layar
              child: Image.asset(
                'assets/images/BackgroundLeafyQuiz.png', // Path gambar
                fit: BoxFit.cover,
              ),
            ),
          ),

          // TopBar di atas background
          Positioned(
            top: 30,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Column(
                children: [
                  TopBarWidget(
                    greeting: "Welcome to Leafy Quiz,",
                    userName: "User123",
                    profileImagePath: 'assets/images/profilePicture.png',
                  ),
                  const SizedBox(height: 10),

                  // SearchBar Widget
                  SearchBar(
                    controller: _searchController,
                    hintText: "Search quizzes...",
                    onChanged: _onSearchChanged,
                  ),
                ],
              ),
            ),
          ),

          // Konten di atas gambar
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(top: 30, bottom: 0),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 250, 250, 250),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.75, // Bagian bawah
              child: ListView(
                padding: const EdgeInsets.only(left: 2, right: 2),
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: const Text(
                      'Select Your Quiz',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Menambahkan QuizSlider di bawah judul
                  QuizSlider(),
                  const SizedBox(height: 40),

                  Container(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: const Text(
                      'Finished Quiz',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 80, 80, 80),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Menampilkan hasil pencarian dalam bentuk daftar quiz
                  ..._filteredQuizItems.map((quiz) {
                    return FinishedQuiz(
                      plantName: quiz,
                      plantImage: 'assets/images/plants3.png',
                      QuizDescription: 'Description for $quiz.',
                    );
                  }).toList(),

                  const SizedBox(height: 100), // Tambahan ruang untuk navigasi
                ],
              ),
            ),
          ),

          // FloatingNavigationButtonBar
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

// Widget Carousel Slider
class QuizSlider extends StatelessWidget {
  QuizSlider({super.key});

  final List<String> bannerImages = [
    'assets/images/plants1.png',
    'assets/images/plants2.png',
    'assets/images/plants3.png',
  ];

  final List<String> bannerTitles = [
    'Cara Mudah Menanam Jeruk di Rumah!',
    'Tips Merawat Anggrek untuk Pemula',
    'Panduan Lengkap Berkebun di Lahan Sempit',
  ];

  final List<Widget> targetPages = [];

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
                      fit: BoxFit.fill,
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    userName,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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

class FinishedQuiz extends StatelessWidget {
  final String plantName;
  final String plantImage;
  final String QuizDescription;

  const FinishedQuiz({
    super.key,
    required this.plantName,
    required this.plantImage,
    required this.QuizDescription,
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
                  QuizDescription,
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

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String) onChanged;

  const SearchBar({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            color: Colors.grey,
          ),
          border: InputBorder.none,
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: () {
                    controller.clear();
                    onChanged(''); // Trigger perubahan untuk reset
                  },
                )
              : null,
        ),
      ),
    );
  }
}
