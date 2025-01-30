// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';

class Big_Button extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final IconData? icon;
  final String? image;
  Big_Button(
      {required this.buttonText,
      required this.onPressed,
      this.icon,
      this.image});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 100, 7, 223),
              fixedSize: Size(
                screenWidth <= 414
                    ? screenWidth * 0.7
                    : screenWidth <= 810
                        ? screenWidth * 0.6
                        : screenWidth * 0.6,
                screenWidth <= 414
                    ? screenWidth * 0.14
                    : screenWidth <= 810
                        ? screenWidth * 0.1
                        : screenWidth * 0.1,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  screenWidth <= 414
                      ? screenWidth * 0.02
                      : screenWidth <= 810
                          ? screenWidth * 0.02
                          : screenWidth * 0.02,
                ),
              ),
            ),
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    color: Colors.white70,
                    size: screenWidth <= 414
                        ? screenWidth * 0.1
                        : screenWidth <= 810
                            ? screenWidth * 0.1
                            : screenWidth * 0.1,
                  ),
                if (image != null)
                  Image.asset(
                    image!,
                    fit: BoxFit.contain,
                    width: screenWidth <= 414
                        ? screenWidth * 0.05
                        : screenWidth <= 810
                            ? screenWidth * 0.05
                            : screenWidth * 0.05,
                    height: screenWidth <= 414
                        ? screenWidth * 0.1
                        : screenWidth <= 810
                            ? screenWidth * 0.1
                            : screenWidth * 0.1,
                  ),
                SizedBox(
                  width: screenWidth <= 414
                      ? screenWidth * 0.001
                      : screenWidth <= 810
                          ? screenWidth * 0.001
                          : screenWidth * 0.001,
                ),
                Flexible(
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    buttonText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth <= 414
                          ? screenWidth * 0.04
                          : screenWidth <= 810
                              ? screenWidth * 0.04
                              : screenWidth * 0.03,
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
