import 'package:flutter/material.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//Main
import 'package:ghostlypark/main.dart';
//Components
import 'package:ghostlypark/src/View/Components/Big_Buttons.dart';
import 'package:ghostlypark/src/View/Components/Height_Spacer.dart';
import 'package:ghostlypark/src/View/Components/Big_Texts.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Utils/load_save_language.dart';
//Theme
import 'package:ghostlypark/src/View/Theme/Layout.dart';

class Maintenance extends StatefulWidget {
  const Maintenance({Key? key}) : super(key: key);

  @override
  _MaintenanceState createState() => _MaintenanceState();
}

class _MaintenanceState extends State<Maintenance> {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Big_Texts(
                  bigText: AppLocale.getString(
                      context, AppLocale.under_maintenance_big_text_1,
                      languageCode: current_locale),
                ),
                Height_Spacer(),
                Height_Spacer(),
                Height_Spacer(),
                Image.asset(
                  'assets/ghost_maintenance.png',
                  fit: BoxFit.contain,
                  width: screenWidth <= 414
                      ? screenWidth * 0.5
                      : screenWidth <= 810
                          ? screenWidth * 0.5
                          : screenWidth * 0.5,
                  height: screenWidth <= 414
                      ? screenWidth * 0.4
                      : screenWidth <= 810
                          ? screenWidth * 0.3
                          : screenWidth * 0.3,
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
                        context, AppLocale.under_maintenance_big_text_2,
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
