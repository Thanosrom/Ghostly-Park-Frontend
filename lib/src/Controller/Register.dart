// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously
import 'package:flutter/material.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//Routes
import 'package:ghostlypark/src/Controller/Routes/Routes.dart';
//Components
import 'package:ghostlypark/src/View/Components/Modals/Report_Modal.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Utils/Validators.dart';
import 'package:ghostlypark/src/Controller/Utils/load_Save_Language.dart';
//Models
import 'package:ghostlypark/src/Model/Register.dart';

String? current_locale;
void initializeSettings(BuildContext context) async {
  bool isInitialized = false;
  if (!isInitialized) {
    //Languages
    current_locale = await load_Selected_Language();
    isInitialized = true;
  }
}

//Function to check if all variables are correct
bool validate_Fields(
  BuildContext context,
  String usernameController,
  String passwordController,
  String repeatPasswordController,
  String emailController,
  String carInfoController,
) {
  initializeSettings(context);
  if (isValidEmail(emailController) &&
      isValidUsername(usernameController) &&
      isValidPassword(passwordController) &&
      isValidPassword(repeatPasswordController) &&
      isValidCarModel(carInfoController) &&
      passwordController == repeatPasswordController &&
      emailController.isNotEmpty &&
      usernameController.isNotEmpty &&
      passwordController.isNotEmpty &&
      repeatPasswordController.isNotEmpty &&
      carInfoController.isNotEmpty) {
    return true;
  } else if (!isValidEmail(emailController)) {
    showDialog(
      context: context,
      builder: (context) {
        return Report_Modal(
          context: context,
          labelTexts: AppLocale.getString(
            context,
            AppLocale.email_is_false_small_text,
            languageCode: current_locale,
          ),
          its_error: true,
        );
      },
    );
    return false;
  } else if (!isValidUsername(usernameController)) {
    showDialog(
      context: context,
      builder: (context) {
        return Report_Modal(
          context: context,
          labelTexts: AppLocale.getString(
            context,
            AppLocale.username_is_false_small_text,
            languageCode: current_locale,
          ),
          its_error: true,
        );
      },
    );
    return false;
  } else if (passwordController != repeatPasswordController) {
    showDialog(
      context: context,
      builder: (context) {
        return Report_Modal(
          context: context,
          labelTexts: AppLocale.getString(
            context,
            AppLocale.password_or_repeat_password_small_text,
            languageCode: current_locale,
          ),
          its_error: true,
        );
      },
    );
  } else if (!isValidPassword(passwordController)) {
    showDialog(
      context: context,
      builder: (context) {
        return Report_Modal(
          context: context,
          labelTexts: AppLocale.getString(
            context,
            AppLocale.password_is_false_small_text,
            languageCode: current_locale,
          ),
          its_error: true,
        );
      },
    );
    return false;
  } else if (!isValidPassword(repeatPasswordController)) {
    showDialog(
      context: context,
      builder: (context) {
        return Report_Modal(
          context: context,
          labelTexts: AppLocale.getString(
            context,
            AppLocale.repeat_password_is_false_small_text,
            languageCode: current_locale,
          ),
          its_error: true,
        );
      },
    );
    return false;
  } else if (!isValidCarModel(carInfoController)) {
    showDialog(
      context: context,
      builder: (context) {
        return Report_Modal(
          context: context,
          labelTexts: AppLocale.getString(
            context,
            AppLocale.car_model_is_false_small_text,
            languageCode: current_locale,
          ),
          its_error: true,
        );
      },
    );
    return false;
  } else {
    return false;
  }
  return false;
}

//Send the digit code to the email
Future<bool> send_Digit_Code(
  BuildContext context,
  String emailController,
) async {
  initializeSettings(context);
  final isEmailTrue = await check_If_Email_Exist_Model(emailController);
  if (isEmailTrue.statusCode == 200) {
    final response =
        await send_Digit_Code_Model(emailController, current_locale);
    if (response.statusCode == 200) {
      return true;
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
      return false;
    }
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return Report_Modal(
          context: context,
          labelTexts: AppLocale.getString(
            context,
            AppLocale.email_exist_small_text,
            languageCode: current_locale,
          ),
          its_error: true,
        );
      },
    );
    return false;
  }
}

//Register the data if all are correct
Future<void> register_Data(
  BuildContext context,
  String usernameController,
  String passwordController,
  String repeatPasswordController,
  String emailController,
  String digitCodeController,
  String carInfoController,
) async {
  initializeSettings(context);
  if (context != null && digitCodeController.isNotEmpty) {
    final response = await register_Data_Model(
        context,
        usernameController,
        passwordController,
        emailController,
        digitCodeController,
        carInfoController);

    if (response.statusCode == 200) {
      Navigator.pushNamed(context, AppRoutes.login);
      showDialog(
        context: context,
        builder: (context) {
          return Report_Modal(
              context: context,
              labelTexts: AppLocale.getString(
                context,
                AppLocale.registered_small_text,
                languageCode: current_locale,
              ),
              its_error: false,
              is_changed: true);
        },
      );
    } else {
      Navigator.pushNamed(context, AppRoutes.login);
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
  } else {
    Navigator.pushNamed(context, AppRoutes.login);
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
            its_error: true);
      },
    );
  }
}
