import 'package:flutter/foundation.dart';
//Libs
import 'package:shared_preferences/shared_preferences.dart';

class ImageState extends ChangeNotifier {
  String? _imagePath;

  ImageState() {
    _loadImagePath();
  }

  String? get imagePath => _imagePath;
  bool get hasImagePath => _imagePath != null && _imagePath!.isNotEmpty;

  void setImagePath(String path) {
    _imagePath = path;
    _saveImagePath();
    notifyListeners();
  }

  Future<void> _loadImagePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _imagePath = prefs.getString('imagePath');
    notifyListeners();
  }

  Future<void> _saveImagePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('imagePath', _imagePath!);
  }
}
