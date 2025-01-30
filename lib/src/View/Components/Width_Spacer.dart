import 'package:flutter/material.dart';

class Width_Spacer extends StatelessWidget {
  const Width_Spacer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth <= 414
          ? screenWidth * 0.05
          : screenWidth <= 810
              ? screenWidth * 0.05
              : screenWidth * 0.05,
    );
  }
}
