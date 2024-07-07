// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
//.env
import 'package:flutter_dotenv/flutter_dotenv.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//Routes
import 'package:ghostlypark/src/Controller/Routes/Routes.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Utils/load_Save_Language.dart';
//Components
import 'package:ghostlypark/src/View/Components/Small_Texts.dart';
import 'package:ghostlypark/src/View/Components/Height_Spacer.dart';
import 'package:ghostlypark/src/View/Components/Settings_Modals_Buttons.dart';
//Libs
import 'package:http/http.dart' as http;
//Headers
import 'package:ghostlypark/src/Model/Headers.dart';

class Police_Ghost extends StatefulWidget {
  const Police_Ghost({super.key});

  @override
  PoliceGhost_State createState() => PoliceGhost_State();
}

class PoliceGhost_State extends State<Police_Ghost> {
  Future<http.Response> minus_5_Coins_Model() async {
    try {
      final response = await http.put(
          Uri.parse('${dotenv.env['baseUrl']}/minus_5_Coins'),
          headers: await token_Headers());
      return response;
    } catch (error) {
      return http.Response('Error occurred', 400);
    }
  }

  //Languages
  String? current_locale;

  void initState() {
    super.initState();
    load_Selected_Language().then((value) {
      setState(() {
        current_locale = value;
      });
    });
    minus_5_Coins_Model();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      backgroundColor: Colors.red,
      child: Container(
        alignment: Alignment.center,
        width: screenWidth <= 414
            ? screenWidth * 0.5
            : screenWidth <= 810
                ? screenWidth * 0.5
                : screenWidth * 0.5,
        height: screenWidth <= 414
            ? screenWidth * 1
            : screenWidth <= 810
                ? screenWidth * 0.7
                : screenWidth * 0.7,
        padding: EdgeInsets.all(
          screenWidth <= 414
              ? screenWidth * 0.02
              : screenWidth <= 810
                  ? screenWidth * 0.02
                  : screenWidth * 0.02,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              screenWidth <= 414
                  ? screenWidth * 0.1
                  : screenWidth <= 810
                      ? screenWidth * 0.1
                      : screenWidth * 0.1,
            ),
          ),
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.9),
              offset: Offset(0, 4),
              blurRadius: screenWidth <= 414
                  ? screenWidth * 0.01
                  : screenWidth <= 810
                      ? screenWidth * 0.01
                      : screenWidth * 0.01,
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Small_Texts(
                avoid_flex: true,
                center: true,
                smallText: AppLocale.getString(
                    context, AppLocale.ghostly_park_police_small_text,
                    languageCode: current_locale),
              ),
              Height_Spacer(),
              Image.asset(
                'assets/ghost_police.png',
                fit: BoxFit.contain,
                width: screenWidth <= 414
                    ? screenWidth * 0.2
                    : screenWidth <= 810
                        ? screenWidth * 0.15
                        : screenWidth * 0.15,
                height: screenWidth <= 414
                    ? screenWidth * 0.2
                    : screenWidth <= 810
                        ? screenWidth * 0.15
                        : screenWidth * 0.15,
              ),
              Height_Spacer(),
              Small_Texts(
                avoid_flex: true,
                center: true,
                smallText: AppLocale.getString(
                    context, AppLocale.too_many_times_small_text,
                    languageCode: current_locale),
              ),
              Height_Spacer(),
              Settings_Modals_Buttons(
                  onPressed: () async {
                    Navigator.pushNamed(context, AppRoutes.slash);
                  },
                  label_text: AppLocale.getString(context, AppLocale.close_text,
                      languageCode: current_locale),
                  its_error: true),
            ],
          ),
        ),
      ),
    );
  }
}
