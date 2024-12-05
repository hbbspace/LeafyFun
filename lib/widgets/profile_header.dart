import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String username;
  final String email;
  final String profileImage;

  const ProfileHeader({
    required this.username,
    required this.email,
    required this.profileImage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 80,
          backgroundColor: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: Image.asset(
              profileImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          username,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          email,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
