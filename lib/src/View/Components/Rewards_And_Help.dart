// ignore_for_file: camel_case_types
//import 'dart:convert';
import 'package:flutter/material.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Utils/load_Save_Language.dart';
//Providers
import 'package:ghostlypark/src/Model/Providers%20-%20Stores/UserState.dart';
//Libs
import 'package:provider/provider.dart';
//import 'package:http/http.dart' as http;
//Components
import 'package:ghostlypark/src/View/Components/Big_Texts.dart';
import 'package:ghostlypark/src/View/Components/Modals/Help_Modal.dart';
import 'package:ghostlypark/src/View/Components/Small_Texts.dart';

class Reward_And_help extends StatefulWidget {
  const Reward_And_help({super.key});

  @override
  _Reward_And_help_State createState() => _Reward_And_help_State();
}

class _Reward_And_help_State extends State<Reward_And_help>
    with TickerProviderStateMixin {
  //Animations
  bool animate = true;
  late AnimationController controller;
  //Languages
  String? current_locale;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat();
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
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: screenWidth <= 414
              ? screenWidth * 0.15
              : screenWidth <= 810
                  ? screenWidth * 0.11
                  : screenWidth * 0.1,
          height: screenWidth <= 414
              ? screenWidth * 0.15
              : screenWidth <= 810
                  ? screenWidth * 0.11
                  : screenWidth * 0.1,
          padding: EdgeInsets.all(
            screenWidth <= 414
                ? screenWidth * 0.02
                : screenWidth <= 810
                    ? screenWidth * 0.01
                    : screenWidth * 0.02,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              screenWidth <= 414
                  ? screenWidth * 0.08
                  : screenWidth <= 810
                      ? screenWidth * 0.05
                      : screenWidth * 0.05,
            ),
            color: Colors.transparent.withOpacity(0.5),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Small_Texts(
                avoid_flex: false,
                one_line: true,
                smallText:
                    '${Provider.of<UserState>(context, listen: true).coins}',
              ),
              SizedBox(
                width: screenWidth <= 414
                    ? screenWidth * 0.01
                    : screenWidth <= 810
                        ? screenWidth * 0.01
                        : screenWidth * 0.01,
              ),
              AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(2 * 3.14 * controller.value),
                    child: child,
                  );
                },
                child: Image.asset(
                  'assets/coin.png',
                  fit: BoxFit.contain,
                  width: screenWidth <= 414
                      ? screenWidth * 0.03
                      : screenWidth <= 810
                          ? screenWidth * 0.02
                          : screenWidth * 0.02,
                  height: screenWidth <= 414
                      ? screenWidth * 0.03
                      : screenWidth <= 810
                          ? screenWidth * 0.02
                          : screenWidth * 0.02,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: screenWidth <= 414
              ? screenWidth * 0.02
              : screenWidth <= 810
                  ? screenWidth * 0.02
                  : screenWidth * 0.02,
        ),
        Container(
          width: screenWidth <= 414
              ? screenWidth * 0.15
              : screenWidth <= 810
                  ? screenWidth * 0.11
                  : screenWidth * 0.1,
          height: screenWidth <= 414
              ? screenWidth * 0.15
              : screenWidth <= 810
                  ? screenWidth * 0.11
                  : screenWidth * 0.1,
          padding: EdgeInsets.all(
            screenWidth <= 414
                ? screenWidth * 0.02
                : screenWidth <= 810
                    ? screenWidth * 0.02
                    : screenWidth * 0.02,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              screenWidth <= 414
                  ? screenWidth * 0.08
                  : screenWidth <= 810
                      ? screenWidth * 0.05
                      : screenWidth * 0.05,
            ),
            color: Colors.transparent.withOpacity(0.5),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Small_Texts(
                avoid_flex: false,
                one_line: true,
                smallText:
                    '${Provider.of<UserState>(context, listen: true).gems}',
              ),
              SizedBox(
                width: screenWidth <= 414
                    ? screenWidth * 0.01
                    : screenWidth <= 810
                        ? screenWidth * 0.01
                        : screenWidth * 0.01,
              ),
              AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(2 * 3.14 * controller.value),
                    child: child,
                  );
                },
                child: Image.asset(
                  'assets/gem.png',
                  fit: BoxFit.contain,
                  width: screenWidth <= 414
                      ? screenWidth * 0.03
                      : screenWidth <= 810
                          ? screenWidth * 0.02
                          : screenWidth * 0.02,
                  height: screenWidth <= 414
                      ? screenWidth * 0.03
                      : screenWidth <= 810
                          ? screenWidth * 0.02
                          : screenWidth * 0.02,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: screenWidth <= 414
              ? screenWidth * 0.02
              : screenWidth <= 810
                  ? screenWidth * 0.02
                  : screenWidth * 0.02,
        ),
        Container(
          width: screenWidth <= 414
              ? screenWidth * 0.15
              : screenWidth <= 810
                  ? screenWidth * 0.11
                  : screenWidth * 0.1,
          height: screenWidth <= 414
              ? screenWidth * 0.15
              : screenWidth <= 810
                  ? screenWidth * 0.11
                  : screenWidth * 0.1,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: screenWidth <= 414
                    ? screenWidth * 0.01
                    : screenWidth <= 810
                        ? screenWidth * 0.01
                        : screenWidth * 0.01,
                offset: const Offset(0, 1),
              ),
            ],
            borderRadius: BorderRadius.circular(
              screenWidth <= 414
                  ? screenWidth * 0.08
                  : screenWidth <= 810
                      ? screenWidth * 0.05
                      : screenWidth * 0.05,
            ),
            color: Color.fromARGB(255, 100, 7, 223),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.help_outline,
                  size: screenWidth <= 414
                      ? screenWidth * 0.05
                      : screenWidth <= 810
                          ? screenWidth * 0.03
                          : screenWidth * 0.03,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.transparent.withOpacity(0.2),
                        title: Center(
                          child: Big_Texts(
                            bigText: AppLocale.getString(
                                context, AppLocale.help_modal_big_text,
                                languageCode: current_locale),
                          ),
                        ),
                        content: Help_Modal(),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Colors.white70,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(
                            screenWidth <= 414
                                ? screenWidth * 0.08
                                : screenWidth <= 810
                                    ? screenWidth * 0.05
                                    : screenWidth * 0.05,
                          ),
                        ),
                      );
                    },
                  );
                },
                color: Colors.white70,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
