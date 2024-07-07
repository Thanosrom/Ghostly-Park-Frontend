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

class Recovery_Password_1 extends StatefulWidget {
  const Recovery_Password_1({super.key});

  @override
  _Recovery_Password_State createState() => _Recovery_Password_State();
}

class _Recovery_Password_State extends State<Recovery_Password_1> {
  //Text Controllers
  final TextEditingController emailController = TextEditingController();

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
    emailController.dispose();
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
                      context, AppLocale.forgot_your_password_big_text,
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
                        themeController: emailController,
                        havePassword: false,
                        labelTexts: AppLocale.getString(
                            context, AppLocale.email_textfield,
                            languageCode: current_locale),
                        icon: Icons.email,
                        autofillHints: [AutofillHints.email],
                      ),
                      Height_Spacer(),
                      Height_Spacer(),
                      Height_Spacer(),
                      Big_Button(
                          buttonText: AppLocale.getString(
                              context, AppLocale.recovery_password_big_button,
                              languageCode: current_locale),
                          onPressed: () async {
                            if (await handle_Button_Click(
                                'Recovery_Password_1')) {
                              send_Digits_To_Recovery_Email(
                                  context, emailController.text);
                              //emailController.clear();
                            }
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
