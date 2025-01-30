// ignore_for_file: file_names
import 'package:flutter/material.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Settings.dart';
import 'package:ghostlypark/src/Controller/Utils/load_save_language.dart';
import 'package:ghostlypark/src/Controller/Utils/Go_Back.dart';
//Components
import 'package:ghostlypark/src/View/Components/Height_Spacer.dart';
import 'package:ghostlypark/src/View/Components/Big_Texts.dart';
import 'package:ghostlypark/src/View/Components/Settings_Buttons.dart';
//Theme
import 'package:ghostlypark/src/View/Theme/Layout.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
                Big_Texts(
                  bigText: AppLocale.getString(
                      context, AppLocale.user_settings_big_text,
                      languageCode: current_locale),
                ),
                Height_Spacer(),
                Height_Spacer(),
                Height_Spacer(),
                Settings_Buttons(
                  title: AppLocale.getString(
                      context, AppLocale.change_username_big_button,
                      languageCode: current_locale),
                  icon: Icons.person,
                  onPressed: () {
                    change_Username(context);
                  },
                ),
                Height_Spacer(),
                Settings_Buttons(
                  title: AppLocale.getString(
                      context, AppLocale.change_password_big_button,
                      languageCode: current_locale),
                  icon: Icons.lock,
                  onPressed: () {
                    change_Password(context);
                  },
                ),
                Height_Spacer(),
                Settings_Buttons(
                  title: AppLocale.getString(
                      context, AppLocale.change_carInfo_big_button,
                      languageCode: current_locale),
                  icon: Icons.car_crash_outlined,
                  onPressed: () {
                    change_CarInfo(context);
                  },
                ),
                Height_Spacer(),
                Settings_Buttons(
                  title: AppLocale.getString(
                      context, AppLocale.delete_account_big_button,
                      languageCode: current_locale),
                  icon: Icons.delete,
                  onPressed: () {
                    delete_User(context);
                  },
                ),
                Height_Spacer(),
                Settings_Buttons(
                  title: AppLocale.getString(context, AppLocale.back_button,
                      languageCode: current_locale),
                  icon: Icons.arrow_back,
                  onPressed: () {
                    Go_Back(context);
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
