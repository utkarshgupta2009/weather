import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final dynamic onPressed;
  const CustomButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      color: const Color(0xffFF8911),// Complementary color to the HomeScreen background
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0), 
      elevation: 4.0, 
      child: const Text(
        "Search",
        style: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.bold),
      ), 
    );
  }
}
