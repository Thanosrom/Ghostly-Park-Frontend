import 'package:flutter/material.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Utils/load_save_language.dart';
import 'package:ghostlypark/src/Controller/Utils/Go_Back.dart';
//Theme
import 'package:ghostlypark/src/View/Theme/Layout.dart';
//Components
import 'package:ghostlypark/src/View/Components/Settings_Buttons.dart';
import 'package:ghostlypark/src/View/Components/Billing_Container.dart';
import 'package:ghostlypark/src/View/Components/Height_Spacer.dart';
import 'package:ghostlypark/src/View/Components/Big_Texts.dart';

class Billing extends StatefulWidget {
  const Billing({Key? key}) : super(key: key);

  @override
  _BillingState createState() => _BillingState();
}

class _BillingState extends State<Billing> {
  //Languages
  String? current_locale;

  @override
  void initState() {
    super.initState();
    load_Selected_Language().then((value) {
      setState(() {
        current_locale = value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: ContainerStyles.gradientBoxDecoration,
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Height_Spacer(),
                Height_Spacer(),
                Big_Texts(
                  bigText: AppLocale.getString(
                      context, AppLocale.subscription_big_text,
                      languageCode: current_locale),
                ),
                Height_Spacer(),
                Height_Spacer(),
                Billing_Container(
                  what_is_the_product: "Subscription",
                  what_is_about: AppLocale.getString(
                      context, AppLocale.subscription_small_text,
                      languageCode: current_locale),
                  icon: Icons.subscriptions,
                  icon_exist: true,
                  what_to_buy_button: AppLocale.getString(
                      context, AppLocale.subscription_button,
                      languageCode: current_locale),
                ),
                Big_Texts(
                  bigText: AppLocale.getString(
                      context, AppLocale.coins_and_gems_big_text,
                      languageCode: current_locale),
                ),
                Height_Spacer(),
                Height_Spacer(),
                Billing_Container(
                  what_is_the_product: "Coins",
                  what_is_about: AppLocale.getString(
                      context, AppLocale.coins_small_text,
                      languageCode: current_locale),
                  what_to_buy_button: AppLocale.getString(
                      context, AppLocale.coins_button,
                      languageCode: current_locale),
                  icon_exist: false,
                  image: 'assets/coin_2.png',
                ),
                Billing_Container(
                  what_is_the_product: "Gems",
                  what_is_about: AppLocale.getString(
                      context, AppLocale.gems_small_text,
                      languageCode: current_locale),
                  what_to_buy_button: AppLocale.getString(
                      context, AppLocale.gems_button,
                      languageCode: current_locale),
                  icon_exist: false,
                  image: 'assets/gem.png',
                ),
                Settings_Buttons(
                    title: AppLocale.getString(context, AppLocale.back_button,
                        languageCode: current_locale),
                    icon: Icons.arrow_back,
                    onPressed: () => {Go_Back(context)})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
