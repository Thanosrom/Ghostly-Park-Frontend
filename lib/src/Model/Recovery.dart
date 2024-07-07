// ignore_for_file: unnecessary_null_comparison, file_names, use_build_context_synchronously
import 'dart:convert';
//.env
import 'package:flutter_dotenv/flutter_dotenv.dart';
//Headers
import 'package:ghostlypark/src/Model/Headers.dart';
//Libs
import 'package:http/http.dart' as http;

Future<http.Response> send_Digits_To_Recovery_Email_Model(
    String email, String? current_locale) async {
  try {
    final response = await http.post(
        Uri.parse('${dotenv.env['baseUrl']}/send_Digits_To_Recovery_Email'),
        body: jsonEncode({'email': email, 'locale': current_locale}),
        headers: simple_Headers());
    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}

Future<http.Response> reset_Password_Digits_Check_Model(
  String digit_controller,
  String email,
) async {
  try {
    final response = await http.post(
        Uri.parse('${dotenv.env['baseUrl']}/reset_Password_Digits_Check'),
        body: jsonEncode({'digitCode': digit_controller}),
        headers: simple_Headers());
    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}

Future<http.Response> change_Password_Model(
  String password_controller,
  String repeat_password_controller,
  String email,
) async {
  try {
    final response =
        await http.post(Uri.parse('${dotenv.env['baseUrl']}/change_Password'),
            body: jsonEncode({
              'password': password_controller,
              'repeatPassword': repeat_password_controller,
              'email': email
            }),
            headers: simple_Headers());
    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}
