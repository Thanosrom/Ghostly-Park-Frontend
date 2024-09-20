// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
//.env
import 'package:flutter_dotenv/flutter_dotenv.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Utils/load_Save_Language.dart';
//Components
import 'package:ghostlypark/src/View/Components/Modals/Report_Modal.dart';
//Libs
import 'package:google_mobile_ads/google_mobile_ads.dart';
//Providers
import 'package:ghostlypark/src/Model/Providers%20-%20Stores/UserState.dart';
//Headers
import 'package:provider/provider.dart';
//Models
import 'package:ghostlypark/src/Model/SubscriptionsCoinsGems.dart';

String? current_locale;
void initializeSettings(BuildContext context) async {
  bool isInitialized = false;
  if (!isInitialized) {
    //Languages
    current_locale = await load_Selected_Language();
    isInitialized = true;
  }
}

//Variables
RewardedAd? _rewardedAd;
bool adLoaded = false;
//final _adUnitId = 'ca-app-pub-3940256099942544/5224354917';
final _adUnitId = '${dotenv.env['adID']}';

void createRewardedAd(BuildContext context) {
  RewardedAd.load(
    adUnitId: _adUnitId,
    request: const AdRequest(),
    rewardedAdLoadCallback: RewardedAdLoadCallback(
      onAdLoaded: (ad) async {
        _rewardedAd = ad;
        adLoaded = true;
        //showRewardedAd(context);
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
        createRewardedAd(context);
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
      },
    );
    _rewardedAd?.show(
      onUserEarnedReward: (ad, reward) async {
        await plus_Coins_Model('ads');
        try {
          var get_Coins;
          var coins_data;
          var coins_data2;
          //Get coins from database
          get_Coins = await get_Coins_Model();
          if (get_Coins.statusCode == 200) {
            //Decode
            coins_data = json.decode(get_Coins.body);
            coins_data2 = coins_data[0]['coins'];
            Provider.of<UserState>(context, listen: false)
                .setUserId(coins: coins_data2);
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return Report_Modal(
                    context: context,
                    labelTexts: AppLocale.getString(
                      context,
                      AppLocale.error_big_text_1,
                      languageCode: current_locale,
                    ),
                    its_error: true);
              },
            );
          }
        } catch (e) {}
      },
    );
    _rewardedAd = null;
  } catch (error) {}
}
