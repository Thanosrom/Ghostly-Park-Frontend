import 'package:flutter/foundation.dart';

class UserState with ChangeNotifier {
  late String _email = '';
  late String _username = '';
  late String _carInfo = '';
  late int _coins = 0;
  late int _gems = 0;

  String get email => _email;
  String get username => _username;
  String get carInfo => _carInfo;
  int get coins => _coins;
  int get gems => _gems;

  void setUserId({
    String? email,
    String? username,
    String? carInfo,
    int? coins,
    int? gems,
  }) {
    if (email != null) _email = email;
    if (username != null) _username = username;
    if (carInfo != null) _carInfo = carInfo;
    if (coins != null) _coins = coins;
    if (gems != null) _gems = gems;

    notifyListeners();
  }
}
