// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Utils/load_Save_Language.dart';
//Components
import 'package:ghostlypark/src/View/Components/Modals/Report_Modal.dart';
//Models
import 'package:ghostlypark/src/Model/SubscriptionsCoinsGems.dart';
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

Future<void> initializePurchases(BuildContext context) async {
  initializeSettings(context);

  await Purchases.setLogLevel(LogLevel.error);
  PurchasesConfiguration? configuration;
  try {
    Offerings offerings = await Purchases.getOfferings();
    print('======================================================');
    // Check if there's a current offering
    if (offerings.current != null) {
      // Access the available packages
      List<Package> packages = offerings.current!.availablePackages;
      print(
          '222222222======================================================2222222222222');

      // Print product details
      for (Package package in packages) {
        print(
            '33333333333======================================================3333333333333');

        StoreProduct product = package.storeProduct;
        print('Product Name: ${product.title}');
        print('Product Price: ${product.priceString}');
      }
    } else {
      print('No current offerings available.');
    }
  } on PlatformException catch (e) {
    // optional error handling
  }
  if (Platform.isAndroid) {
    print('Correct');
    configuration = PurchasesConfiguration("goog_gfhcJJpsiAmsjeepIZKgHKqfZWx");
  } else {
    // Add iOS configuration if necessary
  }

  if (configuration != null) {
    await Purchases.configure(configuration);
    //print('Configured RevenueCat');
  } else {
    //print("No configuration");
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
