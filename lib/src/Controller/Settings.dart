// ignore_for_file: unused_local_variable, file_names, use_build_context_synchronously
import 'dart:async';
import 'package:flutter/material.dart';
//Validators
import 'package:ghostlypark/src/Controller/Utils/Validators.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//Routes
import 'package:ghostlypark/src/Controller/Routes/Routes.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Utils/Go_Back.dart';
import 'package:ghostlypark/src/Controller/Utils/Handle_Button_Clicks.dart';
import 'package:ghostlypark/src/Controller/Utils/load_Save_Delete_UserInfo.dart';
import 'package:ghostlypark/src/Controller/Utils/load_Save_Language.dart';
//Components
import 'package:ghostlypark/src/View/Components/Height_Spacer.dart';
import 'package:ghostlypark/src/View/Components/Modals/Small_Textfields_Modals.dart';
import 'package:ghostlypark/src/View/Components/Modals/Report_Modal.dart';
import 'package:ghostlypark/src/View/Components/Settings_Modals_Buttons.dart';
import 'package:ghostlypark/src/View/Components/Small_Texts.dart';
//Models
import 'package:ghostlypark/src/Model/Settings.dart';
//Libs
import 'package:shared_preferences/shared_preferences.dart';

String? current_locale;
void initializeSettings(context) async {
  bool isInitialized = false;
  if (!isInitialized) {
    //Languages
    current_locale = await load_Selected_Language();
    isInitialized = true;
  }
}

//Text Controllers
final TextEditingController usernameController = TextEditingController();
final TextEditingController oldPasswordController = TextEditingController();
final TextEditingController newPasswordController = TextEditingController();
final TextEditingController newRepeatPasswordController =
    TextEditingController();
final TextEditingController carInfoController = TextEditingController();

Future<void> change_Username(BuildContext context) async {
  initializeSettings(context);
  showDialog(
    context: context,
    builder: (context) {
      return Small_Textfield_Modal(
        context: context,
        labelTexts: AppLocale.getString(
          context,
          AppLocale.new_username_small_text,
          languageCode: current_locale,
        ),
        Controller: usernameController,
        icon: Icons.person,
        sendNew: () async {
          if (await handle_Button_Click('Settings_Username')) {
            send_NewUsername(context, usernameController.text);
          }
        },
      );
    },
  );

  usernameController.clear();
}

