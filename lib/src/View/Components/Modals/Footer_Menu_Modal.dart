// ignore_for_file: camel_case_types, use_build_context_synchronously
import 'dart:async';
import 'package:flutter/material.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Utils/Go_Back.dart';
import 'package:ghostlypark/src/Controller/Utils/Handle_Button_Clicks.dart';
import 'package:ghostlypark/src/Controller/Utils/load_Save_Delete_UserInfo.dart';
import 'package:ghostlypark/src/Controller/Utils/load_Save_Language.dart';
//Routes
import 'package:ghostlypark/src/Controller/Routes/Routes.dart';
//Components
import 'package:ghostlypark/src/View/Components/Small_Texts.dart';
//Screens
import 'package:ghostlypark/src/Controller/Ads.dart';

class Footer_Menu_Modal extends StatefulWidget {
  final BuildContext context;
  final VoidCallback onPressed_FindMe;

  Footer_Menu_Modal({
    super.key,
    required this.context,
    required this.onPressed_FindMe,
  });

  @override
  _Footer_Menu_Modal_State createState() => _Footer_Menu_Modal_State();
}

//Timer for auto-location GPS
bool isAutoLocation_Enabled = false;
late Timer timer;

class _Footer_Menu_Modal_State extends State<Footer_Menu_Modal> {
  //Languages
  String? current_locale;

  @override
  void initState() {
    createRewardedAd(context);
    super.initState();
    load_Selected_Language().then((value) {
      setState(() {
        current_locale = value;
      });
    });
  }

  //Timers
  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      widget.onPressed_FindMe();
    });
  }

  void cancelTimer() {
    if (timer.isActive) {
      timer.cancel();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: screenWidth <= 414
                  ? screenWidth * 0.5
                  : screenWidth <= 810
                      ? screenWidth * 0.5
                      : screenWidth * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: Colors.white70,
                          size: screenWidth <= 414
                              ? screenWidth * 0.07
                              : screenWidth <= 810
                                  ? screenWidth * 0.05
                                  : screenWidth * 0.05,
                        ),
                        SizedBox(
                          width: screenWidth <= 414
                              ? screenWidth * 0.01
                              : screenWidth <= 810
                                  ? screenWidth * 0.01
                                  : screenWidth * 0.01,
                        ),
                        Small_Texts(
                          avoid_flex: false,
                          smallText: AppLocale.getString(
                              context, AppLocale.profile_small_text,
                              languageCode: current_locale),
                        )
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.user_profile);
                    },
                  ),
                  SizedBox(
                    height: screenWidth <= 414
                        ? screenWidth * 0.01
                        : screenWidth <= 810
                            ? screenWidth * 0.02
                            : screenWidth * 0.02,
                  ),
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.gps_fixed,
                          color: Colors.white70,
                          size: screenWidth <= 414
                              ? screenWidth * 0.07
                              : screenWidth <= 810
                                  ? screenWidth * 0.05
                                  : screenWidth * 0.05,
                        ),
                        SizedBox(
                          width: screenWidth <= 414
                              ? screenWidth * 0.01
                              : screenWidth <= 810
                                  ? screenWidth * 0.01
                                  : screenWidth * 0.01,
                        ),
                        Small_Texts(
                          avoid_flex: false,
                          smallText: AppLocale.getString(
                              context, AppLocale.gps_auto_location_small_text,
                              languageCode: current_locale),
                        ),
                        SizedBox(
                          width: screenWidth <= 414
                              ? screenWidth * 0.01
                              : screenWidth <= 810
                                  ? screenWidth * 0.01
                                  : screenWidth * 0.01,
                        ),
                        Switch(
                          activeTrackColor: Color.fromARGB(255, 100, 7, 223),
                          value: isAutoLocation_Enabled,
                          onChanged: (bool value) {
                            setState(() {
                              isAutoLocation_Enabled = value;
                              if (isAutoLocation_Enabled) {
                                startTimer();
                              } else {
                                cancelTimer();
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screenWidth <= 414
                        ? screenWidth * 0.01
                        : screenWidth <= 810
                            ? screenWidth * 0.01
                            : screenWidth * 0.01,
                  ),
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.ads_click,
                          color: Colors.white70,
                          size: screenWidth <= 414
                              ? screenWidth * 0.07
                              : screenWidth <= 810
                                  ? screenWidth * 0.05
                                  : screenWidth * 0.05,
                        ),
                        SizedBox(
                          width: screenWidth <= 414
                              ? screenWidth * 0.01
                              : screenWidth <= 810
                                  ? screenWidth * 0.01
                                  : screenWidth * 0.01,
                        ),
                        Small_Texts(
                          avoid_flex: false,
                          smallText: AppLocale.getString(
                              context, AppLocale.see_an_ad_text,
                              languageCode: current_locale),
                        ),
                      ],
                    ),
                    onTap: () async {
                      //See Adds first
                      if (await handle_Button_Click('onPressed_Ad')) {
                        showRewardedAd(context);
                      }
                    },
                  ),
                  SizedBox(
                    height: screenWidth <= 414
                        ? screenWidth * 0.01
                        : screenWidth <= 810
                            ? screenWidth * 0.02
                            : screenWidth * 0.02,
                  ),
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.white70,
                          size: screenWidth <= 414
                              ? screenWidth * 0.07
                              : screenWidth <= 810
                                  ? screenWidth * 0.05
                                  : screenWidth * 0.05,
                        ),
                        SizedBox(
                          width: screenWidth <= 414
                              ? screenWidth * 0.01
                              : screenWidth <= 810
                                  ? screenWidth * 0.01
                                  : screenWidth * 0.01,
                        ),
                        Small_Texts(
                          avoid_flex: false,
                          smallText: AppLocale.getString(
                              context, AppLocale.log_out_small_text,
                              languageCode: current_locale),
                        )
                      ],
                    ),
                    onTap: () async {
                      await delete_Credentials();
                      await signOutUser();
                      Navigator.pushNamed(context, AppRoutes.login);
                    },
                  ),
                  SizedBox(
                    height: screenWidth <= 414
                        ? screenWidth * 0.01
                        : screenWidth <= 810
                            ? screenWidth * 0.02
                            : screenWidth * 0.02,
                  ),
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.close,
                          color: Colors.white70,
                          size: screenWidth <= 414
                              ? screenWidth * 0.07
                              : screenWidth <= 810
                                  ? screenWidth * 0.05
                                  : screenWidth * 0.05,
                        ),
                        SizedBox(
                          width: screenWidth <= 414
                              ? screenWidth * 0.01
                              : screenWidth <= 810
                                  ? screenWidth * 0.01
                                  : screenWidth * 0.01,
                        ),
                        Small_Texts(
                          smallText: AppLocale.getString(
                              context, AppLocale.close_text,
                              languageCode: current_locale),
                        )
                      ],
                    ),
                    onTap: () {
                      Go_Back(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
