// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
//.env
import 'package:flutter_dotenv/flutter_dotenv.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Utils/load_save_language.dart';
//Components
import 'package:ghostlypark/src/View/Components/Height_Spacer.dart';
//Libs
import 'package:webview_flutter/webview_flutter.dart';

class Privacy_Policy_And_Terms extends StatefulWidget {
  const Privacy_Policy_And_Terms({super.key});

  @override
  _Privacy_Policy_And_Terms_State createState() =>
      _Privacy_Policy_And_Terms_State();
}

class _Privacy_Policy_And_Terms_State extends State<Privacy_Policy_And_Terms> {
  //Variables
  late WebViewController controller;
  //Languages
  String? current_locale;

  void initState() {
    super.initState();
    controller = WebViewController();
    controller.loadRequest(
        Uri.parse('${dotenv.env['baseUrl']}/privacy_Policy_And_Terms'));
    load_Selected_Language().then((value) {
      setState(() {
        current_locale = value;
      });
    });
  }

  void onPressed(bool agreed) {
    Navigator.pop(context, agreed);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocale.getString(context, AppLocale.privacy_policy_text,
              languageCode: current_locale),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: WebViewWidget(
                controller: controller,
              ),
            ),
          ),
          Height_Spacer(),
          Container(
            width: screenWidth <= 414
                ? screenWidth * 0.4
                : screenWidth <= 810
                    ? screenWidth * 0.4
                    : screenWidth * 0.4,
            height: screenWidth <= 414
                ? screenWidth * 0.1
                : screenWidth <= 810
                    ? screenWidth * 0.07
                    : screenWidth * 0.07,
            child: ElevatedButton(
              onPressed: () => onPressed(true),
              child: Text(
                AppLocale.getString(context, AppLocale.agree_text,
                    languageCode: current_locale),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: screenWidth <= 414
                      ? screenWidth * 0.04
                      : screenWidth <= 810
                          ? screenWidth * 0.04
                          : screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
          Height_Spacer(),
          Container(
            width: screenWidth <= 414
                ? screenWidth * 0.4
                : screenWidth <= 810
                    ? screenWidth * 0.4
                    : screenWidth * 0.4,
            height: screenWidth <= 414
                ? screenWidth * 0.1
                : screenWidth <= 810
                    ? screenWidth * 0.07
                    : screenWidth * 0.07,
            child: ElevatedButton(
              onPressed: () => onPressed(false),
              child: Text(
                AppLocale.getString(context, AppLocale.decline_text,
                    languageCode: current_locale),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: screenWidth <= 414
                      ? screenWidth * 0.04
                      : screenWidth <= 810
                          ? screenWidth * 0.04
                          : screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
          Height_Spacer(),
        ],
      ),
    );
  }
}
