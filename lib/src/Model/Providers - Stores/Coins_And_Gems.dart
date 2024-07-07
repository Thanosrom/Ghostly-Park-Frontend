import 'package:flutter/foundation.dart';

class Coins_And_Gems_State with ChangeNotifier {
  late String _coins;
  late String _gems;

  String get coins => _coins;
  String get gems => _gems;

  void setUser_Coins_And_Gems({String? coins, String? gems}) {
    if (coins != null) {
      _coins = coins;
    }
    if (gems != null) {
      _gems = gems;
    }
    notifyListeners();
  }
}
