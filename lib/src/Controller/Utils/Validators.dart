//Function to check if all variables are correct
// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ghostlypark/Languages.dart';
import 'package:ghostlypark/src/Controller/Utils/load_Save_Language.dart';
import 'package:ghostlypark/src/Model/Utils/Validators.dart';
import 'package:ghostlypark/src/View/Components/Modals/Report_Modal.dart';

String? current_locale;
void initializeSettings(BuildContext context) async {
  bool isInitialized = false;
  if (!isInitialized) {
    //Languages
    current_locale = await load_Selected_Language();
    isInitialized = true;
  }
}

Future<bool> validate_Fields(
  BuildContext context,
  String usernameController,
  String passwordController,
  String repeatPasswordController,
  String emailController,
  String carInfoController,
) async {
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
    // Validate with the server
    final response = await validators_Model(
      usernameController,
      passwordController,
      repeatPasswordController,
      emailController,
      carInfoController,
    );
    print("Status: $response.statusCode");
    if (response.statusCode == 200) {
      return true;
    } else {
      Map<String, dynamic> jsonObject = jsonDecode(response.body);
      int errorCode = jsonObject['errorCode'];
      print(response.statusCode);
      print(errorCode);
      if (errorCode == 1000) {
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
      } else if (errorCode == 1001) {
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
      } else if (errorCode == 1002) {
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
      } else if (errorCode == 1003) {
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
      } else if (errorCode == 1004) {
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
        showDialog(
          context: context,
          builder: (context) {
            return Report_Modal(
              context: context,
              labelTexts: AppLocale.getString(
                context,
                AppLocale.some_fields,
                languageCode: current_locale,
              ),
              its_error: true,
            );
          },
        );
        return false;
      }
    }
  } else if (emailController.isEmpty ||
      usernameController.isEmpty ||
      passwordController.isEmpty ||
      repeatPasswordController.isEmpty ||
      carInfoController.isEmpty) {
    showDialog(
      context: context,
      builder: (context) {
        return Report_Modal(
          context: context,
          labelTexts: AppLocale.getString(
            context,
            AppLocale.some_fields,
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
            AppLocale.new_password_and_repeat_password_are_not_match_small_text,
            languageCode: current_locale,
          ),
          its_error: true,
        );
      },
    );
    return false;
  }
  return false;
}

//Login
Future<bool> validate_Login_Fields(
  BuildContext context,
  String passwordController,
  String emailController,
) async {
  initializeSettings(context);
  if (isValidEmail(emailController) &&
      isValidPassword(passwordController) &&
      emailController.isNotEmpty &&
      passwordController.isNotEmpty) {
    // Validate with the server
    final response =
        await validators_Login_Model(passwordController, emailController);
    print("Status: $response.statusCode");
    if (response.statusCode == 200) {
      return true;
    } else {
      Map<String, dynamic> jsonObject = jsonDecode(response.body);
      int errorCode = jsonObject['errorCode'];
      print(response.statusCode);
      print(errorCode);
      if (errorCode == 1003) {
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
      } else if (errorCode == 1001) {
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
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return Report_Modal(
              context: context,
              labelTexts: AppLocale.getString(
                context,
                AppLocale.some_fields,
                languageCode: current_locale,
              ),
              its_error: true,
            );
          },
        );
        return false;
      }
    }
  } else if (emailController.isEmpty || passwordController.isEmpty) {
    showDialog(
      context: context,
      builder: (context) {
        return Report_Modal(
          context: context,
          labelTexts: AppLocale.getString(
            context,
            AppLocale.some_fields,
            languageCode: current_locale,
          ),
          its_error: true,
        );
      },
    );
    return false;
  }
  return false;
}

//Check for valud Email,Username,Password and Car Model
bool isValidUsername(String username) {
  //final RegExp usernamePattern = RegExp(r'^[A-Za-z][A-Za-z0-9]{2,25}$');
  return true;
  //return usernamePattern.hasMatch(username);
}

bool isValidEmail(String email) {
  // final RegExp emailPattern = RegExp(
  //     r'^[a-zA-Z0-9.!#$%&\*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,5}$');
  return true;
  //return emailPattern.hasMatch(email);
}

bool isValidPassword(String password) {
  //final RegExp passwordPattern = RegExp(
  //r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?!.*[\\/#$<>%;&|(){}"`[\]]).{8,25}$');
  return true;
  //return passwordPattern.hasMatch(password);
}

bool isValidCarModel(String carModel) {
  //final RegExp carModelPattern = RegExp(r'^[A-Za-z0-9\s-]{2,25}$');
  return true;
  //return carModelPattern.hasMatch(carModel);
}
