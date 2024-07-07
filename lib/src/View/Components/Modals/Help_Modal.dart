import 'package:flutter/material.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Utils/load_Save_Language.dart';
import 'package:ghostlypark/src/Controller/Utils/Go_Back.dart';
//Components
import 'package:ghostlypark/src/View/Components/Small_Buttons.dart';
import 'package:ghostlypark/src/View/Components/Small_Texts.dart';

class Help_Modal extends StatefulWidget {
  const Help_Modal({super.key});

  @override
  _Help_Modal_State createState() => _Help_Modal_State();
}

class _Help_Modal_State extends State<Help_Modal>
    with TickerProviderStateMixin {
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
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/coin.png',
                    fit: BoxFit.contain,
                    width: screenWidth <= 414
                        ? screenWidth * 0.04
                        : screenWidth <= 810
                            ? screenWidth * 0.03
                            : screenWidth * 0.03,
                    height: screenWidth <= 414
                        ? screenWidth * 0.04
                        : screenWidth <= 810
                            ? screenWidth * 0.03
                            : screenWidth * 0.03,
                  ),
                  SizedBox(
                    width: screenWidth <= 414
                        ? screenWidth * 0.05
                        : screenWidth <= 810
                            ? screenWidth * 0.05
                            : screenWidth * 0.05,
                  ),
                  Small_Texts(
                    avoid_flex: false,
                    smallText: AppLocale.getString(
                        context, AppLocale.help_modal_coins_small_text,
                        languageCode: current_locale),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenWidth <= 414
                  ? screenWidth * 0.01
                  : screenWidth <= 810
                      ? screenWidth * 0.03
                      : screenWidth * 0.03,
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/gem.png',
                    fit: BoxFit.contain,
                    width: screenWidth <= 414
                        ? screenWidth * 0.04
                        : screenWidth <= 810
                            ? screenWidth * 0.03
                            : screenWidth * 0.03,
                    height: screenWidth <= 414
                        ? screenWidth * 0.04
                        : screenWidth <= 810
                            ? screenWidth * 0.03
                            : screenWidth * 0.03,
                  ),
                  SizedBox(
                    width: screenWidth <= 414
                        ? screenWidth * 0.05
                        : screenWidth <= 810
                            ? screenWidth * 0.05
                            : screenWidth * 0.05,
                  ),
                  Small_Texts(
                    avoid_flex: false,
                    smallText: AppLocale.getString(
                        context, AppLocale.help_modal_gems_small_text,
                        languageCode: current_locale),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenWidth <= 414
                  ? screenWidth * 0.01
                  : screenWidth <= 810
                      ? screenWidth * 0.03
                      : screenWidth * 0.03,
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.search_off,
                    color: Colors.white70,
                    size: screenWidth <= 414
                        ? screenWidth * 0.05
                        : screenWidth <= 810
                            ? screenWidth * 0.05
                            : screenWidth * 0.05,
                  ),
                  SizedBox(
                    width: screenWidth <= 414
                        ? screenWidth * 0.05
                        : screenWidth <= 810
                            ? screenWidth * 0.05
                            : screenWidth * 0.05,
                  ),
                  Small_Texts(
                    avoid_flex: false,
                    smallText: AppLocale.getString(
                        context, AppLocale.help_modal_search_bar_small_text,
                        languageCode: current_locale),
                  ),
                ],
              ),
            ),
            // SizedBox(height: help_modal_sizes.sized_box_height),
            // ListTile(
            //   title: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: <Widget>[
            //       Small_Buttons(
            //         icon: Icons.local_parking,
            //       ),
            //       SizedBox(width: help_modal_sizes.sized_box_width),
            //       Flexible(
            //         child: Small_Texts(
            //           smallText: AppLocale.getString(context,
            //               AppLocale.help_modal_parking_button_small_text,
            //               languageCode: current_locale),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: screenWidth <= 414
                  ? screenWidth * 0.01
                  : screenWidth <= 810
                      ? screenWidth * 0.03
                      : screenWidth * 0.03,
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Small_Buttons(
                    icon: Icons.directions_car,
                  ),
                  SizedBox(
                    width: screenWidth <= 414
                        ? screenWidth * 0.05
                        : screenWidth <= 810
                            ? screenWidth * 0.05
                            : screenWidth * 0.05,
                  ),
                  Small_Texts(
                    avoid_flex: false,
                    smallText: AppLocale.getString(context,
                        AppLocale.help_modal_unparked_button_small_text,
                        languageCode: current_locale),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenWidth <= 414
                  ? screenWidth * 0.01
                  : screenWidth <= 810
                      ? screenWidth * 0.03
                      : screenWidth * 0.03,
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Small_Buttons(
                    icon: Icons.local_parking_rounded,
                  ),
                  SizedBox(
                    width: screenWidth <= 414
                        ? screenWidth * 0.05
                        : screenWidth <= 810
                            ? screenWidth * 0.05
                            : screenWidth * 0.05,
                  ),
                  Small_Texts(
                    avoid_flex: false,
                    smallText: AppLocale.getString(
                        context, AppLocale.help_modal_search_button_small_text,
                        languageCode: current_locale),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenWidth <= 414
                  ? screenWidth * 0.01
                  : screenWidth <= 810
                      ? screenWidth * 0.03
                      : screenWidth * 0.03,
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Small_Buttons(
                    icon: Icons.location_searching,
                  ),
                  SizedBox(
                    width: screenWidth <= 414
                        ? screenWidth * 0.05
                        : screenWidth <= 810
                            ? screenWidth * 0.05
                            : screenWidth * 0.05,
                  ),
                  Small_Texts(
                    avoid_flex: false,
                    smallText: AppLocale.getString(context,
                        AppLocale.help_modal_gps_locate_button_small_text,
                        languageCode: current_locale),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenWidth <= 414
                  ? screenWidth * 0.01
                  : screenWidth <= 810
                      ? screenWidth * 0.03
                      : screenWidth * 0.03,
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Small_Buttons(
                    icon: Icons.menu,
                  ),
                  SizedBox(
                    width: screenWidth <= 414
                        ? screenWidth * 0.05
                        : screenWidth <= 810
                            ? screenWidth * 0.05
                            : screenWidth * 0.05,
                  ),
                  Small_Texts(
                    avoid_flex: false,
                    smallText: AppLocale.getString(
                        context, AppLocale.help_modal_menu_button_small_text,
                        languageCode: current_locale),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenWidth <= 414
                  ? screenWidth * 0.01
                  : screenWidth <= 810
                      ? screenWidth * 0.03
                      : screenWidth * 0.03,
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
                        ? screenWidth * 0.05
                        : screenWidth <= 810
                            ? screenWidth * 0.04
                            : screenWidth * 0.04,
                  ),
                  SizedBox(
                    width: screenWidth <= 414
                        ? screenWidth * 0.05
                        : screenWidth <= 810
                            ? screenWidth * 0.05
                            : screenWidth * 0.05,
                  ),
                  Small_Texts(
                    avoid_flex: false,
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
    );
  }
}
