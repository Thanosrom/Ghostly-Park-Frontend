// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';

class Height_Spacer extends StatelessWidget {
  const Height_Spacer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      height: screenWidth <= 414
          ? screenWidth * 0.02
          : screenWidth <= 810
              ? screenWidth * 0.02
              : screenWidth * 0.02,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
