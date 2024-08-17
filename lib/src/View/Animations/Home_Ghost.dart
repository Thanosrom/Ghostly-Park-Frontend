// ignore_for_file: camel_case_types
import 'dart:async';
import 'package:flutter/material.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Utils/load_Save_Language.dart';
//Components
import 'package:ghostlypark/src/View/Components/ClipperC.dart';
import 'package:ghostlypark/src/View/Components/Small_Texts.dart';

class Home_Ghost extends StatefulWidget {
  const Home_Ghost({super.key});

  @override
  Home_GhostState createState() => Home_GhostState();
}

class Home_GhostState extends State<Home_Ghost> with TickerProviderStateMixin {
  //Animations
  late AnimationController controller;
  int currentIndex = 0;
  bool animate = true;
  bool showGhost = true;
  bool showCloud = true;

  //Home Ghost Messages
  Map<String, List<String>> ghostMessages = {
    'en': AppLocale.home_ghost_small_texts_en,
    'gr': AppLocale.home_ghost_small_texts_gr,
    'sp': AppLocale.home_ghost_small_texts_sp,
    'por': AppLocale.home_ghost_small_texts_por,
    'fr': AppLocale.home_ghost_small_texts_fr,
    'de': AppLocale.home_ghost_small_texts_de,
    'ru': AppLocale.home_ghost_small_texts_ru,
    'ja': AppLocale.home_ghost_small_texts_ja,
    'ch': AppLocale.home_ghost_small_texts_ch,
  };
  List<String>? helpMessages;
  //Languages
  String? current_locale;
  //Cloud Timer
  Timer? autochange_timer;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat(reverse: true);
    load_Selected_Language().then((value) {
      setState(() {
        current_locale = value;
        helpMessages = ghostMessages[current_locale ?? 'en'] ?? [];
        start_AutoChange_Timer();
      });
    });
  }

  @override
  void dispose() {
    controller.dispose;
    autochange_timer?.cancel();
    super.dispose();
  }

  void start_AutoChange_Timer() {
    autochange_timer = Timer.periodic(Duration(seconds: 4), (timer) {
      setState(() {
        if (helpMessages != null && helpMessages!.isNotEmpty) {
          currentIndex = (currentIndex + 1) % helpMessages!.length;
          if (currentIndex == 0) {
            showGhost = false;
            showCloud = false;
            controller.stop();
            //controller.dispose();
            autochange_timer?.cancel();
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return helpMessages == null || helpMessages!.isEmpty
        ? Container()
        : AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.translationValues(
                  0,
                  7 * (controller.value) * 5,
                  0,
                ),
                child: child,
              );
            },
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (helpMessages != null && helpMessages!.isNotEmpty) {
                    currentIndex = (currentIndex + 1) % helpMessages!.length;
                    if (currentIndex == 0) {
                      showGhost = false;
                      showCloud = false;
                      controller.stop();
                      controller.dispose();
                    }
                  }
                });
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
                            ? screenWidth * 0.14
                            : screenWidth <= 810
                                ? screenWidth * 0.1
                                : screenWidth * 0.1,
                        height: screenWidth <= 414
                            ? screenWidth * 0.14
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
                                    alignment: Alignment.center,
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
                                        ? screenWidth * 0.16
                                        : screenWidth <= 810
                                            ? screenWidth * 0.1
                                            : screenWidth * 0.1,
                                    decoration: BoxDecoration(
                                      color:
                                          Colors.transparent.withOpacity(0.2),
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Small_Texts(
                                            avoid_flex: true,
                                            smallText:
                                                helpMessages![currentIndex],
                                          ),
                                        ],
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
                  ],
                ),
              ),
            ),
          );
  }
}
