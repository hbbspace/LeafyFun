import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:leafyfun/Screens/leafyGarden.dart';
import 'package:leafyfun/Screens/leafyQuiz.dart';
import 'package:leafyfun/Screens/profile.dart';
import 'package:leafyfun/Screens/scanPage.dart';
import 'package:leafyfun/widgets/NewAddedPlant.dart';
import 'package:leafyfun/widgets/article_slider.dart';
import 'package:leafyfun/widgets/floating_navbar.dart';
import 'package:leafyfun/widgets/topbar_homepage.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  String? token; // Untuk menyimpan token JWT
  String? userName; // Untuk menyimpan username
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadTokenAndUserName();
  }

  // Fungsi untuk mengambil token dan username dari secure storage
  Future<void> _loadTokenAndUserName() async {
    try {
      // Ambil token dari secure storage
      String? storedToken = await secureStorage.read(key: 'jwt_token');
      if (storedToken != null) {
        setState(() {
          token = storedToken;
        });

        // Decode token untuk mendapatkan username (jika tersedia dalam payload JWT)
        final parts = storedToken.split('.');
        if (parts.length == 3) {
          final payload = utf8.decode(
            base64Url.decode(base64Url.normalize(parts[1])),
          );
          final payloadMap = json.decode(payload);
          setState(() {
            userName = payloadMap['username'] ?? 'User'; // Default username
          });
        }
      }
    } catch (e) {
      debugPrint('Error loading token: $e');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Tambahkan logika navigasi di sini
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LeafyQuiz()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LeafyQuiz()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ScanPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LeafyGarden()),
        );
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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Konten Utama
          SingleChildScrollView(
            child: Column(
              children: [
                // Top Bar Widget
                const SizedBox(height: 50),
                TopbarHomepage(
                  greeting: "Hello,",
                  userName: userName ?? 'Loading...', // Tampilkan username
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
