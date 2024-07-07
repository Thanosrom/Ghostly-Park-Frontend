// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';

class Thin_White_Line extends StatelessWidget {
  final bool? settings;
  const Thin_White_Line({super.key, this.settings});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: settings!
          ? screenWidth <= 414
              ? screenWidth * 0.5
              : screenWidth <= 810
                  ? screenWidth * 0.5
                  : screenWidth * 0.5
          : screenWidth <= 414
              ? screenWidth * 0.25
              : screenWidth <= 810
                  ? screenWidth * 0.25
                  : screenWidth * 0.25,
      height: screenWidth <= 414
          ? screenWidth * 0.005
          : screenWidth <= 810
              ? screenWidth * 0.004
              : screenWidth * 0.004,
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(screenWidth <= 414
            ? screenWidth * 0.02
            : screenWidth <= 810
                ? screenWidth * 0.02
                : screenWidth * 0.02),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(0, 2),
            blurRadius: screenWidth <= 414
                ? screenWidth * 0.02
                : screenWidth <= 810
                    ? screenWidth * 0.02
                    : screenWidth * 0.02,
          ),
        ],
      ),
    );
  }
}