Future<void> send_NewUsername(
    BuildContext context, String usernameController) async {
  initializeSettings(context);
  if (await validate_Username(context, usernameController)) {
    final response = await send_NewUsername_Model(usernameController);
    if (response.statusCode == 200) {
      Go_Back(context);
      showDialog(
        context: context,
        builder: (context) {
          return Report_Modal(
              context: context,
              labelTexts: AppLocale.getString(
                context,
                AppLocale.changed_small_text,
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

Future<void> change_Password(BuildContext context) async {
  initializeSettings(context);
  showDialog(
    context: context,
    builder: (context) {
      return Small_Textfield_Modal(
        context: context,
        labelTexts: AppLocale.getString(
          context,
          AppLocale.old_password_small_text,
          languageCode: current_locale,
        ),
        second_labelTexts: AppLocale.getString(
          context,
          AppLocale.new_password_small_text,
          languageCode: current_locale,
        ),
        third_labelTexts: AppLocale.getString(
          context,
          AppLocale.repeat_password_small_text,
          languageCode: current_locale,
        ),
        Controller: oldPasswordController,
        secondController: newPasswordController,
        thirdController: newRepeatPasswordController,
        icon: Icons.lock,
        havePass: true,
        two_fields: true,
        three_fields: true,
        sendNew: () async {
          if (await handle_Button_Click('Settings_Password')) {
            send_NewPassword(context, oldPasswordController.text,
                newPasswordController.text, newRepeatPasswordController.text);
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return Report_Modal(
                    context: context,
                    labelTexts: AppLocale.getString(
                      context,
                      AppLocale.this_is_the_old_password_small_text,
                      languageCode: current_locale,
                    ),
                    its_error: true);
              },
            );
          }
        },
      );
    },
  );
  oldPasswordController.clear();
  newPasswordController.clear();
  newRepeatPasswordController.clear();
}

Future<void> send_NewPassword(
    BuildContext context,
    String oldPasswordController,
    String newPasswordController,
    String newRepeatPasswordController) async {
  initializeSettings(context);
  if (newPasswordController != newRepeatPasswordController) {
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
          its_error: false,
          is_changed: true,
        );
      },
    );
  }
  if (newPasswordController.isEmpty && newRepeatPasswordController.isEmpty) {
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
        );
      },
    );
  }
  if (await validate_Password(context, newPasswordController) &&
      await validate_Password(context, newRepeatPasswordController) &&
      await validate_Password(context, oldPasswordController)) {
    final response_old = await check_Old_Password(oldPasswordController);
    if (response_old.statusCode == 200) {
      final response = await send_NewPassword_Model(newPasswordController);
      if (response.statusCode == 200) {
        delete_Credentials();
        Navigator.pushNamed(context, AppRoutes.login);
        showDialog(
          context: context,
          builder: (context) {
            return Report_Modal(
              context: context,
              labelTexts: AppLocale.getString(
                context,
                AppLocale.password_changed_small_text,
                languageCode: current_locale,
              ),
              its_error: false,
              is_changed: true,
            );
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

Future<void> change_CarInfo(BuildContext context) async {
  initializeSettings(context);
  showDialog(
    context: context,
    builder: (context) {
      return Small_Textfield_Modal(
        context: context,
        labelTexts: AppLocale.getString(
          context,
          AppLocale.new_carInfo_small_text,
          languageCode: current_locale,
        ),
        Controller: carInfoController,
        icon: Icons.car_repair,
        sendNew: () async {
          if (await handle_Button_Click('Settings_CarInfo')) {
            send_NewCarInfo(context, carInfoController.text);
          }
        },
      );
    },
  );
  carInfoController.clear();
}

Future<void> send_NewCarInfo(
    BuildContext context, String carInfoController) async {
  initializeSettings(context);
  if (await validate_CarInfo(context, carInfoController)) {
    final response = await send_NewCarInfo_Model(carInfoController);
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) {
          return Report_Modal(
            context: context,
            labelTexts: AppLocale.getString(
              context,
              AppLocale.changed_small_text,
              languageCode: current_locale,
            ),
            its_error: false,
            is_changed: true,
          );
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

Future<void> delete_User(BuildContext context) async {
  initializeSettings(context);
  double screenWidth = MediaQuery.of(context).size.width;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent.withOpacity(1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              screenWidth <= 414
                  ? screenWidth * 0.05
                  : screenWidth <= 810
                      ? screenWidth * 0.05
                      : screenWidth * 0.05,
            ),
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(
            top: screenWidth <= 414
                ? screenWidth * 0.01
                : screenWidth <= 810
                    ? screenWidth * 0.01
                    : screenWidth * 0.01,
            bottom: screenWidth <= 414
                ? screenWidth * 0.01
                : screenWidth <= 810
                    ? screenWidth * 0.01
                    : screenWidth * 0.01,
          ),
          width: screenWidth <= 414
              ? screenWidth * 0.6
              : screenWidth <= 810
                  ? screenWidth * 0.6
                  : screenWidth * 0.6,
          height: screenWidth <= 414
              ? screenWidth * 0.5
              : screenWidth <= 810
                  ? screenWidth * 0.5
                  : screenWidth * 0.5,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(
              screenWidth <= 414
                  ? screenWidth * 0.05
                  : screenWidth <= 810
                      ? screenWidth * 0.05
                      : screenWidth * 0.05,
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 100, 7, 223),
                offset: Offset(0, 4),
                blurRadius: screenWidth <= 414
                    ? screenWidth * 0.01
                    : screenWidth <= 810
                        ? screenWidth * 0.01
                        : screenWidth * 0.01,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Small_Texts(
                  avoid_flex: false,
                  smallText: AppLocale.getString(
                    context,
                    AppLocale.are_you_sure_delete_small_text,
                    languageCode: current_locale,
                  ),
                  center: true,
                  color: Colors.white),
              Height_Spacer(),
              Container(
                width: screenWidth <= 414
                    ? screenWidth * 0.5
                    : screenWidth <= 810
                        ? screenWidth * 0.5
                        : screenWidth * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Settings_Modals_Buttons(
                      label_text: AppLocale.getString(
                        context,
                        AppLocale.delete_account_small_text,
                        languageCode: current_locale,
                      ),
                      onPressed: () async => {
                        if (await handle_Button_Click('Settings_Delete_User'))
                          {
                            send_Delete_User(context),
                            Go_Back(context),
                          }
                      },
                    ),
                    Height_Spacer(),
                    Settings_Modals_Buttons(
                      label_text: AppLocale.getString(
                        context,
                        AppLocale.close_text,
                        languageCode: current_locale,
                      ),
                      onPressed: () => Go_Back(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> send_Delete_User(BuildContext context) async {
  initializeSettings(context);
  final response = await delete_User_Model(context);
  if (response.statusCode == 200) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('autoLoginEnabled', false);
    prefs.remove('autoLoginEnabled');
    prefs.remove('isFirstLaunch');
    delete_Credentials();
    Navigator.pushNamed(context, AppRoutes.login);
    showDialog(
      context: context,
      builder: (context) {
        return Report_Modal(
            context: context,
            labelTexts: AppLocale.getString(
              context,
              AppLocale.account_deleted_small_text,
              languageCode: current_locale,
            ),
            its_error: false,
            errorCode: response.statusCode,
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
