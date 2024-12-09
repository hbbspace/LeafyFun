import 'package:flutter/material.dart';

class TopbarHomepage extends StatelessWidget {
  final String greeting;
  final String userName;
  final String profileImagePath;

  const TopbarHomepage({
    super.key,
    required this.greeting,
    required this.userName,
    required this.profileImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
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
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  Text(
                    userName,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 5),
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
