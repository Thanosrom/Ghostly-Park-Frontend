import 'package:flutter/material.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//Main
import 'package:ghostlypark/main.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Utils/load_save_language.dart';
//Components
import 'package:ghostlypark/src/View/Components/Big_Buttons.dart';
import 'package:ghostlypark/src/View/Components/Height_Spacer.dart';
import 'package:ghostlypark/src/View/Components/Big_Texts.dart';
//Theme
import 'package:ghostlypark/src/View/Theme/Layout.dart';

class Error extends StatefulWidget {
  const Error({Key? key}) : super(key: key);

  @override
  _ErrorState createState() => _ErrorState();
}

class _ErrorState extends State<Error> {
  //Languages
  String? current_locale;

  @override
  void initState() {
    super.initState();
    load_Selected_Language().then((value) {
      setState(() {
        current_locale = value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: ContainerStyles.gradientBoxDecoration,
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.error,
                  size: screenWidth <= 414
                      ? screenWidth * 0.3
                      : screenWidth <= 810
                          ? screenWidth * 0.2
                          : screenWidth * 0.2,
                  color: Colors.red,
                ),
                Height_Spacer(),
                Padding(
                  padding: EdgeInsets.only(
                    right: screenWidth <= 414
                        ? screenWidth * 0.05
                        : screenWidth <= 810
                            ? screenWidth * 0.05
                            : screenWidth * 0.05,
                    left: screenWidth <= 414
                        ? screenWidth * 0.05
                        : screenWidth <= 810
                            ? screenWidth * 0.05
                            : screenWidth * 0.05,
                  ),
                  child: Big_Texts(
                    bigText: AppLocale.getString(
                        context, AppLocale.error_big_text_1,
                        languageCode: current_locale),
                  ),
                ),
                Height_Spacer(),
                Height_Spacer(),
                Height_Spacer(),
                Padding(
                  padding: EdgeInsets.only(
                    right: screenWidth <= 414
                        ? screenWidth * 0.05
                        : screenWidth <= 810
                            ? screenWidth * 0.05
                            : screenWidth * 0.05,
                    left: screenWidth <= 414
                        ? screenWidth * 0.05
                        : screenWidth <= 810
                            ? screenWidth * 0.05
                            : screenWidth * 0.05,
                    bottom: screenWidth <= 414
                        ? screenWidth * 0.05
                        : screenWidth <= 810
                            ? screenWidth * 0.05
                            : screenWidth * 0.05,
                  ),
                  child: Big_Texts(
                    bigText: AppLocale.getString(
                        context, AppLocale.error_big_text_2,
                        languageCode: current_locale),
                  ),
                ),
                Height_Spacer(),
                Height_Spacer(),
                Height_Spacer(),
                Big_Button(
                  buttonText: AppLocale.getString(
                      context, AppLocale.reload_big_button,
                      languageCode: current_locale),
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new MyApp()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
