import 'package:flutter/material.dart';
//Components
import 'package:ghostlypark/src/View/Components/Small_Texts.dart';

void Toast_Message(BuildContext context, String message) {
  double screenWidth = MediaQuery.of(context).size.width;
  final overlay = Overlay.of(context);
  OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned.fill(
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: screenWidth <= 414
              ? screenWidth * 0.65
              : screenWidth <= 810
                  ? screenWidth * 0.5
                  : screenWidth * 0.5,
          height: screenWidth <= 414
              ? screenWidth * 0.17
              : screenWidth <= 810
                  ? screenWidth * 0.12
                  : screenWidth * 0.12,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.9),
            borderRadius: BorderRadius.circular(
              screenWidth <= 414
                  ? screenWidth * 0.03
                  : screenWidth <= 810
                      ? screenWidth * 0.03
                      : screenWidth * 0.03,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: screenWidth <= 414
                          ? screenWidth * 0.01
                          : screenWidth <= 810
                              ? screenWidth * 0.01
                              : screenWidth * 0.01,
                      left: screenWidth <= 414
                          ? screenWidth * 0.01
                          : screenWidth <= 810
                              ? screenWidth * 0.01
                              : screenWidth * 0.01,
                    ),
                    child: Small_Texts(
                        center: true, avoid_flex: true, smallText: message),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}
