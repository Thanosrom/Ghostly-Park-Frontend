// ignore_for_file: unnecessary_null_comparison, file_names, use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
//.env
import 'package:flutter_dotenv/flutter_dotenv.dart';
//Validators
import 'package:ghostlypark/src/Controller/Utils/Validators.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//Libs
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
//Providers
import 'package:ghostlypark/src/Model/Providers%20-%20Stores/UserState.dart';
//Routes
import 'package:ghostlypark/src/Controller/Routes/Routes.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Utils/load_Save_Language.dart';
import 'package:ghostlypark/src/Controller/Utils/load_Save_Delete_UserInfo.dart';
//Components
import 'package:ghostlypark/src/View/Components/Modals/Report_Modal.dart';
//Models
import 'package:ghostlypark/src/Model/LogIn.dart';

final storage = FlutterSecureStorage();

String? current_locale;
void initializeSettings(BuildContext context) async {
  bool isInitialized = false;
  if (!isInitialized) {
    //Languages
    current_locale = await load_Selected_Language();
    isInitialized = true;
  }
}

Future<void> login(
  String emailController,
  String passwordController,
  context,
) async {
  initializeSettings(context);

  if (await validate_Email(context, emailController) &&
      await validate_Password(context, passwordController)) {
    final response = await login_Model(emailController, passwordController);
    if (response.statusCode == 200) {
      save_Credentials(emailController, passwordController);
      // Set user profile variables
      final responseData = jsonDecode(response.body);
      final token = responseData['token'].toString();
      final email = responseData['email'].toString();
      final username = responseData['username'].toString();
      final carInfo = responseData['carInfo'].toString();
      final coins = responseData['coins'];
      final gems = responseData['gems'];

      // Save them into Provider
      Provider.of<UserState>(context, listen: false).setUserId(
          email: email,
          username: username,
          carInfo: carInfo,
          coins: coins,
          gems: gems);

      // Save token into shared Preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      // Navigate into Home screen
      Navigator.pushNamed(context, AppRoutes.home);
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
              its_error: true);
        },
      );
    }
  }
}

//Google Config Functions
Future<void> google_Login(
    String emailController, context, bool isGoogleSignIn) async {
  initializeSettings(context);
  if (await validate_Email(context, emailController)) {
    final response = await google_Login_Model(emailController);
    if (response.statusCode == 200) {
      //Set user profile variables
      final token = jsonDecode(response.body)['token'].toString();
      final email = jsonDecode(response.body)['email'].toString();
      final username = jsonDecode(response.body)['username'].toString();
      final carInfo = jsonDecode(response.body)['carInfo'].toString();
      final coins = jsonDecode(response.body)['coins'];
      final gems = jsonDecode(response.body)['gems'];

      //Save them into Provider
      Provider.of<UserState>(context, listen: false).setUserId(
          email: email,
          username: username,
          carInfo: carInfo,
          coins: coins,
          gems: gems);

      //Save token into shared Preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      //Navigate into Home screen
      Navigator.pushNamed(context, AppRoutes.home);
    } else {
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
              its_error: true);
        },
      );
    }
  }
}

//Send User Data to Backend
Future<bool> send_Auth(String? token) async {
  try {
    if (token == null) {
      return false;
    }
    final response = await http.post(
      Uri.parse('${dotenv.env['baseUrl']}/auth_google'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'idToken': token,
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (error) {}
  return false;
}
