import 'package:flutter/material.dart';
import 'package:leafyfun/Screens/historyPage.dart';
import 'package:leafyfun/Screens/homepage.dart';
import 'package:leafyfun/Screens/leafyQuiz.dart';
import 'package:leafyfun/Screens/profile.dart';
import 'package:leafyfun/Screens/scanPage.dart';
import 'package:leafyfun/Widgets/floating_navbar.dart';
import 'package:leafyfun/widgets/plantCard.dart';

class LeafyGarden extends StatefulWidget {
  const LeafyGarden({super.key});

  @override
  State<LeafyGarden> createState() => _LeafyGardenState();
}

class _LeafyGardenState extends State<LeafyGarden> {
  int _selectedIndex = 3;

  // List data tanaman dan gambar
  final List<Map<String, String>> _plants = [
    {
      'plantName': 'Orange',
      'imagePath': 'assets/images/orange_garden.png',
    },
    {
      'plantName': 'Apple',
      'imagePath': 'assets/images/apple_garden.png',
    },
    {
      'plantName': 'Mango',
      'imagePath': 'assets/images/plants3.png',
    },
  ];

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
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
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: const Text(
                  'You have 3 plants.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: _plants.length,
                  itemBuilder: (context, index) {
                    return PlantCard(
                      plantName: _plants[index]['plantName']!,
                      imagePath: _plants[index]['imagePath']!,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
            bottom: 15, left: 20, right: 20), // Space di bawah
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
