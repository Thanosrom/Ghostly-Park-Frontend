import 'dart:convert';
//.env
import 'package:flutter_dotenv/flutter_dotenv.dart';
//Headers
import 'package:ghostlypark/src/Model/Headers.dart';
//Libs
import 'package:http/http.dart' as http;

//----------------------------------------------------------------------------------//
//Subscriptions check
Future<http.Response> get_subscription_Model() async {
  try {
    final response = await http.get(
        Uri.parse('${dotenv.env['baseUrl']}/get_Subscription'),
        headers: await token_Headers());
    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}

Future<http.Response> plus_Subscription_Model() async {
  try {
    final response = await http.put(
        Uri.parse('${dotenv.env['baseUrl']}/plus_Subscription'),
        headers: await token_Headers());
    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}

//Coins And Gems handle
Future<http.Response> get_Coins_Model() async {
  try {
    final response = await http.get(
        Uri.parse('${dotenv.env['baseUrl']}/get_Coins'),
        headers: await token_Headers());
    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}

Future<http.Response> plus_Coins_Model(String type) async {
  try {
    final response = await http.put(
      Uri.parse('${dotenv.env['baseUrl']}/plus_Coins'),
      headers: await token_Headers(),
      body: jsonEncode({'type': type}),
    );
    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}

Future<http.Response> minus_Coins_Model() async {
  try {
    final response = await http.put(
        Uri.parse('${dotenv.env['baseUrl']}/minus_Coins'),
        headers: await token_Headers());
    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}

Future<http.Response> get_Gems_Model() async {
  try {
    final response = await http.get(
        Uri.parse('${dotenv.env['baseUrl']}/get_Gems'),
        headers: await token_Headers());
    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}

Future<http.Response> plus_Gems_Model() async {
  try {
    final response = await http.put(
        Uri.parse('${dotenv.env['baseUrl']}/plus_Gems'),
        headers: await token_Headers());
    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}

Future<http.Response> minus_Gems_Model() async {
  try {
    final response = await http.put(
        Uri.parse('${dotenv.env['baseUrl']}/minus_Gems'),
        headers: await token_Headers());
    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}
