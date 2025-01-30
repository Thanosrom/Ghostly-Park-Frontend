//Function to check if all variables are correct
// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Utils/load_Save_Language.dart';
//Components
import 'package:ghostlypark/src/View/Components/Modals/Report_Modal.dart';
//Libs
import 'package:email_validator/email_validator.dart';

String? current_locale;
void initializeSettings(BuildContext context) async {
  bool isInitialized = false;
  if (!isInitialized) {
    //Languages
    current_locale = await load_Selected_Language();
    isInitialized = true;
  }
}

Future<bool> validate_Username(
  BuildContext context,
  String usernameController,
) async {
  initializeSettings(context);
  if (usernameController.isEmpty) {
    showDialog(
      context: context,
      builder: (context) {
        return Report_Modal(
            context: context,
            labelTexts: AppLocale.getString(
              context,
              AppLocale.username_is_empty_small_text,
              languageCode: current_locale,
            ),
            its_error: true,
            is_changed: false);
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
  }

  return true;
}

Future<bool> validate_Password(
  BuildContext context,
  String passwordController,
) async {
  initializeSettings(context);
  if (passwordController.isEmpty) {
    showDialog(
      context: context,
      builder: (context) {
        return Report_Modal(
            context: context,
            labelTexts: AppLocale.getString(
              context,
              AppLocale.password_fields_are_empty_small_text,
              languageCode: current_locale,
            ),
            its_error: true,
            is_changed: false);
      },
    );
    return false;
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
  }

  return true;
}

Future<bool> validate_RepeatPassword(
  BuildContext context,
  String repeatPasswordController,
) async {
  initializeSettings(context);
  if (repeatPasswordController.isEmpty) {
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
            is_changed: false);
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
  }

  return true;
}

Future<bool> validate_Password_And_RepeatPassword(
  BuildContext context,
  String passwordController,
  String repeatPasswordController,
) async {
  initializeSettings(context);
  if (passwordController.isEmpty && repeatPasswordController.isEmpty) {
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
    return false;
  }

  return true;
}

Future<bool> validate_CarInfo(
  BuildContext context,
  String carInfoController,
) async {
  initializeSettings(context);
  if (carInfoController.isEmpty) {
    showDialog(
      context: context,
      builder: (context) {
        return Report_Modal(
            context: context,
            labelTexts: AppLocale.getString(
              context,
              AppLocale.car_model_is_empty_small_text,
              languageCode: current_locale,
            ),
            its_error: true,
            is_changed: false);
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
  }

  return true;
}

Future<bool> validate_Email(
  BuildContext context,
  String emailController,
) async {
  initializeSettings(context);
  if (emailController.isEmpty) {
    showDialog(
      context: context,
      builder: (context) {
        return Report_Modal(
            context: context,
            labelTexts: AppLocale.getString(
              context,
              AppLocale.email_is_empty_small_text,
              languageCode: current_locale,
            ),
            its_error: true,
            is_changed: false);
      },
    );
    return false;
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
  }

  return true;
}

//========================================================
//Check for valud Email,Username,Password and Car Model
bool isValidUsername(String username) {
  final RegExp usernameModelPattern = RegExp(r'^.{2,25}$');
  print(usernameModelPattern.hasMatch(username));
  return usernameModelPattern.hasMatch(username);
}

bool isValidEmail(String email) {
  print(EmailValidator.validate(email));
  return EmailValidator.validate(email);
}

bool isValidPassword(String password) {
  final RegExp passwordModelPattern = RegExp(r'^.{8,25}$');
  print(passwordModelPattern.hasMatch(password));

  return passwordModelPattern.hasMatch(password);
}

bool isValidCarModel(String carModel) {
  final RegExp carModelPattern = RegExp(r'^.{2,25}$');
  print(carModelPattern.hasMatch(carModel));

  return carModelPattern.hasMatch(carModel);
}
