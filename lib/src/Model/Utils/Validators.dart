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
  String passwordController,
  String emailController,
) async {
  try {
    final response =
        await http.post(Uri.parse('${dotenv.env['baseUrl']}/login_Validators'),
            body: jsonEncode({
              'password': passwordController,
              'email': emailController,
            }),
            headers: simple_Headers());

    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}
