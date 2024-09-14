// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Utils/load_save_language.dart';
//Components
import 'package:ghostlypark/src/View/Components/Big_Texts.dart';
import 'package:ghostlypark/src/View/Components/Modals/Footer_Menu_Modal.dart';
import 'package:ghostlypark/src/View/Components/Small_Buttons.dart';
import 'package:ghostlypark/src/View/Components/Small_Texts.dart';
import 'package:ghostlypark/src/View/Components/Width_Spacer.dart';

class Home_Footer extends StatefulWidget {
  final VoidCallback onPressed_UnParked;
  //final VoidCallback onPressed_Parked;
  final VoidCallback onPressed_SearchMarkers;
  final VoidCallback onPressed_FindMe;
  Home_Footer({
    required this.onPressed_UnParked,
    //required this.onPressed_Parked,
    required this.onPressed_SearchMarkers,
    required this.onPressed_FindMe,
  });

  @override
  _Home_Footer createState() => _Home_Footer();
}

//Markers Colors
Gradient markerGradient1 = const LinearGradient(
  colors: [
    Color(0xFFF2C94C),
    Color(0xFFF2994A),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
Gradient markerGradient2 = const LinearGradient(
  colors: [
    Color.fromARGB(255, 212, 33, 33),
    Color.fromARGB(255, 189, 119, 119),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

class _Home_Footer extends State<Home_Footer> {
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

  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;

        return Container(
          width: double.infinity,
          height: screenWidth <= 414
              ? screenWidth * 0.2
              : screenWidth <= 810
                  ? screenWidth * 0.15
                  : screenWidth * 0.15,
          decoration: BoxDecoration(
            color: Colors.transparent.withOpacity(0.7),
            borderRadius: BorderRadius.circular(screenWidth <= 414
                ? screenWidth * 0.05
                : screenWidth <= 810
                    ? screenWidth * 0.05
                    : screenWidth * 0.05),
          ),
          margin: EdgeInsets.all(
            screenWidth <= 414
                ? screenWidth * 0.05
                : screenWidth <= 810
                    ? screenWidth * 0.05
                    : screenWidth * 0.05,
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: screenWidth <= 414
                      ? screenWidth * 0.007
                      : screenWidth <= 810
                          ? screenWidth * 0.007
                          : screenWidth * 0.007,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (Rect bounds) {
                        return markerGradient1.createShader(bounds);
                      },
                      child: Icon(
                        Icons.drive_eta,
                        size: screenWidth <= 414
                            ? screenWidth * 0.05
                            : screenWidth <= 810
                                ? screenWidth * 0.05
                                : screenWidth * 0.05,
                      ),
                    ),
                    Small_Texts(
                      avoid_flex: false,
                      smallText: AppLocale.getString(
                          context, AppLocale.minutes_text_5,
                          languageCode: current_locale),
                    ),
                    Width_Spacer(),
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (Rect bounds) {
                        return markerGradient2.createShader(bounds);
                      },
                      child: Icon(
                        Icons.drive_eta,
                        size: screenWidth <= 414
                            ? screenWidth * 0.05
                            : screenWidth <= 810
                                ? screenWidth * 0.05
                                : screenWidth * 0.05,
                      ),
                    ),
                    Small_Texts(
                      avoid_flex: false,
                      smallText: AppLocale.getString(
                          context, AppLocale.minutes_text_15,
                          languageCode: current_locale),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Small_Buttons(
                      onPressed: widget.onPressed_UnParked,
                      icon: Icons.directions_car,
                    ),
                    SizedBox(
                      width: screenWidth <= 414
                          ? screenWidth * 0.02
                          : screenWidth <= 810
                              ? screenWidth * 0.03
                              : screenWidth * 0.03,
                    ),
                    // Small_Buttons(
                    //   onPressed: widget.onPressed_Parked,
                    //   icon: Icons.local_parking,
                    // ),
                    Small_Buttons(
                      onPressed: widget.onPressed_SearchMarkers,
                      icon: Icons.local_parking_rounded,
                    ),
                    SizedBox(
                      width: screenWidth <= 414
                          ? screenWidth * 0.02
                          : screenWidth <= 810
                              ? screenWidth * 0.03
                              : screenWidth * 0.03,
                    ),
                    Small_Buttons(
                      onPressed: widget.onPressed_FindMe,
                      icon: Icons.location_searching,
                    ),
                    SizedBox(
                      width: screenWidth <= 414
                          ? screenWidth * 0.02
                          : screenWidth <= 810
                              ? screenWidth * 0.03
                              : screenWidth * 0.03,
                    ),
                    Small_Buttons(
                      onPressedWithContext: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor:
                                  Colors.transparent.withOpacity(0.2),
                              title: Center(
                                child: Big_Texts(
                                  bigText: AppLocale.getString(
                                      context, AppLocale.menu_big_text,
                                      languageCode: current_locale),
                                ),
                              ),
                              content: Footer_Menu_Modal(
                                context: context,
                                onPressed_FindMe: widget.onPressed_FindMe,
                              ),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Colors.white70,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.circular(
                                  screenWidth <= 414
                                      ? screenWidth * 0.08
                                      : screenWidth <= 810
                                          ? screenWidth * 0.05
                                          : screenWidth * 0.05,
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: Icons.menu,
                      widthFactor: screenWidth,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
