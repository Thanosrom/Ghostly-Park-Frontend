// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Utils/load_Save_Language.dart';
//Components
import 'package:ghostlypark/src/View/Components/Small_Texts.dart';

class Settings_Modals_Buttons extends StatefulWidget {
  final VoidCallback onPressed;
  final String label_text;
  final bool? its_error;

  const Settings_Modals_Buttons(
      {super.key,
      required this.onPressed,
      required this.label_text,
      this.its_error});

  @override
  _Settings_Modals_Buttons_State createState() =>
      _Settings_Modals_Buttons_State();
}

class _Settings_Modals_Buttons_State extends State<Settings_Modals_Buttons> {
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
    final screenWidth = MediaQuery.of(context).size.width;

    final close_text = AppLocale.getString(
      context,
      AppLocale.close_text,
      languageCode: current_locale,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            widget.onPressed();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.label_text == close_text
                ? Colors.white
                : Color.fromARGB(255, 100, 7, 223),
            minimumSize: Size(
              double.infinity,
              screenWidth <= 414
                  ? screenWidth * 0.12
                  : screenWidth <= 810
                      ? screenWidth * 0.08
                      : screenWidth * 0.08,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                screenWidth <= 414
                    ? screenWidth * 0.005
                    : screenWidth <= 810
                        ? screenWidth * 0.005
                        : screenWidth * 0.005,
              ),
            ),
          ),
          child: Container(
            child: widget.label_text == close_text
                ? widget.its_error == true
                    ? Small_Texts(
                        center: true,
                        smallText: widget.label_text,
                        color: Colors.red,
                        avoid_flex: true,
                      )
                    : Small_Texts(
                        center: true,
                        smallText: widget.label_text,
                        color: Color.fromARGB(255, 100, 7, 223),
                        avoid_flex: true,
                      )
                : Small_Texts(
                    center: true,
                    smallText: widget.label_text,
                    color: Colors.white,
                    avoid_flex: true,
                  ),
          ),
        ),
      ],
    );
  }
}
