// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';

class Big_Texts extends StatelessWidget {
  final String bigText;
  Big_Texts({super.key, required this.bigText});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Text(
      bigText,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: screenWidth <= 414
            ? screenWidth * 0.08
            : screenWidth <= 810
                ? screenWidth * 0.05
                : screenWidth * 0.05,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.none,
        shadows: [
          Shadow(
            color: const Color.fromARGB(255, 100, 7, 223),
            blurRadius: screenWidth <= 414
                ? screenWidth * 0.05
                : screenWidth <= 810
                    ? screenWidth * 0.05
                    : screenWidth * 0.05,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      //  ),
    );
  }
}
