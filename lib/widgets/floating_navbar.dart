import 'package:flutter/material.dart';

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
      decoration: BoxDecoration(
        color: const Color.fromRGBO(10, 66, 63, 1), // Warna hijau
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 10,
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // Hilangkan shadow default
        type: BottomNavigationBarType.fixed, // Style fixed
        currentIndex: currentIndex,
        onTap: onItemTapped,
        selectedItemColor: Colors.white, // Warna icon/text terpilih
        unselectedItemColor: Colors.white.withOpacity(0.7), // Warna default
        selectedLabelStyle: const TextStyle(
          fontFamily: 'Poppins  ',
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
        ),
        items: [
          BottomNavigationBarItem(
            icon: _buildNavItemIcon(
              'assets/images/navbar_home.png',
              isSelected: currentIndex == 0,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildNavItemIcon(
              'assets/images/navbar_quiz.png',
              isSelected: currentIndex == 1,
            ),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: _buildNavItemIcon(
              'assets/images/navbar_scan.png',
              isSelected: currentIndex == 2,
            ),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: _buildNavItemIcon(
              'assets/images/navbar_garden.png',
              isSelected: currentIndex == 3,
            ),
            label: 'Garden',
          ),
          BottomNavigationBarItem(
            icon: _buildNavItemIcon(
              'assets/images/navbar_profile.png',
              isSelected: currentIndex == 4,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildNavItemIcon(String assetPath, {required bool isSelected}) {
    return Container(
      padding: isSelected ? const EdgeInsets.all(6.0) : const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(360),
        border: isSelected
            ? Border.all(color: Colors.white, width: 2)
            : Border.all(color: Colors.transparent),
      ),
      child: Image.asset(
        assetPath,
        height: 25,
        width: 40,
        color: isSelected
            ? const Color.fromRGBO(10, 66, 63, 1)
            : Colors.white.withOpacity(0.7),
      ),
    );
  }
}
