// ignore_for_file: file_names, non_constant_identifier_names
import 'dart:convert';
//Libs
import 'package:http/http.dart' as http;
//.env
import 'package:flutter_dotenv/flutter_dotenv.dart';
//Headers
import 'package:ghostlypark/src/Model/Headers.dart';

Future<http.Response> login_Model(
    String emailController, String passwordController) async {
  try {
    final response = await http.post(
      Uri.parse('${dotenv.env['baseUrl']}/login'),
      body: jsonEncode(
        {
          'email': emailController,
          'password': passwordController,
        },
      ),
      headers: simple_Headers(),
    );
    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}

//Google Login
Future<http.Response> google_Login_Model(String emailController) async {
  try {
    final response = await http.post(
      Uri.parse('${dotenv.env['baseUrl']}/google_Login'),
      body: jsonEncode(
        {
          'email': emailController,
        },
      ),
      headers: simple_Headers(),
    );
    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}
