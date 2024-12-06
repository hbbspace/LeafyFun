import 'package:flutter/material.dart';
import 'package:leafyfun/Screens/leafyGarden.dart';
import 'package:leafyfun/Screens/leafyQuiz.dart';
import 'package:leafyfun/Screens/profile.dart';
import 'package:leafyfun/Screens/scanPage.dart';
import 'package:leafyfun/widgets/NewAddedPlant.dart';
import 'package:leafyfun/widgets/article_slider.dart';
import 'package:leafyfun/widgets/floating_navbar.dart';
import 'package:leafyfun/widgets/topbar_homepage.dart';

class HomePageScreen extends StatefulWidget {
  final String token;
  const HomePageScreen({super.key, required this.token});

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
    debugPrint(widget.token);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Konten Utama
          SingleChildScrollView(
            child: Column(
              children: [
                // Top Bar Widget
                const SizedBox(height: 50),
                const TopbarHomepage(
                  greeting: "Hello,",
                  userName: "User123",
                  profileImagePath: 'assets/images/profilePicture.png',
                ),
                const SizedBox(height: 20),

                // ArticleSlider
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
                    ArticleSlider(),
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
                      plantDescription:
                          "Tanaman pepaya dengan rasa manis segar.",
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
                      plantDescription:
                          "Tanaman pepaya dengan rasa manis segar.",
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
