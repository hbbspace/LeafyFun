import 'package:flutter/material.dart';
import 'package:leafyfun/Screens/homepage.dart';
import 'package:leafyfun/Screens/leafy_garden.dart';
import 'package:leafyfun/Screens/profile.dart';
import 'package:leafyfun/Screens/scan_page.dart';
import 'package:leafyfun/Widgets/floating_navbar.dart';
import 'package:leafyfun/providers/user_provider.dart';
import 'package:leafyfun/widgets/finished_quiz.dart';
import 'package:leafyfun/widgets/quiz_slider.dart';
import 'package:leafyfun/widgets/topbar_quiz.dart';
import 'package:leafyfun/widgets/searchbar.dart';
import 'package:provider/provider.dart';

class LeafyQuiz extends StatefulWidget {
  const LeafyQuiz({super.key});

  @override
  _LeafyQuizState createState() => _LeafyQuizState();
}

class _LeafyQuizState extends State<LeafyQuiz> {
  int _selectedIndex = 1; // Set index sesuai dengan posisi di navbar
  final TextEditingController _searchController = TextEditingController();
  final List<String> _allQuizItems = [
    'Orange',
    'Mango',
    'Guava',
  ];
  List<String> _filteredQuizItems = [];

  @override
  void initState() {
    super.initState();
    _filteredQuizItems = _allQuizItems; // Awalnya tampilkan semua item
    // Load token and username from UserProvider
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.loadUserInfo();
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
    if (_selectedIndex == index) return; // Avoid navigating to the same page

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
    // Mendapatkan username dari UserProvider
    final userName = Provider.of<UserProvider>(context).userName ?? 'Loading...';
    
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
                  TopbarQuiz(
                    greeting: "Welcome to Leafy Quiz,",
                    userName: userName,
                    profileImagePath: 'assets/images/profilePicture.png',
                  ),
                  const SizedBox(height: 10),

                  // SearchBar Widget
                  SearchBarQuiz(
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
                  // ..._filteredQuizItems.map((quiz) {
                  //   return FinishedQuiz(
                  //     plantName: quiz,
                  //     plantImage: 'assets/images/plants3.png',
                  //     QuizDescription: 'Description for $quiz.',
                  //   );
                  // }),

                  FinishedQuiz(
                    plantName: "Orange",
                    plantImage: "assets/images/quiz_orange.jpg",
                    quizDescription:
                        "Pilih jawaban yang benar mengenai tanaman jeruk.",
                  ),
                  FinishedQuiz(
                    plantName: "Mango",
                    plantImage: "assets/images/quiz_mango.jpeg",
                    quizDescription:
                        "Pilih jawaban yang benar mengenai tanaman jeruk.",
                  ),
                  FinishedQuiz(
                    plantName: "Guava",
                    plantImage: "assets/images/quiz_guava.png",
                    quizDescription:
                        "Pilih jawaban yang benar mengenai tanaman jeruk.",
                  ),

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
