// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';

class Small_Buttons extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onPressedWithContext;
  final IconData? icon;
  final double? widthFactor;

  Small_Buttons(
      {super.key,
      this.onPressed,
      this.onPressedWithContext,
      this.icon,
      this.widthFactor});

  @override
  Widget build(BuildContext context) {
    final widthFactor = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(
              widthFactor <= 414
                  ? widthFactor * 0.05
                  : widthFactor <= 810
                      ? widthFactor * 0.12
                      : widthFactor * 0.12,
              widthFactor <= 414
                  ? widthFactor * 0.12
                  : widthFactor <= 810
                      ? widthFactor * 0.08
                      : widthFactor * 0.08,
            ),
            backgroundColor: const Color.fromARGB(255, 100, 7, 223),
            shadowColor: Colors.grey,
            elevation: widthFactor <= 414
                ? widthFactor * 0.005
                : widthFactor <= 810
                    ? widthFactor * 0.005
                    : widthFactor * 0.005,
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
            size: widthFactor <= 414
                ? widthFactor * 0.05
                : widthFactor <= 810
                    ? widthFactor * 0.03
                    : widthFactor * 0.03,
          ),
        ),
      ],
    );
  }
}
