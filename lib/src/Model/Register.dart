// ignore_for_file: file_names, non_constant_identifier_names
import 'dart:convert';
import 'package:flutter/material.dart';
//.env
import 'package:flutter_dotenv/flutter_dotenv.dart';
//Libs
import 'package:http/http.dart' as http;
//Headers
import 'package:ghostlypark/src/Model/Headers.dart';

Future<http.Response> check_If_Email_Exist_Model(
  String emailController,
) async {
  try {
    final response = await http.post(
        Uri.parse('${dotenv.env['baseUrl']}/check_If_Email_Exist'),
        body: jsonEncode({
          'email': emailController,
        }),
        headers: simple_Headers());
    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}

Future<http.Response> send_Digit_Code_Model(
    String emailController, String? current_locale) async {
  try {
    final email = emailController;
    final response = await http.post(
        Uri.parse('${dotenv.env['baseUrl']}/send_Digit_Code'),
        body: jsonEncode({'email': email, 'locale': current_locale}),
        headers: simple_Headers());
    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}

Future<http.Response> register_Data_Model(
  BuildContext context,
  String usernameController,
  String passwordController,
  String emailController,
  String digitCodeController,
  String carInfoController,
) async {
  try {
    final response =
        await http.post(Uri.parse('${dotenv.env['baseUrl']}/register_Data'),
            body: jsonEncode({
              'username': usernameController,
              'password': passwordController,
              'email': emailController,
              'digitCode': digitCodeController,
              'carInfo': carInfoController,
            }),
            headers: simple_Headers());

    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}
