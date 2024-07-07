// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';

class Secondary_Big_Button extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final IconData? icon;

  Secondary_Big_Button(
      {super.key,
      required this.buttonText,
      required this.onPressed,
      this.icon});

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
              backgroundColor: Colors.transparent.withOpacity(0.3),
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
              mainAxisAlignment: icon != null
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              crossAxisAlignment: icon != null
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
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
                    style: TextStyle(
                      fontSize: screenWidth <= 414
                          ? screenWidth * 0.04
                          : screenWidth <= 810
                              ? screenWidth * 0.03
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
