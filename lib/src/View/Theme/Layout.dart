import 'package:flutter/material.dart';

class ContainerStyles {
  static const BoxDecoration gradientBoxDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color.fromARGB(255, 30, 39, 78),
        Color.fromARGB(255, 30, 39, 78),
      ],
      stops: [0, 1],
    ),
  );
}
