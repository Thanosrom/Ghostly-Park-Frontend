// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Utils/Go_Back.dart';
import 'package:ghostlypark/src/Controller/Utils/load_Save_Language.dart';
//Components
import 'package:ghostlypark/src/View/Components/Small_Texts.dart';
import 'package:ghostlypark/src/View/Components/Height_Spacer.dart';
import 'package:ghostlypark/src/View/Components/Settings_Modals_Buttons.dart';

class Report_Modal extends StatefulWidget {
  final BuildContext context;
  final String labelTexts;
  final bool its_error;
  final int? errorCode;
  final bool? is_changed;

  Report_Modal({
    required this.context,
    required this.labelTexts,
    required this.its_error,
    this.errorCode,
    this.is_changed,
  });

  @override
  _Report_Modal_State createState() => _Report_Modal_State();
}

class _Report_Modal_State extends State<Report_Modal> {
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

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: screenWidth <= 414
            ? screenWidth * 0.5
            : screenWidth <= 810
                ? screenWidth * 0.5
                : screenWidth * 0.5,
        height: screenWidth <= 414
            ? screenWidth * 0.6
            : screenWidth <= 810
                ? screenWidth * 0.4
                : screenWidth * 0.4,
        padding: EdgeInsets.only(
          right: screenWidth <= 414
              ? screenWidth * 0.05
              : screenWidth <= 810
                  ? screenWidth * 0.05
                  : screenWidth * 0.05,
          left: screenWidth <= 414
              ? screenWidth * 0.05
              : screenWidth <= 810
                  ? screenWidth * 0.05
                  : screenWidth * 0.05,
        ),
        decoration: BoxDecoration(
          color: widget.its_error
              ? Colors.red.withOpacity(0.65)
              : Colors.black.withOpacity(0.9),
          borderRadius: BorderRadius.all(
            Radius.circular(
              screenWidth <= 414
                  ? screenWidth * 0.05
                  : screenWidth <= 810
                      ? screenWidth * 0.05
                      : screenWidth * 0.05,
            ),
          ),
          // boxShadow: [
          //   BoxShadow(
          //     color: widget.its_error
          //         ? Colors.red.withOpacity(0.5)
          //         : const Color(0xA216141D).withOpacity(0.5),
          //     offset: Offset(0, 4),
          //     blurRadius: screenWidth <= 414
          //         ? screenWidth * 0.01
          //         : screenWidth <= 810
          //             ? screenWidth * 0.01
          //             : screenWidth * 0.01,
          //   ),
          // ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Small_Texts(
                avoid_flex: false, smallText: widget.labelTexts, center: true),
            Height_Spacer(),
            if (widget.its_error == true) ...[
              Icon(
                Icons.dangerous,
                color: Colors.white54,
                size: screenWidth <= 414
                    ? screenWidth * 0.13
                    : screenWidth <= 810
                        ? screenWidth * 0.1
                        : screenWidth * 0.1,
              ),
              Height_Spacer(),
            ],
            if (widget.is_changed == true) ...[
              Icon(
                Icons.check,
                color: Colors.green,
                size: screenWidth <= 414
                    ? screenWidth * 0.13
                    : screenWidth <= 810
                        ? screenWidth * 0.1
                        : screenWidth * 0.1,
              ),
              Height_Spacer(),
            ],
            Container(
              child: Column(
                children: [
                  Settings_Modals_Buttons(
                      onPressed: () => Go_Back(context),
                      label_text: AppLocale.getString(
                          context, AppLocale.close_text,
                          languageCode: current_locale),
                      its_error: widget.its_error)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
