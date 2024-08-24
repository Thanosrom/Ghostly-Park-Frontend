//import 'dart:io';
import 'package:flutter/material.dart';
//Languages
import 'package:ghostlypark/src/Controller/Utils/load_save_language.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Billing.dart';
//Components
import 'package:ghostlypark/src/View/Components/Height_Spacer.dart';
import 'package:ghostlypark/src/View/Components/Small_Texts.dart';
//Libs
//import 'package:purchases_flutter/purchases_flutter.dart';

class Billing_Container extends StatefulWidget {
  final String what_is_the_product;
  final String what_is_about;
  final IconData? icon;
  final String? image;
  final String what_to_buy_button;
  final bool icon_exist;

  const Billing_Container({
    Key? key,
    required this.what_is_the_product,
    required this.what_is_about,
    this.icon,
    this.image,
    required this.what_to_buy_button,
    required this.icon_exist,
  }) : super(key: key);

  @override
  _Billing_Container_State createState() => _Billing_Container_State();
}

class _Billing_Container_State extends State<Billing_Container> {
  //Languages
  String? current_locale;
  //bool _purchaseInProgress = false;

  @override
  void initState() {
    super.initState();
    initializePurchases(context);
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
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Height_Spacer(),
        Container(
          padding: EdgeInsets.all(
            screenWidth <= 414
                ? screenWidth * 0.05
                : screenWidth <= 810
                    ? screenWidth * 0.05
                    : screenWidth * 0.05,
          ),
          width: screenWidth <= 414
              ? screenWidth * 0.5
              : screenWidth <= 810
                  ? screenWidth * 0.4
                  : screenWidth * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              screenWidth <= 414
                  ? screenWidth * 0.05
                  : screenWidth <= 810
                      ? screenWidth * 0.05
                      : screenWidth * 0.05,
            ),
            border: Border.all(
              color: const Color.fromARGB(255, 100, 7, 223),
              width: screenWidth <= 414
                  ? screenWidth * 0.005
                  : screenWidth <= 810
                      ? screenWidth * 0.005
                      : screenWidth * 0.005,
            ),
          ),
          child: Column(
            children: [
              Small_Texts(
                center: true,
                smallText: widget.what_is_about,
                avoid_flex: true,
              ),
              Height_Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 100, 7, 223),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth <= 414
                        ? screenWidth * 0.005
                        : screenWidth <= 810
                            ? screenWidth * 0.005
                            : screenWidth * 0.005),
                  ),
                ),
                onPressed: () async {
                  await purchaseProduct(widget.what_is_the_product, context);
                },
                child: Padding(
                  padding: EdgeInsets.all(screenWidth <= 414
                      ? screenWidth * 0.02
                      : screenWidth <= 810
                          ? screenWidth * 0.02
                          : screenWidth * 0.02),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      widget.icon_exist
                          ? Icon(
                              widget.icon,
                              size: screenWidth <= 414
                                  ? screenWidth * 0.05
                                  : screenWidth <= 810
                                      ? screenWidth * 0.05
                                      : screenWidth * 0.05,
                              color: Colors.black54,
                            )
                          : Image.asset(
                              widget.image!,
                              fit: BoxFit.contain,
                              width: screenWidth <= 414
                                  ? screenWidth * 0.05
                                  : screenWidth <= 810
                                      ? screenWidth * 0.05
                                      : screenWidth * 0.05,
                              height: screenWidth <= 414
                                  ? screenWidth * 0.05
                                  : screenWidth <= 810
                                      ? screenWidth * 0.05
                                      : screenWidth * 0.05,
                            ),
                      Height_Spacer(),
                      Small_Texts(
                        center: true,
                        smallText: widget.what_to_buy_button,
                        avoid_flex: true,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Height_Spacer(),
        Height_Spacer(),
      ],
    );
  }
}
