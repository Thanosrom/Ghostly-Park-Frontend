// ignore_for_file: file_names, prefer_const_constructors, constant_identifier_names
import 'package:flutter/material.dart';
//Routes
import 'package:ghostlypark/src/View/Screens/Landing_Page.dart';
import 'package:ghostlypark/src/View/Screens/LogIn.dart';
import 'package:ghostlypark/src/View/Screens/Privacy_Policy_And_Terms.dart';
import 'package:ghostlypark/src/View/Screens/Register_1.dart';
import 'package:ghostlypark/src/View/Screens/Recovery_Password_1.dart';
import 'package:ghostlypark/src/View/Screens/Settings.dart';
import 'package:ghostlypark/src/View/Screens/Home.dart';
import 'package:ghostlypark/src/View/Screens/User_Profile.dart';
import 'package:ghostlypark/src/View/Screens/Billing.dart';
import 'package:ghostlypark/src/View/Screens/Error.dart';
import 'package:ghostlypark/src/View/Screens/Maintenance.dart';
import 'package:ghostlypark/src/View/Screens/Update.dart';

class AppRoutes {
  static const String slash = '/Landing_Page';
  static const String login = '/LogIn';
  static const String privacy_policy_and_terms = '/Privacy_Policy_And_Terms';
  static const String register = '/Register_1';
  static const String recovery = '/Recovery_Password_1';
  static const String settings = '/Settings';
  static const String home = '/Home';
  static const String billing = '/Billing';
  static const String user_profile = '/User_Profile';
  static const String error = '/Error';
  static const String maintenance = '/Maintenance';
  static const String update = '/Update';

  static Map<String, WidgetBuilder> routes = {
    slash: (context) => Landing_Page(),
    login: (context) => LogIn(),
    privacy_policy_and_terms: (context) => Privacy_Policy_And_Terms(),
    register: (context) => Register_1(),
    recovery: (context) => Recovery_Password_1(),
    settings: (context) => Settings(),
    home: (context) => Home(),
    user_profile: (context) => User_Profile(),
    billing: (context) => Billing(),
    error: (context) => Error(),
    maintenance: (context) => Maintenance(),
    update: (context) => Update(),
  };

  static MaterialPageRoute generateRoute(RouteSettings routes) {
    switch (routes.name) {
      case slash:
        return MaterialPageRoute(builder: (context) => Landing_Page());
      case login:
        return MaterialPageRoute(builder: (context) => LogIn());
      case privacy_policy_and_terms:
        return MaterialPageRoute(
            builder: (context) => Privacy_Policy_And_Terms());
      case register:
        return MaterialPageRoute(builder: (context) => Register_1());
      case recovery:
        return MaterialPageRoute(builder: (context) => Recovery_Password_1());
      case settings:
        return MaterialPageRoute(builder: (context) => Settings());
      case home:
        return MaterialPageRoute(builder: (context) => Home());
      case user_profile:
        return MaterialPageRoute(builder: (context) => User_Profile());
      case billing:
        return MaterialPageRoute(builder: (context) => Billing());
      case error:
        return MaterialPageRoute(builder: (context) => Error());
      case maintenance:
        return MaterialPageRoute(builder: (context) => Maintenance());
      case update:
        return MaterialPageRoute(builder: (context) => Update());
      //Else -->
      default:
        return MaterialPageRoute(builder: (context) => Error());
    }
  }
}
