// ignore_for_file: camel_case_types, use_build_context_synchronously
import 'package:flutter/material.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Recovery.dart';
import 'package:ghostlypark/src/Controller/Utils/Go_Back.dart';
import 'package:ghostlypark/src/Controller/Utils/Handle_Button_Clicks.dart';
import 'package:ghostlypark/src/Controller/Utils/load_save_language.dart';
//Components
import 'package:ghostlypark/src/View/Components/Big_Buttons.dart';
import 'package:ghostlypark/src/View/Components/Height_Spacer.dart';
import 'package:ghostlypark/src/View/Components/Big_Texts.dart';
import 'package:ghostlypark/src/View/Components/Custom_Card.dart';
import 'package:ghostlypark/src/View/Components/Custom_TextFields.dart';
import 'package:ghostlypark/src/View/Components/Secondary_Big_Buttons.dart';
//Theme
import 'package:ghostlypark/src/View/Theme/Layout.dart';

class Recovery_Password_3 extends StatefulWidget {
  //Variables for the constructor
  final String email;
  const Recovery_Password_3(this.email, {Key? key}) : super(key: key);

  @override
  _Recovery_Password_State createState() => _Recovery_Password_State();
}

class _Recovery_Password_State extends State<Recovery_Password_3> {
  //Text Controllers
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();
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
    passwordController.dispose();
    repeatPasswordController.dispose();
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Big_Texts(
                  bigText: AppLocale.getString(
                      context, AppLocale.enter_new_password_big_text,
                      languageCode: current_locale),
                ),
                Height_Spacer(),
                Height_Spacer(),
                Height_Spacer(),
                Custom_Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Custom_TextField(
                        themeController: passwordController,
                        havePassword: true,
                        labelTexts: AppLocale.getString(
                            context, AppLocale.password_textfield,
                            languageCode: current_locale),
                        icon: Icons.lock,
                        autofillHints: [AutofillHints.email],
                      ),
                      Height_Spacer(),
                      Height_Spacer(),
                      Custom_TextField(
                        themeController: repeatPasswordController,
                        havePassword: true,
                        labelTexts: AppLocale.getString(
                            context, AppLocale.repeat_password_textfield,
                            languageCode: current_locale),
                        icon: Icons.lock,
                        autofillHints: [AutofillHints.email],
                      ),
                      Height_Spacer(),
                      Height_Spacer(),
                      Height_Spacer(),
                      Big_Button(
                          buttonText: AppLocale.getString(
                              context, AppLocale.recovery_big_button,
                              languageCode: current_locale),
                          onPressed: () async {
                            if (await handle_Button_Click(
                                'Recovery_Password_3')) {
                              change_Password(context, passwordController.text,
                                  repeatPasswordController.text, widget.email);
                            }
                            // passwordController.clear();
                            // repeatPasswordController.clear();
                          }),
                      Height_Spacer(),
                      Secondary_Big_Button(
                        buttonText: AppLocale.getString(
                            context, AppLocale.back_button,
                            languageCode: current_locale),
                        onPressed: () => Go_Back(context),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
