import 'package:flutter/material.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//Libs
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Utils/load_Save_Language.dart';
//Components
import 'package:ghostlypark/src/View/Components/Big_Buttons.dart';
import 'package:ghostlypark/src/View/Components/Height_Spacer.dart';
import 'package:ghostlypark/src/View/Components/Big_Texts.dart';
//Theme
import 'package:ghostlypark/src/View/Theme/Layout.dart';

class Update extends StatefulWidget {
  @override
  _Update_State createState() => _Update_State();
}

class _Update_State extends State<Update> {
  // String? version;
  // bool _requiresUpdate = false;
  String? current_locale;
  String selected_language = 'en';

  @override
  void initState() {
    super.initState();
    //_checkForUpdate();

    @override
    void initState() {
      super.initState();
      //Privacy Load
      load_Selected_Language().then((value) {
        setState(() {
          current_locale = value;
        });
      });
    }
  }

  Future<void> _launchPlayStore() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final String packageName = packageInfo.packageName;
    try {
      final Uri uri = Uri(
        scheme: 'https',
        host: 'play.google.com',
        path: '/store/apps/details',
        queryParameters: {'id': packageName},
      );
      await launchUrl(uri);
    } catch (e) {}
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
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
                  context, AppLocale.update_required_big_text,
                  languageCode: current_locale),
            ),
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
              bottom: screenWidth <= 414
                  ? screenWidth * 0.05
                  : screenWidth <= 810
                      ? screenWidth * 0.05
                      : screenWidth * 0.05,
            ),
            child: Big_Texts(
              bigText: AppLocale.getString(
                  context, AppLocale.new_version_big_text,
                  languageCode: current_locale),
            ),
          ),
          Height_Spacer(),
          Big_Button(
            onPressed: () async {
              await _launchPlayStore();
            },
            buttonText: AppLocale.getString(
                context, AppLocale.update_now_big_button,
                languageCode: current_locale),
          ),
        ],
      ),
    ));
  }
}
