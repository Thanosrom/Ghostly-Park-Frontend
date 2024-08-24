// ignore_for_file: unused_local_variable, non_constant_identifier_names, file_names
import 'dart:convert';
//.env
import 'package:flutter_dotenv/flutter_dotenv.dart';
//Libs
import 'package:http/http.dart' as http;
//Headers
import 'package:ghostlypark/src/Model/Headers.dart';

Future<http.Response> send_NewUsername_Model(String usernameController) async {
  try {
    final response =
        await http.put(Uri.parse('${dotenv.env['baseUrl']}/change_Username'),
            body: jsonEncode({
              'newUsername': usernameController,
            }),
            headers: await token_Headers());
    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}

Future<http.Response> check_Old_Password(String oldPasswordController) async {
  try {
    final response =
        await http.put(Uri.parse('${dotenv.env['baseUrl']}/check_Old_Password'),
            body: jsonEncode({
              'oldPassword': oldPasswordController,
            }),
            headers: await token_Headers());
    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}

Future<http.Response> send_NewPassword_Model(String passwordController) async {
  try {
    final response =
        await http.put(Uri.parse('${dotenv.env['baseUrl']}/change_Password'),
            body: jsonEncode({
              'newPassword': passwordController,
            }),
            headers: await token_Headers());
    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}

Future<http.Response> send_NewCarInfo_Model(String carInfoController) async {
  try {
    final response =
        await http.put(Uri.parse('${dotenv.env['baseUrl']}/change_CarInfo'),
            body: jsonEncode({
              'newCarInfo': carInfoController,
            }),
            headers: await token_Headers());
    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}

Future<http.Response> delete_User_Model() async {
  try {
    final response = await http.put(
        Uri.parse('${dotenv.env['baseUrl']}/delete_User'),
        headers: await token_Headers());
    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}
