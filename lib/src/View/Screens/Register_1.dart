// ignore_for_file: file_names, use_build_context_synchronously
import 'package:flutter/material.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Register.dart';
import 'package:ghostlypark/src/Controller/Utils/Handle_Button_Clicks.dart';
import 'package:ghostlypark/src/Controller/Utils/Validators.dart';
import 'package:ghostlypark/src/Controller/Utils/load_save_language.dart';
import 'package:ghostlypark/src/Controller/Utils/Go_Back.dart';
//Components
import 'package:ghostlypark/src/View/Components/Big_Buttons.dart';
import 'package:ghostlypark/src/View/Components/Height_Spacer.dart';
import 'package:ghostlypark/src/View/Components/Custom_Card.dart';
import 'package:ghostlypark/src/View/Components/Secondary_Big_Buttons.dart';
import 'package:ghostlypark/src/View/Components/Custom_TextFields.dart';
import 'package:ghostlypark/src/View/Components/Big_Texts.dart';
//Screens
import 'package:ghostlypark/src/View/Screens/Register_2.dart';
//Theme Data
import 'package:ghostlypark/src/View/Theme/Layout.dart';

class Register_1 extends StatefulWidget {
  const Register_1({super.key});

  @override
  _Register_1_State createState() => _Register_1_State();
}

class _Register_1_State extends State<Register_1> {
  //Text Controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController carInfoController = TextEditingController();

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
    usernameController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    emailController.dispose();
    carInfoController.dispose();
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
                Height_Spacer(),
                Big_Texts(
                  bigText: AppLocale.getString(
                      context, AppLocale.register_big_text,
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
                        labelTexts: AppLocale.getString(
                            context, AppLocale.username_textfield,
                            languageCode: current_locale),
                        havePassword: false,
                        themeController: usernameController,
                        icon: Icons.person,
                      ),
                      Height_Spacer(),
                      Custom_TextField(
                        labelTexts: AppLocale.getString(
                            context, AppLocale.password_textfield,
                            languageCode: current_locale),
                        havePassword: true,
                        themeController: passwordController,
                        icon: Icons.lock,
                      ),
                      Height_Spacer(),
                      Custom_TextField(
                        labelTexts: AppLocale.getString(
                            context, AppLocale.repeat_password_textfield,
                            languageCode: current_locale),
                        havePassword: true,
                        themeController: repeatPasswordController,
                        icon: Icons.lock,
                      ),
                      Height_Spacer(),
                      Custom_TextField(
                        labelTexts: AppLocale.getString(
                            context, AppLocale.email_textfield,
                            languageCode: current_locale),
                        havePassword: false,
                        themeController: emailController,
                        icon: Icons.email,
                      ),
                      Height_Spacer(),
                      Custom_TextField(
                        labelTexts: AppLocale.getString(
                            context, AppLocale.carModel_textfield,
                            languageCode: current_locale),
                        havePassword: false,
                        themeController: carInfoController,
                        icon: Icons.car_rental,
                      ),
                      Height_Spacer(),
                    ],
                  ),
                ),
                Custom_Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Big_Button(
                        buttonText: AppLocale.getString(
                            context, AppLocale.register_button,
                            languageCode: current_locale),
                        onPressed: () async {
                          if (await handle_Button_Click('Register_1')) {
                            bool validate = await validate_Fields(
                                context,
                                usernameController.text,
                                passwordController.text,
                                repeatPasswordController.text,
                                emailController.text,
                                carInfoController.text);
                            if (validate == true) {
                              if (await send_Digit_Code(
                                  context, emailController.text)) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Register_2(
                                      usernameController:
                                          usernameController.text,
                                      passwordController:
                                          passwordController.text,
                                      repeatPasswordController:
                                          repeatPasswordController.text,
                                      emailController: emailController.text,
                                      carInfoController: carInfoController.text,
                                    ),
                                  ),
                                );
                              }
                              // usernameController.clear();
                              // passwordController.clear();
                              // repeatPasswordController.clear();
                              // emailController.clear();
                              // carInfoController.clear();
                            }
                          }
                        },
                      ),
                      Height_Spacer(),
                      Secondary_Big_Button(
                        buttonText: AppLocale.getString(
                            context, AppLocale.back_button,
                            languageCode: current_locale),
                        onPressed: () {
                          Go_Back(context);
                        },
                      ),
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
