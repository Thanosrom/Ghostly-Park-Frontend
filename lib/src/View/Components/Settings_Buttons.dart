// ignore_for_file: sort_child_properties_last, camel_case_types
import 'package:flutter/material.dart';
//Components
import 'package:ghostlypark/src/View/Components/Small_Texts.dart';

class Settings_Buttons extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  const Settings_Buttons({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.fromLTRB(
          screenWidth <= 414
              ? screenWidth * 0.1
              : screenWidth <= 810
                  ? screenWidth * 0.1
                  : screenWidth * 0.1,
          0,
          screenWidth <= 414
              ? screenWidth * 0.1
              : screenWidth <= 810
                  ? screenWidth * 0.1
                  : screenWidth * 0.1,
          0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 100, 7, 223),
          foregroundColor: const Color.fromARGB(255, 100, 7, 223),
          fixedSize: Size(
            screenWidth <= 414
                ? screenWidth * 0.7
                : screenWidth <= 810
                    ? screenWidth * 0.6
                    : screenWidth * 0.6,
            screenWidth <= 414
                ? screenWidth * 0.15
                : screenWidth <= 810
                    ? screenWidth * 0.1
                    : screenWidth * 0.1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              screenWidth <= 414
                  ? screenWidth * 0.03
                  : screenWidth <= 810
                      ? screenWidth * 0.03
                      : screenWidth * 0.03,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: screenWidth <= 414
                  ? screenWidth * 0.065
                  : screenWidth <= 810
                      ? screenWidth * 0.05
                      : screenWidth * 0.05,
            ),
            SizedBox(
              width: screenWidth <= 414
                  ? screenWidth * 0.02
                  : screenWidth <= 810
                      ? screenWidth * 0.02
                      : screenWidth * 0.02,
            ),
            Small_Texts(
              smallText: title,
              color: Colors.white,
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
