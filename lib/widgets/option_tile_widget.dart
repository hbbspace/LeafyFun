import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  final String text;
  final bool isSelected;

  const OptionTile({super.key, required this.text, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Color.fromRGBO(116, 169, 154, 1) : Colors.white,
          border: Border.all(
            color: isSelected ? Color.fromRGBO(149, 164, 164, 1) : Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: ListTile(
          title: Text(
            text,
            style: TextStyle(
              fontFamily: 'Poppins',
              color:
                  isSelected ? Color.fromRGBO(255, 255, 255, 1) : Colors.black,
              fontWeight: isSelected ? FontWeight.normal : FontWeight.normal,
            ),
          ),
          trailing: isSelected
              ? Icon(Icons.check_circle,
                  color: Color.fromRGBO(149, 164, 164, 1))
              : null,
        ),
      ),
    );
  }
}
