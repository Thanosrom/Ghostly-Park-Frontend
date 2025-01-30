// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';

class Small_Texts extends StatelessWidget {
  final String smallText;
  final Color? color;
  final bool? center;
  final bool? one_line;
  final bool? avoid_flex;
  final List<TextSpan>? textSpans;

  Small_Texts(
      {super.key,
      required this.smallText,
      this.color,
      this.center,
      this.one_line,
      this.avoid_flex,
      this.textSpans});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (textSpans == null) {
      return DefaultTextStyle(
          style: TextStyle(
            fontSize: screenWidth <= 414
                ? screenWidth * 0.035
                : screenWidth <= 810
                    ? screenWidth * 0.025
                    : screenWidth * 0.025,
            color: color,
            fontWeight: FontWeight.bold,
          ),
          child: avoid_flex == true
              ? Text(
                  smallText,
                  overflow: one_line == true ? TextOverflow.ellipsis : null,
                  maxLines: one_line == true ? 1 : 10,
                  textAlign:
                      center == true ? TextAlign.center : TextAlign.start,
                  style: TextStyle(
                    fontSize: screenWidth <= 414
                        ? screenWidth * 0.035
                        : screenWidth <= 810
                            ? screenWidth * 0.025
                            : screenWidth * 0.025,
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Flexible(
                  child: Text(
                    smallText,
                    overflow: TextOverflow.ellipsis,
                    maxLines: one_line == true ? 1 : 10,
                    textAlign:
                        center == true ? TextAlign.center : TextAlign.start,
                    style: TextStyle(
                      fontSize: screenWidth <= 414
                          ? screenWidth * 0.035
                          : screenWidth <= 810
                              ? screenWidth * 0.025
                              : screenWidth * 0.025,
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ));
    } else {
      return DefaultTextStyle(
        style: TextStyle(
          fontSize: screenWidth <= 414
              ? screenWidth * 0.035
              : screenWidth <= 810
                  ? screenWidth * 0.025
                  : screenWidth * 0.025,
          color: color,
          fontWeight: FontWeight.bold,
        ),
        child: avoid_flex == true
            ? Text.rich(
                TextSpan(children: textSpans),
                overflow: one_line == true ? TextOverflow.ellipsis : null,
                maxLines: one_line == true ? 1 : 10,
                textAlign: center == true ? TextAlign.center : TextAlign.start,
                style: TextStyle(
                  fontSize: screenWidth <= 414
                      ? screenWidth * 0.035
                      : screenWidth <= 810
                          ? screenWidth * 0.025
                          : screenWidth * 0.025,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              )
            : Flexible(
                child: Text.rich(
                  TextSpan(children: textSpans),
                  overflow: TextOverflow.ellipsis,
                  maxLines: one_line == true ? 1 : 10,
                  textAlign:
                      center == true ? TextAlign.center : TextAlign.start,
                  style: TextStyle(
                    fontSize: screenWidth <= 414
                        ? screenWidth * 0.035
                        : screenWidth <= 810
                            ? screenWidth * 0.025
                            : screenWidth * 0.025,
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      );
    }
  }
}
