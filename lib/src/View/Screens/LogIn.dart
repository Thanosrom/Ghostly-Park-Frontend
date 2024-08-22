// ignore_for_file: use_build_context_synchronously, sort_child_properties_last
import 'dart:async';
import 'package:flutter/material.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
import 'package:ghostlypark/src/Controller/Utils/Handle_Button_Clicks.dart';
//Components
import 'package:ghostlypark/src/View/Components/Big_Buttons.dart';
import 'package:ghostlypark/src/View/Components/Height_Spacer.dart';
import 'package:ghostlypark/src/View/Components/Custom_Card.dart';
import 'package:ghostlypark/src/View/Components/Secondary_Big_Buttons.dart';
import 'package:ghostlypark/src/View/Components/Custom_TextFields.dart';
import 'package:ghostlypark/src/View/Components/Small_Texts.dart';
import 'package:ghostlypark/src/View/Components/Thin_White_Line.dart';
import 'package:ghostlypark/src/View/Components/Width_Spacer.dart';
import 'package:ghostlypark/src/View/Components/Modals/Report_Modal.dart';
//Routes
import 'package:ghostlypark/src/Controller/Routes/Routes.dart';
//Controllers
import 'package:ghostlypark/src/Controller/LogIn.dart';
import 'package:ghostlypark/src/Controller/Utils/load_Save_Delete_UserInfo.dart';
import 'package:ghostlypark/src/Controller/Utils/load_Save_Language.dart';
//Theme Data
import 'package:ghostlypark/src/View/Theme/Layout.dart';
//Libs
import 'package:flutter_localization/flutter_localization.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:sign_in_with_apple/sign_in_with_apple.dart';

