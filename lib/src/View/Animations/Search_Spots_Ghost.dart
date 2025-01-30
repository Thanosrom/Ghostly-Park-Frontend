// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Utils/load_Save_Language.dart';
//Components
import 'package:ghostlypark/src/View/Components/ClipperC.dart';
import 'package:ghostlypark/src/View/Components/Small_Texts.dart';

class Search_Spots_Ghost extends StatefulWidget {
  const Search_Spots_Ghost({super.key});

  @override
  Search_Spots_Ghost_State createState() => Search_Spots_Ghost_State();
}

class Search_Spots_Ghost_State extends State<Search_Spots_Ghost>
    with TickerProviderStateMixin {
  //Animations
  late AnimationController controller;
  bool animate = true;
  int currentIndex = 0;
  bool showGhost = true;
  bool showCloud = true;
  bool show_open_door = false;
  bool show_closed_door = false;

  //Languages
  String? current_locale;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..addStatusListener((status) async {
            if (status == AnimationStatus.completed) {
              setState(() {
                showGhost = false;
                showCloud = false;
                show_open_door = true;
              });
              await Future.delayed(Duration(milliseconds: 1000));
              if (mounted) {
                setState(() {
                  showGhost = false;
                  showCloud = false;
                  show_open_door = false;
                  show_closed_door = true;
                });
              }
              await Future.delayed(Duration(milliseconds: 1000));
              if (mounted) {
                setState(() {
                  show_closed_door = false;
                });
              }
              await Future.delayed(Duration(milliseconds: 1000));
            }
          });
    controller.forward();
    load_Selected_Language().then((value) {
      setState(() {
        current_locale = value;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.translationValues(
            10 * (controller.value) * 2,
            -10 * (controller.value) * 2,
            0,
          ),
          child: child,
        );
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Visibility(
              visible: showGhost,
              child: Image.asset(
                'assets/ghost_1.png',
                fit: BoxFit.contain,
                width: screenWidth <= 414
                    ? screenWidth * 0.125
                    : screenWidth <= 810
                        ? screenWidth * 0.1
                        : screenWidth * 0.1,
                height: screenWidth <= 414
                    ? screenWidth * 0.125
                    : screenWidth <= 810
                        ? screenWidth * 0.1
                        : screenWidth * 0.1,
              ),
            ),
            Visibility(
              visible: showCloud,
              child: Stack(
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipPath(
                          clipper: ClipperC(),
                          child: Container(
                            padding: EdgeInsets.all(
                              screenWidth <= 414
                                  ? screenWidth * 0.01
                                  : screenWidth <= 810
                                      ? screenWidth * 0.01
                                      : screenWidth * 0.01,
                            ),
                            width: screenWidth <= 414
                                ? screenWidth * 0.6
                                : screenWidth <= 810
                                    ? screenWidth * 0.5
                                    : screenWidth * 0.5,
                            height: screenWidth <= 414
                                ? screenWidth * 0.14
                                : screenWidth <= 810
                                    ? screenWidth * 0.1
                                    : screenWidth * 0.1,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                            ),
                            child: Center(
                              child: Small_Texts(
                                avoid_flex: true,
                                smallText: AppLocale.getString(
                                    context, AppLocale.searching_small_text,
                                    languageCode: current_locale),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: show_open_door,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(
                    screenWidth <= 414
                        ? screenWidth * 0.05
                        : screenWidth <= 810
                            ? screenWidth * 0.04
                            : screenWidth * 0.04,
                  ),
                  border: Border.all(
                    color: const Color.fromARGB(255, 100, 7, 223),
                    width: screenWidth <= 414
                        ? screenWidth * 0.003
                        : screenWidth <= 810
                            ? screenWidth * 0.003
                            : screenWidth * 0.003,
                  ),
                ),
                width: screenWidth <= 414
                    ? screenWidth * 0.22
                    : screenWidth <= 810
                        ? screenWidth * 0.2
                        : screenWidth * 0.2,
                height: screenWidth <= 414
                    ? screenWidth * 0.22
                    : screenWidth <= 810
                        ? screenWidth * 0.2
                        : screenWidth * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/open_door.png',
                      fit: BoxFit.contain,
                      width: screenWidth <= 414
                          ? screenWidth * 0.12
                          : screenWidth <= 810
                              ? screenWidth * 0.1
                              : screenWidth * 0.1,
                      height: screenWidth <= 414
                          ? screenWidth * 0.12
                          : screenWidth <= 810
                              ? screenWidth * 0.1
                              : screenWidth * 0.1,
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: show_closed_door,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(
                    screenWidth <= 414
                        ? screenWidth * 0.05
                        : screenWidth <= 810
                            ? screenWidth * 0.04
                            : screenWidth * 0.04,
                  ),
                  border: Border.all(
                    color: const Color.fromARGB(255, 100, 7, 223),
                    width: screenWidth <= 414
                        ? screenWidth * 0.003
                        : screenWidth <= 810
                            ? screenWidth * 0.003
                            : screenWidth * 0.003,
                  ),
                ),
                width: screenWidth <= 414
                    ? screenWidth * 0.22
                    : screenWidth <= 810
                        ? screenWidth * 0.2
                        : screenWidth * 0.2,
                height: screenWidth <= 414
                    ? screenWidth * 0.22
                    : screenWidth <= 810
                        ? screenWidth * 0.2
                        : screenWidth * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/closed_door.png',
                      fit: BoxFit.contain,
                      width: screenWidth <= 414
                          ? screenWidth * 0.12
                          : screenWidth <= 810
                              ? screenWidth * 0.1
                              : screenWidth * 0.1,
                      height: screenWidth <= 414
                          ? screenWidth * 0.12
                          : screenWidth <= 810
                              ? screenWidth * 0.1
                              : screenWidth * 0.1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
