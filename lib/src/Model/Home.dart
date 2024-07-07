// ignore_for_file: file_names
import 'dart:convert';
import 'package:flutter/material.dart';
//.env
import 'package:flutter_dotenv/flutter_dotenv.dart';
//Libs
import 'package:http/http.dart' as http;
import 'package:flutter_map/flutter_map.dart';
//Headers
import 'package:ghostlypark/src/Model/Headers.dart';

Future<http.Response> get_FilteredMarkers_Model(List<Marker> markers,
    MapController mapController, double lng, double lat) async {
  try {
    final response = await http.post(
        Uri.parse('${dotenv.env['baseUrl']}/get_FilteredMarkers'),
        body: jsonEncode({
          'lat': lat,
          'lng': lng,
        }),
        headers: await token_Headers());
    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}

Future<http.Response> send_UnParked_Location_Model(
    double lat, double lng, BuildContext context) async {
  try {
    final response = await http.post(
        Uri.parse('${dotenv.env['baseUrl']}/send_UnParked_Location'),
        body: jsonEncode({
          'lat': lat,
          'lng': lng,
        }),
        headers: await token_Headers());
    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}

Future<http.Response> get_Parked_Location_Model() async {
  try {
    final response = await http.post(
        Uri.parse('${dotenv.env['baseUrl']}/get_Parked_Location'),
        body: jsonEncode({}),
        headers: await token_Headers());

    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}

Future<http.Response> send_Parked_Location_Model(
    double lat, double lng, BuildContext context) async {
  try {
    final response = await http.post(
        Uri.parse('${dotenv.env['baseUrl']}/send_Parked_Location'),
        body: jsonEncode({
          'parked_long': lng,
          'parked_lat': lat,
        }),
        headers: await token_Headers());
    return response;
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}

//----------------------------------------------------------------------------------//
//Subscriptions check

Future<http.Response> subscription_Model() async {
  try {
    final response = await http.get(
        Uri.parse('${dotenv.env['baseUrl']}/get_Subscription'),
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

Future<http.Response> plus_Coins_Model() async {
  try {
    final response = await http.put(
        Uri.parse('${dotenv.env['baseUrl']}/plus_Coins'),
        headers: await token_Headers());
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
