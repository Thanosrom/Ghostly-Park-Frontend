// ignore_for_file: file_names, non_constant_identifier_names
import 'dart:convert';
//.env
import 'package:flutter_dotenv/flutter_dotenv.dart';
//other libs
import 'package:http/http.dart' as http;
//Headers
import 'package:ghostlypark/src/Model/Headers.dart';

Future<http.Response> validators_Model(
  String usernameController,
  String passwordController,
  String repeatPasswordController,
  String emailController,
  String carInfoController,
) async {
  try {
    final response =
        await http.post(Uri.parse('${dotenv.env['baseUrl']}/validators'),
            body: jsonEncode({
              'username': usernameController,
              'password': passwordController,
              'repeatPassword': repeatPasswordController,
              'email': emailController,
              'carInfo': carInfoController,
            }),
            headers: simple_Headers());

    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}

Future<http.Response> validators_Login_Model(
  String emailController,
  String passwordController,
) async {
  try {
    final response =
        await http.post(Uri.parse('${dotenv.env['baseUrl']}/login_Validators'),
            body: jsonEncode({
              'email': emailController,
              'password': passwordController,
            }),
            headers: simple_Headers());

    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}

//===========================================
//Seperated Validators
Future<http.Response> username_Validator_Model(
  String usernameController,
) async {
  try {
    print("Username Validation");
    final response = await http.post(
        Uri.parse('${dotenv.env['baseUrl']}/username_Validator'),
        body: jsonEncode({
          'username': usernameController,
        }),
        headers: simple_Headers());
    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}

Future<http.Response> password_Validator_Model(
  String passwordController,
) async {
  try {
    final response = await http.post(
        Uri.parse('${dotenv.env['baseUrl']}/password_Validator'),
        body: jsonEncode({
          'password': passwordController,
        }),
        headers: simple_Headers());

    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}

Future<http.Response> repeatPassword_Validator_Model(
  String repeatPasswordController,
) async {
  try {
    final response = await http.post(
        Uri.parse('${dotenv.env['baseUrl']}/repeatPassword_Validator'),
        body: jsonEncode({
          'repeatPassword': repeatPasswordController,
        }),
        headers: simple_Headers());

    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}

Future<http.Response> email_Validator_Model(
  String emailController,
) async {
  try {
    final response =
        await http.post(Uri.parse('${dotenv.env['baseUrl']}/email_Validator'),
            body: jsonEncode({
              'email': emailController,
            }),
            headers: simple_Headers());

    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}

Future<http.Response> carInfo_Validator_Model(
  String carInfoController,
) async {
  try {
    final response =
        await http.post(Uri.parse('${dotenv.env['baseUrl']}/carInfo_Validator'),
            body: jsonEncode({
              'carInfo': carInfoController,
            }),
            headers: simple_Headers());

    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}
