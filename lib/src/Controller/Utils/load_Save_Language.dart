//Libs
import 'package:shared_preferences/shared_preferences.dart';

Future<String> load_Selected_Language() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('selectedLanguage') ?? 'en';
}

Future<void> save_Selected_Language(String languageCode) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('selectedLanguage', languageCode);
}
