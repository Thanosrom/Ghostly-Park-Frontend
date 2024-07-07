// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';

class Custom_Card extends StatelessWidget {
  final Widget child;

  Custom_Card({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        screenWidth <= 414
            ? screenWidth * 0.05
            : screenWidth <= 810
                ? screenWidth * 0.1
                : screenWidth * 0.1,
        screenWidth <= 414
            ? screenWidth * 0.01
            : screenWidth <= 810
                ? screenWidth * 0.01
                : screenWidth * 0.01,
        screenWidth <= 414
            ? screenWidth * 0.05
            : screenWidth <= 810
                ? screenWidth * 0.1
                : screenWidth * 0.1,
        screenWidth <= 414
            ? screenWidth * 0.01
            : screenWidth <= 810
                ? screenWidth * 0.01
                : screenWidth * 0.01,
      ),
      child: child,
    );
  }
}
