// ignore_for_file: use_build_context_synchronously, unused_local_variable, non_constant_identifier_names, unused_catch_clause
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//.env
import 'package:flutter_dotenv/flutter_dotenv.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Utils/load_Save_Language.dart';
import 'package:ghostlypark/src/Model/Providers%20-%20Stores/UserState.dart';
//Components
import 'package:ghostlypark/src/View/Components/Modals/Report_Modal.dart';
//Models
import 'package:ghostlypark/src/Model/SubscriptionsCoinsGems.dart';
import 'package:provider/provider.dart';
//Libs
import 'package:purchases_flutter/purchases_flutter.dart';

String? current_locale;
void initializeSettings(BuildContext context) async {
  bool isInitialized = false;
  if (!isInitialized) {
    //Languages
    current_locale = await load_Selected_Language();
    isInitialized = true;
  }
}

Future<List<String>> initializePurchases(BuildContext context) async {
  initializeSettings(context);

  await Purchases.setLogLevel(LogLevel.error);
  PurchasesConfiguration? configuration;

  if (Platform.isAndroid) {
    configuration = PurchasesConfiguration('${dotenv.env['revenueCatAPI']}');
  } else {
    // Add iOS configuration if necessary
  }
  if (configuration != null) {
    await Purchases.configure(configuration);
  }

  try {
    Offerings offerings = await Purchases.getOfferings();
    List<String> prices = [];
    for (var offering in offerings.all.values) {
      String? priceString_Coins =
          offerings.all['Coins']?.availablePackages[0].storeProduct.priceString;
      String? priceString_Gems =
          offerings.all['Gems']?.availablePackages[0].storeProduct.priceString;
      String? priceString_Subscription = offerings
          .all['Subscription']?.availablePackages[0].storeProduct.priceString;
      prices.add(priceString_Coins ?? '');
      prices.add(priceString_Gems ?? '');
      prices.add(priceString_Subscription ?? '');
    }
    return prices;
  } on PlatformException catch (e) {
    return [];
  }
}

Future<void> purchaseProduct(
    String whatIsTheProduct, BuildContext context) async {
  try {
    initializeSettings(context);
    List<String> identifiers = ["\$rc_lifetime", "\$rc_monthly", "\$rc_weekly"];
    Offerings offerings = await Purchases.getOfferings();
    Offering? coinsOffering = offerings.all[whatIsTheProduct];
    if (coinsOffering != null) {
      Package? package = coinsOffering.availablePackages.firstWhere(
        (pkg) => identifiers.contains(pkg.identifier),
        // orElse: () => null,
      );

      try {
        CustomerInfo customerInfo = await Purchases.purchasePackage(package);
        if (customerInfo.entitlements.all["Free"]?.isActive ?? false) {
          //Purchase Subscription
          if (whatIsTheProduct == "Subscription") {
            final get_Subscription = await get_subscription_Model();
            final subscription_body =
                json.decode(get_Subscription.body)[0]['subscription'];
            if (get_Subscription.statusCode == 200 && subscription_body == 0) {
              final response = await plus_Subscription_Model();
              if (response.statusCode == 200) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Report_Modal(
                      context: context,
                      labelTexts: AppLocale.getString(
                        context,
                        AppLocale.bought_subscription_small_text,
                        languageCode: current_locale,
                      ),
                      its_error: false,
                    );
                  },
                );
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Report_Modal(
                      context: context,
                      labelTexts: AppLocale.getString(
                        context,
                        AppLocale.failed_payment_small_text,
                        languageCode: current_locale,
                      ),
                      its_error: true,
                    );
                  },
                );
              }
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return Report_Modal(
                    context: context,
                    labelTexts: AppLocale.getString(
                      context,
                      AppLocale.already_have_subscription_small_text,
                      languageCode: current_locale,
                    ),
                    its_error: true,
                  );
                },
              );
            }
          }
          //Purchase Coins
          if (whatIsTheProduct == "Coins") {
            final response = await plus_Coins_Model('buy');
            if (response.statusCode == 200) {
              var get_Coins;
              var coins_data;
              var coins_data2;
              get_Coins = await get_Coins_Model();
              if (get_Coins.statusCode == 200) {
                //Decode
                coins_data = json.decode(get_Coins.body);
                coins_data2 = coins_data[0]['coins'];
                Provider.of<UserState>(context, listen: false)
                    .setUserId(coins: coins_data2);
                showDialog(
                  context: context,
                  builder: (context) {
                    return Report_Modal(
                      context: context,
                      labelTexts: AppLocale.getString(
                        context,
                        AppLocale.bought_coins_small_text,
                        languageCode: current_locale,
                      ),
                      its_error: false,
                    );
                  },
                );
              }
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return Report_Modal(
                    context: context,
                    labelTexts: AppLocale.getString(
                      context,
                      AppLocale.failed_payment_small_text,
                      languageCode: current_locale,
                    ),
                    its_error: false,
                  );
                },
              );
            }
          }
          //Purchase Gems
          if (whatIsTheProduct == "Gems") {
            final response = await plus_Gems_Model();
            if (response.statusCode == 200) {
              var get_Gems;
              var gems_data;
              var gems_data2;
              get_Gems = await get_Gems_Model();
              if (get_Gems.statusCode == 200) {
                //Decode
                gems_data = json.decode(get_Gems.body);
                gems_data2 = gems_data[0]['gems'];
                Provider.of<UserState>(context, listen: false)
                    .setUserId(gems: gems_data2);
                showDialog(
                  context: context,
                  builder: (context) {
                    return Report_Modal(
                      context: context,
                      labelTexts: AppLocale.getString(
                        context,
                        AppLocale.bought_gems_small_text,
                        languageCode: current_locale,
                      ),
                      its_error: false,
                    );
                  },
                );
              }
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return Report_Modal(
                    context: context,
                    labelTexts: AppLocale.getString(
                      context,
                      AppLocale.failed_payment_small_text,
                      languageCode: current_locale,
                    ),
                    its_error: false,
                  );
                },
              );
            }
          }
        } // } else if (customerInfo.entitlements.all["Pro"]?.isActive ?? false) {
        //   //Purchase Subscription
        //   if (whatIsTheProduct == "Subscription") {
        //     final response = await plus_Subscription_Model();
        //     if (response.statusCode == 200) {
        //       showDialog(
        //         context: context,
        //         builder: (context) {
        //           return Report_Modal(
        //             context: context,
        //             labelTexts: "Congrats you bought some Subscription...",
        //             its_error: false,
        //           );
        //         },
        //       );
        //     } else {
        //       showDialog(
        //         context: context,
        //         builder: (context) {
        //           return Report_Modal(
        //             context: context,
        //             labelTexts: "Failed Payment ...",
        //             its_error: false,
        //           );
        //         },
        //       );
        //     }
        //   }
        // } else {
        //   print("Purchase failed or not active.");
        // }
      } catch (e) {
        // print("Error during purchase: $e");
      }
    } else {
      //print("${whatIsTheProduct} offering not found.");
    }
  } catch (e) {
    //print("Error fetching offerings: $e");
  } finally {}
}
