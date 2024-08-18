// ignore_for_file: unnecessary_null_comparison, file_names, use_build_context_synchronously
import 'package:flutter/material.dart';
//Validators
import 'package:ghostlypark/src/Controller/Utils/Validators.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//Routes
import 'package:ghostlypark/src/Controller/Routes/Routes.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Utils/load_Save_Language.dart';
//Components
import 'package:ghostlypark/src/View/Components/Modals/Report_Modal.dart';
//Screens
import 'package:ghostlypark/src/View/Screens/Recovery_Password_2.dart';
import 'package:ghostlypark/src/View/Screens/Recovery_Password_3.dart';
//Models
import 'package:ghostlypark/src/Model/Recovery.dart';

String? current_locale;
void initializeSettings(BuildContext context) async {
  bool isInitialized = false;
  if (!isInitialized) {
    //Languages
    current_locale = await load_Selected_Language();
    isInitialized = true;
  }
}

Future<void> send_Digits_To_Recovery_Email(
    BuildContext context, String email) async {
  initializeSettings(context);
  if (await validate_Email(context, email)) {
    final response =
        await send_Digits_To_Recovery_Email_Model(email, current_locale);
    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Recovery_Password_2(email)),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return Report_Modal(
            context: context,
            labelTexts: AppLocale.getString(
              context,
              AppLocale.error_big_text_1,
              languageCode: current_locale,
            ),
            its_error: true,
          );
        },
      );
    }
  }
}

Future<void> reset_Password_Digits_Check(
  BuildContext context,
  String digit_controller,
  String email,
) async {
  initializeSettings(context);
  if (digit_controller != null && digit_controller.isNotEmpty) {
    if (await validate_Email(context, email)) {
      final response =
          await reset_Password_Digits_Check_Model(digit_controller, email);
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Recovery_Password_3(email),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return Report_Modal(
              context: context,
              labelTexts: AppLocale.getString(
                context,
                AppLocale.digit_code_is_false_small_text,
                languageCode: current_locale,
              ),
              its_error: true,
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return Report_Modal(
              context: context,
              labelTexts: AppLocale.getString(
                context,
                AppLocale.digit_code_is_empty_small_text,
                languageCode: current_locale,
              ),
              its_error: true);
        },
      );
    }
  }
}

Future<void> change_Password(
  BuildContext context,
  String password_controller,
  String repeat_password_controller,
  String email,
) async {
  initializeSettings(context);
  if (await validate_Password_And_RepeatPassword(
      context, password_controller, repeat_password_controller)) {
    if (await validate_Password(context, password_controller) &&
        await validate_Password(context, repeat_password_controller)) {
      final response = await change_Password_Model(
          password_controller, repeat_password_controller, email);
      if (response.statusCode == 200) {
        Navigator.pushNamed(context, AppRoutes.login);
        showDialog(
          context: context,
          builder: (context) {
            return Report_Modal(
                context: context,
                labelTexts: AppLocale.getString(
                  context,
                  AppLocale.password_reseted_small_text,
                  languageCode: current_locale,
                ),
                its_error: false,
                is_changed: true);
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return Report_Modal(
              context: context,
              labelTexts: AppLocale.getString(
                context,
                AppLocale.error_big_text_1,
                languageCode: current_locale,
              ),
              its_error: true,
            );
          },
        );
      }
    }
  }
}
