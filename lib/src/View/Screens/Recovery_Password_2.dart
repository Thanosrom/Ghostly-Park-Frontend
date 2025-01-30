// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Recovery.dart';
import 'package:ghostlypark/src/Controller/Utils/Go_Back.dart';
import 'package:ghostlypark/src/Controller/Utils/Handle_Button_Clicks.dart';
import 'package:ghostlypark/src/Controller/Utils/load_save_language.dart';
//Components
import 'package:ghostlypark/src/View/Components/Big_Buttons.dart';
import 'package:ghostlypark/src/View/Components/Height_Spacer.dart';
import 'package:ghostlypark/src/View/Components/Big_Texts.dart';
import 'package:ghostlypark/src/View/Components/Custom_Card.dart';
import 'package:ghostlypark/src/View/Components/Secondary_Big_Buttons.dart';
//Theme
import 'package:ghostlypark/src/View/Theme/Layout.dart';

class Recovery_Password_2 extends StatefulWidget {
  //Variables for the constructor
  final String email;
  const Recovery_Password_2(this.email, {Key? key}) : super(key: key);

  @override
  _Recovery_Password_State createState() => _Recovery_Password_State();
}

class _Recovery_Password_State extends State<Recovery_Password_2> {
  //Variables
  List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());

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
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
                Big_Texts(
                  bigText: AppLocale.getString(
                      context, AppLocale.digit_code_big_text,
                      languageCode: current_locale),
                ),
                Height_Spacer(),
                Height_Spacer(),
                Height_Spacer(),
                Custom_Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: List.generate(4, (index) {
                            return Container(
                              width: screenWidth <= 414
                                  ? screenWidth * 0.15
                                  : screenWidth <= 810
                                      ? screenWidth * 0.1
                                      : screenWidth * 0.1,
                              height: screenWidth <= 414
                                  ? screenWidth * 0.15
                                  : screenWidth <= 810
                                      ? screenWidth * 0.1
                                      : screenWidth * 0.1,
                              margin: EdgeInsets.symmetric(
                                horizontal: screenWidth <= 414
                                    ? screenWidth * 0.02
                                    : screenWidth <= 810
                                        ? screenWidth * 0.02
                                        : screenWidth * 0.02,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.transparent.withOpacity(0.2),
                                border: Border.all(
                                  color: Color.fromARGB(255, 100, 7, 223),
                                  width: screenWidth <= 414
                                      ? screenWidth * 0.01
                                      : screenWidth <= 810
                                          ? screenWidth * 0.01
                                          : screenWidth * 0.01,
                                ),
                                borderRadius: BorderRadius.circular(
                                  screenWidth <= 414
                                      ? screenWidth * 0.02
                                      : screenWidth <= 810
                                          ? screenWidth * 0.02
                                          : screenWidth * 0.02,
                                ),
                              ),
                              child: Center(
                                child: TextField(
                                  controller: controllers[index],
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: screenWidth <= 414
                                          ? screenWidth * 0.05
                                          : screenWidth <= 810
                                              ? screenWidth * 0.04
                                              : screenWidth * 0.04,
                                      color: Colors.white54),
                                  decoration: const InputDecoration(
                                    counterText: '',
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value) {
                                    if (value.length == 1 && index < 3) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      Height_Spacer(),
                      Height_Spacer(),
                      Height_Spacer(),
                      Big_Button(
                          buttonText: AppLocale.getString(
                              context, AppLocale.verify_big_button,
                              languageCode: current_locale),
                          onPressed: () async {
                            if (await handle_Button_Click(
                                'Recovery_Password_2')) {
                              String combinedCode = controllers
                                  .map((controller) => controller.text)
                                  .join();
                              reset_Password_Digits_Check(
                                  context, combinedCode, widget.email);
                              for (var controller in controllers) {
                                controller.clear();
                              }
                            }
                          }),
                      Height_Spacer(),
                      Secondary_Big_Button(
                        buttonText: AppLocale.getString(
                            context, AppLocale.back_button,
                            languageCode: current_locale),
                        onPressed: () => Go_Back(context),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
