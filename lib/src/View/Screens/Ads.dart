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

//Variables
RewardedAd? _rewardedAd;
int _rewardedScore = 0;
bool adLoaded = false;
final _adUnitId = 'ca-app-pub-3940256099942544/5224354917';

Future<http.Response> fetch_UserCoins(
    UserState userState, BuildContext context) async {
  try {
    final response = await http.post(
      Uri.parse('${dotenv.env['baseUrl']}/Coins'),
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

Future<http.Response> update_UserCoins(
    UserState userState, BuildContext context) async {
  try {
    final response = await http.post(
      Uri.parse('${dotenv.env['baseUrl']}/Update_Coins'),
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

void _createRewardedAd() {
  RewardedAd.load(
    adUnitId: _adUnitId,
    request: const AdRequest(),
    rewardedAdLoadCallback: RewardedAdLoadCallback(
      onAdLoaded: (ad) {
        debugPrint('$ad loaded.');
        _rewardedAd = ad;
        adLoaded = true;
      },
      onAdFailedToLoad: (LoadAdError error) {
        debugPrint('RewardedAd failed to load: $error');
        // do {
        //   Future.delayed(Duration(seconds: 2), () {
        //     _createRewardedAd();
        //   });
        // } while (adLoaded);
      },
    ),
  );
}

void _showRewardedAd(UserState userState) {
  try {
    _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _createRewardedAd();
      },
    );

    _rewardedAd?.show(
      onUserEarnedReward: (ad, reward) {
        _rewardedScore += reward.amount.toInt();
      },
    );
    _rewardedAd = null;
  } catch (error) {}
}
