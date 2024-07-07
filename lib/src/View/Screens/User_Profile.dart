// ignore_for_file: file_names, non_constant_identifier_names, camel_case_types
import 'dart:io';
import 'package:flutter/material.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//Controllers
import 'package:ghostlypark/src/Controller/User_Profile.dart';
import 'package:ghostlypark/src/Controller/Utils/Go_Back.dart';
import 'package:ghostlypark/src/Controller/Utils/load_save_language.dart';
//Providers
import 'package:ghostlypark/src/Model/Providers%20-%20Stores/UserState.dart';
import 'package:ghostlypark/src/Model/Providers%20-%20Stores/ImagePath.dart';
//Routes
import 'package:ghostlypark/src/Controller/Routes/Routes.dart';
//Components
import 'package:ghostlypark/src/View/Components/Height_Spacer.dart';
import 'package:ghostlypark/src/View/Components/Big_Texts.dart';
import 'package:ghostlypark/src/View/Components/Settings_Buttons.dart';
import 'package:ghostlypark/src/View/Components/Small_Texts.dart';
import 'package:ghostlypark/src/View/Components/Thin_White_Line.dart';
//Theme
import 'package:ghostlypark/src/View/Theme/Layout.dart';
//Libs
import 'package:provider/provider.dart';

class User_Profile extends StatefulWidget {
  const User_Profile({super.key});

  @override
  _User_ProfileState createState() => _User_ProfileState();
}

class _User_ProfileState extends State<User_Profile> {
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

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: ContainerStyles.gradientBoxDecoration,
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Big_Texts(
                  bigText: AppLocale.getString(
                      context, AppLocale.user_profile_big_text,
                      languageCode: current_locale),
                ),
                Height_Spacer(),
                Height_Spacer(),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    width: screenWidth <= 414
                        ? screenWidth * 0.8
                        : screenWidth <= 810
                            ? screenWidth * 0.6
                            : screenWidth * 0.6,
                    height: screenWidth <= 414
                        ? screenWidth * 0.6
                        : screenWidth <= 810
                            ? screenWidth * 0.55
                            : screenWidth * 0.55,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(100, 7, 223, 1),
                          Colors.blueAccent,
                        ],
                        stops: [0.5, 1],
                      ),
                      borderRadius: BorderRadius.circular(screenWidth <= 414
                          ? screenWidth * 0.05
                          : screenWidth <= 810
                              ? screenWidth * 0.05
                              : screenWidth * 0.05),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white54,
                                spreadRadius: screenWidth <= 414
                                    ? screenWidth * 0.05
                                    : screenWidth <= 810
                                        ? screenWidth * 0.1
                                        : screenWidth * 0.1,
                                blurRadius: screenWidth <= 414
                                    ? screenWidth * 0.05
                                    : screenWidth <= 810
                                        ? screenWidth * 0.1
                                        : screenWidth * 0.1,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: screenWidth <= 414
                                ? screenWidth * 0.1
                                : screenWidth <= 810
                                    ? screenWidth * 0.1
                                    : screenWidth * 0.1,
                            backgroundImage:
                                Provider.of<ImageState>(context).hasImagePath
                                    ? FileImage(
                                        File(Provider.of<ImageState>(context)
                                            .imagePath!),
                                      ) as ImageProvider<Object>?
                                    : AssetImage('assets/ghost_1.png'),
                          ),
                        ),
                        Height_Spacer(),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0,
                              screenWidth <= 414
                                  ? screenWidth * 0.05
                                  : screenWidth <= 810
                                      ? screenWidth * 0.05
                                      : screenWidth * 0.05,
                              0,
                              0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Small_Texts(
                                  avoid_flex: true,
                                  smallText: Provider.of<UserState>(context,
                                          listen: true)
                                      .email,
                                ),
                                Height_Spacer(),
                                Small_Texts(
                                  avoid_flex: true,
                                  smallText: Provider.of<UserState>(context,
                                          listen: true)
                                      .username,
                                ),
                                Height_Spacer(),
                                Small_Texts(
                                  avoid_flex: true,
                                  smallText: Provider.of<UserState>(context,
                                          listen: true)
                                      .carInfo,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Height_Spacer(),
                Height_Spacer(),
                Settings_Buttons(
                  title: AppLocale.getString(
                      context, AppLocale.upload_photo_big_button,
                      languageCode: current_locale),
                  icon: Icons.photo,
                  onPressed: () {
                    uploadPhoto(context);
                  },
                ),
                Height_Spacer(),
                Thin_White_Line(settings: true),
                Height_Spacer(),
                Settings_Buttons(
                  title: AppLocale.getString(
                      context, AppLocale.user_settings_big_button,
                      languageCode: current_locale),
                  icon: Icons.settings,
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.settings);
                  },
                ),
                Height_Spacer(),
                Settings_Buttons(
                    title: AppLocale.getString(
                        context, AppLocale.change_language_big_button,
                        languageCode: current_locale),
                    icon: Icons.language,
                    onPressed: () {
                      change_Language(context);
                    }),
                Height_Spacer(),
                Settings_Buttons(
                  title: AppLocale.getString(
                      context, AppLocale.add_a_payment_method_big_button,
                      languageCode: current_locale),
                  icon: Icons.money,
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.billing);
                  },
                ),
                Height_Spacer(),
                Settings_Buttons(
                  title: AppLocale.getString(context, AppLocale.back_button,
                      languageCode: current_locale),
                  icon: Icons.arrow_back,
                  onPressed: () {
                    Go_Back(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
