import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const MenuItem({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Icon with a slight shadow
        Container(
          padding: const EdgeInsets.all(12.0), // Slight padding around the icon
          decoration: BoxDecoration(
            color: Colors.white, // White background for the icon
            shape: BoxShape.rectangle, // Rectangle shape
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Soft shadow
                blurRadius: 6,
                offset: const Offset(0, 3), // Shadow position
              ),
            ],
          ),
          child: Icon(
            icon,
            color:
                const Color.fromARGB(255, 255, 135, 135), // Color for the icon
            size: 32.0, // Larger icon size
          ),
        ),
        const SizedBox(height: 8), // Space between icon and text
        // Use Flexible to handle text overflow
        Flexible(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 12, // Adjust text size for readability
            ),
            overflow: TextOverflow.ellipsis, // Adds ellipsis for overflow
            maxLines: 1, // Limit to one line
          ),
        ),
      ],
    );
  }
}
