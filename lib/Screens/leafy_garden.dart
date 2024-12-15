import 'package:flutter/material.dart';
import 'package:leafyfun/Screens/history_page.dart';
import 'package:leafyfun/Screens/homepage.dart';
import 'package:leafyfun/Screens/leafy_quiz.dart';
import 'package:leafyfun/Screens/profile.dart';
import 'package:leafyfun/Screens/scan_page.dart';
import 'package:leafyfun/Widgets/floating_navbar.dart';
import 'package:leafyfun/providers/user_provider.dart';
import 'package:leafyfun/widgets/plantCard.dart';
import 'package:provider/provider.dart';

class LeafyGarden extends StatefulWidget {
  const LeafyGarden({super.key});

  @override
  State<LeafyGarden> createState() => _LeafyGardenState();
}

class _LeafyGardenState extends State<LeafyGarden> {
  int _selectedIndex = 3;
  List<dynamic> userPlants = [];
  bool _isDataInitialized = false;

  // List data tanaman dan gambar
  final List<Map<String, String>> _plants = [
    {
      'plantName': 'Mango',
      'imagePath': 'assets/images/tomato_plants.jpg',
    },
    {
      'plantName': 'Orange',
      'imagePath': 'assets/images/apple_plants.jpg',
    },
    {
      'plantName': 'Apple',
      'imagePath': 'assets/images/cherry_plants.jpg',
    },
    {
      'plantName': 'Mango',
      'imagePath': 'assets/images/grape_plants.jpg',
    },
    {
      'plantName': 'Mango',
      'imagePath': 'assets/images/strawberry_plants.jpg',
    },
    {
      'plantName': 'Mango',
      'imagePath': 'assets/images/tomato_plants.jpg',
    },
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
      await userProvider.checkUserPlant(userId);

      // Perbarui userPlants hanya setelah data diterima
      setState(() {
        userPlants = userProvider.userPlant;
      });
    }
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return; // Avoid navigating to the same page

    setState(() {
      _selectedIndex = index;
    });

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
          MaterialPageRoute(builder: (context) => const LeafyGarden()),
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
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Garden',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    icon: Image.asset(
                      'assets/images/history_logo.png',
                      width: 40,
                      height: 40,
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HistoryPage()),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'You have ${userPlants.length} plants.',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),
              userPlants.isEmpty
                  ? Center(
                      child: Text(
                        'No plants found.',
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: userPlants.length,
                        itemBuilder: (context, index) {
                          final plant = userPlants[index];
                          final plantId = _plants[plant['plant_id']];
                          return PlantCard(
                              plantName: plant['common_name'] ?? 'Unknown',
                              imagePath: plantId['imagePath'] ??
                                  'assets/images/apple_garden.png');
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
        child: Material(
          borderRadius: BorderRadius.circular(35),
          child: FloatingNavigationButtonBar(
            currentIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
