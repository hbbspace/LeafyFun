import 'package:flutter/material.dart';

class ServiceGridItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const ServiceGridItem(this.icon, this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.red.shade100,
          child: Icon(icon, color: Colors.red),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}