import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:leafyfun/Screens/leafyGarden.dart';
import 'package:leafyfun/Screens/leafyQuiz.dart';
import 'package:leafyfun/Screens/profile.dart';
import 'package:leafyfun/Screens/scanPage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:leafyfun/widgets/NewAddedPlant.dart';
import 'package:leafyfun/widgets/article_slider.dart';
import 'package:leafyfun/widgets/floating_navbar.dart';
import 'package:leafyfun/widgets/topbar_homepage.dart';
import 'package:leafyfun/providers/user_provider.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  int _selectedIndex = 0;
  List<dynamic> plants = [];
  bool hasUserPlant = false;
  bool _isDataInitialized = false;

  // Gambar static untuk ditampilkan
  final List<String> staticImages = [
    'assets/images/plants1.png',
    'assets/images/plants1.png',
    'assets/images/plants1.png',
    'assets/images/plants1.png',
    'assets/images/plants1.png',
  ];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Pastikan data selalu diperbarui ketika halaman diaktifkan kembali
    if (!_isDataInitialized) {
      _initializeData();
    }
  }


  Future<void> _initializeData() async {
    if (_isDataInitialized) return;
    _isDataInitialized = true;

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.loadUserInfo();
    final userId = userProvider.userId;
    if (userId != null) {
      hasUserPlant = await userProvider.checkUserPlant(userId);
    }
    await fetchPlants();
  }


  Future<void> fetchPlants() async {
    try {
      final response = await http.get(
        Uri.parse('${dotenv.env['ENDPOINT_URL']}/plants/'),
        headers: {
          'ngrok-skip-browser-warning':
              'true', // Menambahkan header ini untuk menghindari halaman warning
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          plants = data;
        });
      } else {
        debugPrint('Failed to fetch plants');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void _onItemTapped(int index) {
  if (_selectedIndex == index) return;

  setState(() {
    _selectedIndex = index;
  });

  if ((index == 1 || index == 3) && !hasUserPlant) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Akses Ditolak'),
        content: const Text(
            'Silakan tambahkan tanaman ke garden dengan melakukan scan terlebih dahulu.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    return;
  }
    // Tambahkan logika navigasi di sini
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePageScreen()),
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
    final userName = Provider.of<UserProvider>(context).userName ?? 'Loading...';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Konten Utama
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                TopbarHomepage(
                  greeting: "Hello,",
                  userName: userName,
                  profileImagePath: 'assets/images/profilePicture.png',
                ),
                const SizedBox(height: 20),

                // ArticleSlider
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: const Text(
                        'Article',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ArticleSlider(),
                  ],
                ),
                const SizedBox(height: 30),

                // New Added Plants
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: const Text(
                    'New Added Plants',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: List.generate(
                    plants.length,
                    (index) {
                      final plant = plants[index];
                      return NewAddedPlantItem(
                        plantName: plant['common_name'] ?? 'Unknown Plant',
                        plantImage: staticImages[index % staticImages.length], // Gambar static
                        plantDescription: plant['region'] ?? 'No description available',
                      );
                    },
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),

          // Floating Navigation Bar
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