//Google Config
GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: scopes,
);
const List<String> scopes = <String>['openid', 'profile'];

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> with TickerProviderStateMixin {
  //Text Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  //Animations variables
  bool animate = true;
  late AnimationController controller;
  //Localization
  late FlutterLocalization flutter_localization;
  String? current_locale;
  String selected_language = 'en';
  //Google Config Variables
  bool _isAuthorized = false;

  @override
  void initState() {
    super.initState();
    //Load Credentials
    load_Saved_Credentials(context);
    //Animations
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat(reverse: true);
    //Localization
    load_Selected_Language().then((value) {
      setState(() {
        current_locale = value;
      });
    });
    //_attemptSignInSilently();
  }

  void _attemptSignInSilently() async {
    try {
      GoogleSignInAccount? account = await _googleSignIn.signInSilently();
      if (account == null) {
        await _handleSignIn();
      } else {
        final googleSignInAuthentication = await account.authentication;
        bool token_verified =
            await send_Auth(googleSignInAuthentication.idToken);
        if (token_verified) {
          google_Login(account.email, context, token_verified);
        } else {}
      }
    } catch (error) {}
  }

  //Auth Scopes
  Future<void> _handleAuthorizeScopes() async {
    final bool isAuthorized = await _googleSignIn.requestScopes(scopes);
    setState(() {
      _isAuthorized = isAuthorized;
    });
  }

  //Handle Sign In - Sign Out
  Future<void> _handleSignIn() async {
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) {
        return null;
      }
      final googleSignInAuthentication = await account.authentication;
      bool token_verified = await send_Auth(googleSignInAuthentication.idToken);
      if (token_verified) {
        google_Login(account.email, context, token_verified);
      } else {}
    } catch (error) {}
  }

  Future<void> handleSignOut() async {
    try {
      await _googleSignIn.signOut();
      await _googleSignIn.disconnect();
      // setState(() {
      //   _currentUser = null;
      //   _userJson = null;
      // });
    } catch (e) {}
  }
  //Apple configuration

  //Language
  void setLocale(String? value) {
    setState(() {
      current_locale = value;
      save_Selected_Language(value!);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    emailController.dispose();
    passwordController.dispose();
    _googleSignIn.onCurrentUserChanged.drain();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: ContainerStyles.gradientBoxDecoration,
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            0,
                            0,
                            screenWidth <= 414
                                ? screenWidth * 0.05
                                : screenWidth <= 810
                                    ? screenWidth * 0.05
                                    : screenWidth * 0.05,
                            0),
                        child: DropdownButton<String>(
                          //value: selected_language,
                          icon: const Icon(
                            Icons.language,
                            color: Colors.white54,
                          ),
                          iconSize: screenWidth <= 414
                              ? screenWidth * 0.07
                              : screenWidth <= 810
                                  ? screenWidth * 0.05
                                  : screenWidth * 0.05,
                          //elevation: 16,
                          style: const TextStyle(
                            color: Colors.white54,
                          ),
                          dropdownColor: Color.fromARGB(255, 30, 39, 78),
                          underline: Container(
                            height: 0,
                            color: Colors.transparent,
                          ),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                selected_language = newValue;
                                setLocale(newValue);
                              });
                            }
                          },
                          items: <String>[
                            'en',
                            'gr',
                            'es',
                            'por',
                            'fr',
                            'de',
                            'ru',
                            'ja',
                            'ch',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value == 'en'
                                    ? 'English'
                                    : value == 'gr'
                                        ? 'Ελληνικά'
                                        : value == 'es'
                                            ? 'Español'
                                            : value == 'por'
                                                ? 'Português'
                                                : value == 'fr'
                                                    ? 'Français'
                                                    : value == 'de'
                                                        ? 'Deutsch'
                                                        : value == 'ru'
                                                            ? 'Русский'
                                                            : value == 'ja'
                                                                ? '日本語'
                                                                : value == 'ch'
                                                                    ? '中文'
                                                                    : 'en',
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    AnimatedBuilder(
                      animation: controller,
                      builder: (context, child) {
                        return Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.translationValues(
                              0.0,
                              -30.0 *
                                  (1 - (2 * (controller.value - 0.5)).abs()),
                              0.0),
                          child: child,
                        );
                      },
                      child: Image.asset(
                        'assets/ghost_1.png',
                        fit: BoxFit.contain,
                        width: screenWidth <= 414
                            ? screenWidth * 0.4
                            : screenWidth <= 810
                                ? screenWidth * 0.4
                                : screenWidth * 0.4,
                        height: screenWidth <= 414
                            ? screenWidth * 0.3
                            : screenWidth <= 810
                                ? screenWidth * 0.2
                                : screenWidth * 0.2,
                      ),
                    ),
                    Height_Spacer(),
                    Image.asset(
                      'assets/Logo_1.png',
                      fit: BoxFit.contain,
                      width: screenWidth <= 414
                          ? screenWidth * 0.5
                          : screenWidth <= 810
                              ? screenWidth * 0.4
                              : screenWidth * 0.4,
                      height: screenWidth <= 414
                          ? screenWidth * 0.2
                          : screenWidth <= 810
                              ? screenWidth * 0.2
                              : screenWidth * 0.2,
                    ),
                    // Height_Spacer(),
                    // Big_Texts(bigText: 'Log In'),
                    Height_Spacer(),
                    Height_Spacer(),
                    Custom_Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Custom_TextField(
                            labelTexts: AppLocale.getString(
                                context, AppLocale.email_textfield,
                                languageCode: current_locale),
                            havePassword: false,
                            themeController: emailController,
                            icon: Icons.person,
                            autofillHints: [AutofillHints.email],
                          ),
                          Height_Spacer(),
                          Custom_TextField(
                            labelTexts: AppLocale.getString(
                                context, AppLocale.password_textfield,
                                languageCode: current_locale),
                            havePassword: true,
                            themeController: passwordController,
                            icon: Icons.lock,
                            autofillHints: [AutofillHints.password],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.recovery);
                              },
                              child: Small_Texts(
                                smallText: AppLocale.getString(context,
                                    AppLocale.forgot_your_password_textbutton,
                                    languageCode: current_locale),
                                color: Colors.white54,
                                avoid_flex: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Custom_Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Big_Button(
                              buttonText: AppLocale.getString(
                                  context, AppLocale.login_button,
                                  languageCode: current_locale),
                              onPressed: () async {
                                if (await handle_Button_Click('LogIn')) {
                                  login(emailController.text,
                                      passwordController.text, context);
                                }
                                // emailController.clear();
                                // passwordController.clear();
                              }),
                          Height_Spacer(),
                          Secondary_Big_Button(
                              buttonText: AppLocale.getString(
                                  context, AppLocale.register_button,
                                  languageCode: current_locale),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.register);
                              }),
                          Height_Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Thin_White_Line(settings: false),
                              Width_Spacer(),
                              Text(
                                AppLocale.getString(context, AppLocale.or_text,
                                    languageCode: current_locale),
                                style: TextStyle(
                                  fontSize: screenWidth <= 414
                                      ? screenWidth * 0.03
                                      : screenWidth <= 810
                                          ? screenWidth * 0.03
                                          : screenWidth * 0.03,
                                  color: Colors.white54,
                                ),
                              ),
                              Width_Spacer(),
                              Thin_White_Line(settings: false),
                            ],
                          ),
                          Height_Spacer(),
                          Custom_Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Define a fixed size for the buttons
                                // ElevatedButton(
                                //   onPressed: _handleSignOut,
                                //   child: Text('Logout'),
                                // ),
                                // Height_Spacer(),
                                // ElevatedButton(
                                //   onPressed: _handleSignOut,
                                //   child: Text('Logout'),
                                // ),
                                // Height_Spacer(),
                                SizedBox(
                                  width: screenWidth <= 414
                                      ? screenWidth * 0.2
                                      : screenWidth <= 810
                                          ? screenWidth * 0.2
                                          : screenWidth * 0.2,
                                  height: screenWidth <= 414
                                      ? screenWidth * 0.12
                                      : screenWidth <= 810
                                          ? screenWidth * 0.08
                                          : screenWidth * 0.08,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (await handle_Button_Click('LogIn')) {
                                        _handleSignIn();
                                      }
                                    },
                                    child: Image.asset(
                                      'assets/google_logo.png',
                                      fit: BoxFit.contain,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          screenWidth <= 414
                                              ? screenWidth * 0.01
                                              : screenWidth <= 810
                                                  ? screenWidth * 0.01
                                                  : screenWidth * 0.01,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidth * 0.01,
                                ),
                                SizedBox(
                                  width: screenWidth <= 414
                                      ? screenWidth * 0.2
                                      : screenWidth <= 810
                                          ? screenWidth * 0.2
                                          : screenWidth * 0.2,
                                  height: screenWidth <= 414
                                      ? screenWidth * 0.12
                                      : screenWidth <= 810
                                          ? screenWidth * 0.08
                                          : screenWidth * 0.08,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      // final credential = await SignInWithApple
                                      //     .getAppleIDCredential(
                                      //   scopes: [
                                      //     AppleIDAuthorizationScopes.email,
                                      //     AppleIDAuthorizationScopes.fullName,
                                      //   ],
                                      //   webAuthenticationOptions:
                                      //       WebAuthenticationOptions(
                                      //     clientId:
                                      //         'com.ghostlypark.ghostlypark',
                                      //     redirectUri: Uri.parse(
                                      //         'https://ghostlypark.com'),
                                      //   ),
                                      //   nonce: 'example-nonce',
                                      //   state: 'example-state',
                                      // );
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Report_Modal(
                                              context: context,
                                              labelTexts: AppLocale.getString(
                                                context,
                                                AppLocale
                                                    .currently_out_of_use_small_text,
                                                languageCode: current_locale,
                                              ),
                                              its_error: true);
                                        },
                                      );
                                    },
                                    child: Image.asset(
                                      'assets/apple_logo.png',
                                      fit: BoxFit.contain,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          screenWidth <= 414
                                              ? screenWidth * 0.01
                                              : screenWidth <= 810
                                                  ? screenWidth * 0.01
                                                  : screenWidth * 0.01,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Height_Spacer(),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.privacy_policy_and_terms);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Small_Texts(
                                    avoid_flex: false,
                                    center: true,
                                    smallText: '',
                                    textSpans: [
                                      TextSpan(
                                        text: AppLocale.getString(
                                            context, AppLocale.privacy_text,
                                            languageCode: current_locale),
                                      ),
                                      TextSpan(
                                        text: AppLocale.getString(context,
                                            AppLocale.privacy_textbutton,
                                            languageCode: current_locale),
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 100, 7, 223),
                                        ),
                                      ),
                                      TextSpan(
                                        text: AppLocale.getString(
                                            context, AppLocale.terms_text,
                                            languageCode: current_locale),
                                      ),
                                      TextSpan(
                                        text: AppLocale.getString(
                                            context, AppLocale.terms_textbutton,
                                            languageCode: current_locale),
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 100, 7, 223),
                                        ),
                                      ),
                                    ],
                                    color: Colors.white54),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
