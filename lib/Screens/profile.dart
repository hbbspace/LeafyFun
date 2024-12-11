import 'package:flutter/material.dart';
import 'package:leafyfun/Screens/editProfile.dart';
import 'package:leafyfun/Screens/homepage.dart';
import 'package:leafyfun/Screens/leafyGarden.dart';
import 'package:leafyfun/Screens/leafyQuiz.dart';
import 'package:leafyfun/Screens/scanPage.dart';
import 'package:leafyfun/providers/user_provider.dart';
import 'package:leafyfun/widgets/activity_button.dart';
import 'package:leafyfun/widgets/floating_navbar.dart';
import 'package:leafyfun/widgets/logout_confirmation_dialog.dart';
import 'package:leafyfun/widgets/profile_header.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 4;

  @override
  void initState() {
    super.initState();
    // Load token and username from UserProvider
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.loadUserInfo();
    userProvider.loadUserInfo();
    userProvider.loadUserInfo();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

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
    final userName =
        Provider.of<UserProvider>(context).userName ?? 'Loading...';
    final email =
        Provider.of<UserProvider>(context).email ?? 'unknown@example.com';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 50, left: 30, right: 30, bottom: 0),
              child: Column(
                children: [
                  ProfileHeader(
                    username: userName,
                    email: email,
                    profileImage: 'assets/images/profilePicture.png',
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfilePage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 20,
                        ),
                        textStyle: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                        ),
                      ),
                      child: const Text('Edit Profile'),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Activities',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: [
                        ActivityButton(
                          title: 'Badges & Achievements',
                          borderColor: Colors.grey,
                          textColor: Colors.grey[700]!,
                          onPressed: () {},
                        ),
                        const SizedBox(height: 10),
                        ActivityButton(
                          title: 'Security',
                          borderColor: Colors.grey,
                          textColor: Colors.grey[700]!,
                          onPressed: () {},
                        ),
                        const SizedBox(height: 10),
                        ActivityButton(
                          title: 'About',
                          borderColor: Colors.grey,
                          textColor: Colors.grey[700]!,
                          onPressed: () {},
                        ),
                        const SizedBox(height: 10),
                        ActivityButton(
                          title: 'Logout',
                          borderColor: Colors.red,
                          textColor: Colors.red,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  const LogoutConfirmationDialog(),
                            );
                          },
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
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
