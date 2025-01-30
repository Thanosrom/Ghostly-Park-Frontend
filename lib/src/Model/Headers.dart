//Libs
import 'package:shared_preferences/shared_preferences.dart';

Map<String, String> simple_Headers() {
  final Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  return requestHeaders;
}

Future<Map<String, String>> token_Headers() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = await prefs.getString('token');
  final Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${token}',
  };
  return requestHeaders;
}
