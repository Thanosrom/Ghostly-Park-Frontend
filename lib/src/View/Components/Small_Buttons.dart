// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';

class Small_Buttons extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onPressedWithContext;
  final IconData? icon;

  Small_Buttons(
      {super.key, this.onPressed, this.onPressedWithContext, this.icon});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(
              screenWidth <= 414
                  ? screenWidth * 0.05
                  : screenWidth <= 810
                      ? screenWidth * 0.12
                      : screenWidth * 0.12,
              screenWidth <= 414
                  ? screenWidth * 0.12
                  : screenWidth <= 810
                      ? screenWidth * 0.08
                      : screenWidth * 0.08,
            ),
            backgroundColor: const Color.fromARGB(255, 100, 7, 223),
            shadowColor: Colors.grey,
            elevation: screenWidth <= 414
                ? screenWidth * 0.005
                : screenWidth <= 810
                    ? screenWidth * 0.005
                    : screenWidth * 0.005,
          ),
          onPressed: () {
            if (onPressed != null) {
              onPressed!();
            } else if (onPressedWithContext != null) {
              Future.delayed(Duration.zero, () {
                onPressedWithContext!();
              });
            }
          },
          child: Icon(
            icon,
            color: Colors.white70,
            size: screenWidth <= 414
                ? screenWidth * 0.05
                : screenWidth <= 810
                    ? screenWidth * 0.03
                    : screenWidth * 0.03,
          ),
        ),
      ],
    );
  }
}
