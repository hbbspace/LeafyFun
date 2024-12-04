import 'package:flutter/material.dart';

class TopbarQuiz extends StatelessWidget {
  final String greeting;
  final String userName;
  final String profileImagePath;

  const TopbarQuiz({
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
