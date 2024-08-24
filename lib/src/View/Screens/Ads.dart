import 'dart:convert';

import 'package:flutter/material.dart';
//.env
import 'package:flutter_dotenv/flutter_dotenv.dart';
//Libs
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
//Providers
import 'package:ghostlypark/src/Model/Providers%20-%20Stores/UserState.dart';
//Headers
import 'package:ghostlypark/src/Model/Headers.dart';
import 'package:provider/provider.dart';

//Variables
RewardedAd? _rewardedAd;
int _rewardedScore = 0;
bool adLoaded = false;
//final _adUnitId = 'ca-app-pub-3940256099942544/5224354917';
final _adUnitId = 'ca-app-pub-6837078075079728/5720004301';

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

Future<http.Response> update_UserCoins() async {
  try {
    final response = await http.put(
      Uri.parse('${dotenv.env['baseUrl']}/plus_Coins'),
      headers: await token_Headers(),
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      return http.Response('Error occurred', 400);
    }
  } catch (error) {
    return http.Response('Error occurred', 400);
  }
}

void createRewardedAd(BuildContext context) {
  RewardedAd.load(
    adUnitId: _adUnitId,
    request: const AdRequest(),
    rewardedAdLoadCallback: RewardedAdLoadCallback(
      onAdLoaded: (ad) async {
        //debugPrint('$ad loaded.');
        _rewardedAd = ad;
        adLoaded = true;
        showRewardedAd(context);
        try {
          var get_Coins;
          var coins_data;
          var coins_data2;
          //Get coins from database
          get_Coins = await get_Coins_Model();
          //Decode
          coins_data = json.decode(get_Coins.body);
          coins_data2 = coins_data[0]['coins'];
          Provider.of<UserState>(context, listen: false)
              .setUserId(coins: coins_data2 + 1);
        } catch (e) {
          print('Error fetching coins: $e');
        }
      },
      onAdFailedToLoad: (LoadAdError error) {
        //debugPrint('RewardedAd failed to load: $error');
        // do {
        //   Future.delayed(Duration(seconds: 2), () {
        //     _createRewardedAd();
        //   });
        // } while (adLoaded);
      },
    ),
  );
}

void showRewardedAd(BuildContext context) {
  try {
    _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
      },
    );

    _rewardedAd?.show(
      onUserEarnedReward: (ad, reward) {
        _rewardedScore += reward.amount.toInt();
        update_UserCoins();
      },
    );
    _rewardedAd = null;
  } catch (error) {}
}
