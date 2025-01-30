//ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Utils/Go_Back.dart';
import 'package:ghostlypark/src/Controller/Utils/load_Save_Language.dart';
//Components
import 'package:ghostlypark/src/View/Components/Circular_Indicator.dart';
import 'package:ghostlypark/src/View/Components/Height_Spacer.dart';
import 'package:ghostlypark/src/View/Components/Settings_Modals_Buttons.dart';
import 'package:ghostlypark/src/View/Components/Custom_TextFields.dart';

class Small_Textfield_Modal extends StatefulWidget {
  final BuildContext context;
  final TextEditingController? Controller;
  final TextEditingController? secondController;
  final TextEditingController? thirdController;
  final String labelTexts;
  final String? second_labelTexts;
  final String? third_labelTexts;
  final VoidCallback? sendNew;
  final IconData? icon;
  final bool? havePass;
  final bool? two_fields;
  final bool? three_fields;

  Small_Textfield_Modal({
    this.sendNew,
    required this.context,
    this.Controller,
    this.secondController,
    this.thirdController,
    required this.labelTexts,
    this.second_labelTexts,
    this.third_labelTexts,
    this.icon,
    bool? havePass,
    this.two_fields,
    this.three_fields,
  }) : havePass = havePass ?? false;

  @override
  _Small_Textfield_Modal_State createState() => _Small_Textfield_Modal_State();
}

class _Small_Textfield_Modal_State extends State<Small_Textfield_Modal> {
  //Languages
  String? current_locale;
  //Loading
  bool isLoading = false;
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
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            screenWidth <= 414
                ? screenWidth * 0.05
                : screenWidth <= 810
                    ? screenWidth * 0.05
                    : screenWidth * 0.05,
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(
          screenWidth <= 414
              ? screenWidth * 0.05
              : screenWidth <= 810
                  ? screenWidth * 0.05
                  : screenWidth * 0.05,
        ),
        width: screenWidth <= 414
            ? screenWidth * 0.8
            : screenWidth <= 810
                ? screenWidth * 0.65
                : screenWidth * 0.65,
        height: widget.three_fields == true
            ? screenWidth <= 414
                ? screenWidth * 1
                : screenWidth <= 810
                    ? screenWidth * 0.7
                    : screenWidth * 0.7
            : screenWidth <= 414
                ? screenWidth * 0.7
                : screenWidth <= 810
                    ? screenWidth * 0.55
                    : screenWidth * 0.55,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.9),
          borderRadius: BorderRadius.circular(
            screenWidth <= 414
                ? screenWidth * 0.05
                : screenWidth <= 810
                    ? screenWidth * 0.05
                    : screenWidth * 0.05,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.white70.withOpacity(0.5),
              offset: Offset(0, 4),
              blurRadius: screenWidth <= 414
                  ? screenWidth * 0.01
                  : screenWidth <= 810
                      ? screenWidth * 0.01
                      : screenWidth * 0.01,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Custom_TextField(
                themeController: widget.Controller!,
                labelTexts: widget.labelTexts,
                havePassword: widget.havePass!,
                icon: widget.icon),
            if (widget.two_fields == true) ...[
              Height_Spacer(),
              Custom_TextField(
                  themeController: widget.secondController!,
                  labelTexts: widget.second_labelTexts!,
                  havePassword: widget.havePass!,
                  icon: widget.icon),
            ],
            if (widget.three_fields == true) ...[
              Height_Spacer(),
              Custom_TextField(
                  themeController: widget.thirdController!,
                  labelTexts: widget.third_labelTexts!,
                  havePassword: widget.havePass!,
                  icon: widget.icon),
            ],
            Height_Spacer(),
            Height_Spacer(),
            Settings_Modals_Buttons(
              label_text: AppLocale.getString(
                  context, AppLocale.small_textfield_change_text,
                  languageCode: current_locale),
              onPressed: () => {
                setState(() {
                  isLoading = true;
                }),
                widget.sendNew!(),
                setState(() {
                  isLoading = false;
                }),
              },
            ),
            Height_Spacer(),
            Settings_Modals_Buttons(
              label_text: AppLocale.getString(context, AppLocale.close_text,
                  languageCode: current_locale),
              onPressed: () => Go_Back(context),
            ),
            Visibility(
              visible: isLoading,
              child: const Circular_Indicator(isTransparent: true),
            ),
          ],
        ),
      ),
    );
  }
}
