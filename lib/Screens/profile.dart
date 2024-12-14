import 'package:flutter/material.dart';
import 'package:leafyfun/Screens/edit_profile.dart';
import 'package:leafyfun/Screens/homepage.dart';
import 'package:leafyfun/Screens/leafy_garden.dart';
import 'package:leafyfun/Screens/leafy_quiz.dart';
import 'package:leafyfun/Screens/scan_page.dart';
import 'package:leafyfun/providers/user_provider.dart';
import 'package:leafyfun/widgets/activity_button.dart';
import 'package:leafyfun/widgets/floating_navbar.dart';
import 'package:leafyfun/widgets/logout_confirmation_dialog.dart';
import 'package:leafyfun/widgets/popup_widget.dart';
import 'package:leafyfun/widgets/profile_header.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 4;
  bool hasUserPlant = false;
  bool _isDataInitialized = false;

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
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return; // Avoid navigating to the same page

    setState(() {
      _selectedIndex = index;
    });

    if ((index == 1 || index == 3) && !hasUserPlant) {
      showDialog(
        context: context,
        builder: (context) => PopupWidget(
          title: 'Access Denied',
          desc: 'Please Scan First & Save The Plant',
          buttonText: 'OK',
          imagePath: 'assets/images/page_lock.png', // Path gambar yang sesuai
          onTap: () {
            Navigator.of(context).pop(); // Menutup dialog saat tombol ditekan
          },
        ),
      );
      _selectedIndex = 4;
      return;
    }

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePageScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LeafyQuiz()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ScanPage()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LeafyGarden()),
        );
        break;
      case 4:
        Navigator.pushReplacement(
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
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          // final userName = userProvider.userName;
          // final email = userProvider.email;
          final userName =
              Provider.of<UserProvider>(context).userName ?? 'Loading...';
          final email =
              Provider.of<UserProvider>(context).email ?? 'Loading...';

          // // Jika username atau email masih null, tampilkan loading indicator
          // if (userName == null || email == null) {
          //   return const Center(child: CircularProgressIndicator());
          // }

          return Stack(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                    left: 30,
                    right: 30,
                  ),
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
                                builder: (context) => EditProfilePage(
                                  initialUsername: userName,
                                  initialEmail: email,
                                ),
                              ),
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
          );
        },
      ),
    );
  }
}
