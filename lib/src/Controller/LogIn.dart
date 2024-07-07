// ignore_for_file: unnecessary_null_comparison, file_names, use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//.env
//import 'package:flutter_dotenv/flutter_dotenv.dart';
//Libs
//import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:google_sign_in/google_sign_in.dart';
//import 'package:sign_in_with_apple/sign_in_with_apple.dart';
//Providers
import 'package:ghostlypark/src/Model/Providers%20-%20Stores/UserState.dart';
//Routes
import 'package:ghostlypark/src/Controller/Routes/Routes.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Utils/load_Save_Language.dart';
import 'package:ghostlypark/src/Controller/Utils/handle_Button_Clicks.dart';
import 'package:ghostlypark/src/Controller/Utils/Validators.dart';
//Components
import 'package:ghostlypark/src/View/Components/Modals/Report_Modal.dart';
//Models
import 'package:ghostlypark/src/Model/LogIn.dart';

final storage = FlutterSecureStorage();

String? current_locale;
void initializeSettings(BuildContext context) async {
  bool isInitialized = false;
  if (!isInitialized) {
    //Languages
    current_locale = await load_Selected_Language();
    isInitialized = true;
  }
}

Future<void> login(
    String emailController, String passwordController, context) async {
  initializeSettings(context);
  if (emailController == null ||
      passwordController == null ||
      emailController.isEmpty ||
      passwordController.isEmpty) {
    initializeSettings(context);
    showDialog(
      context: context,
      builder: (context) {
        return Report_Modal(
            context: context,
            labelTexts: AppLocale.getString(
              context,
              AppLocale.email_or_password_fields_are_empty_small_text,
              languageCode: current_locale,
            ),
            its_error: true);
      },
    );
    return;
  }

  if (await handle_Button_Click('LogIn')) {
    if (emailController != null &&
        passwordController != null &&
        emailController.isNotEmpty &&
        passwordController.isNotEmpty) {
      if (isValidEmail(emailController) &&
          isValidPassword(passwordController)) {
        final response = await login_Model(emailController, passwordController);
        if (response.statusCode == 200) {
          //Set user profile variables
          final token = jsonDecode(response.body)['token'].toString();
          final email = jsonDecode(response.body)['email'].toString();
          final username = jsonDecode(response.body)['username'].toString();
          final carInfo = jsonDecode(response.body)['carInfo'].toString();
          final coins = jsonDecode(response.body)['coins'];
          final gems = jsonDecode(response.body)['gems'];

          //Save them into Provider
          Provider.of<UserState>(context, listen: false).setUserId(
              email: email,
              username: username,
              carInfo: carInfo,
              coins: coins,
              gems: gems);

          //Save token into shared Preferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          //Navigate into Home screen
          Navigator.pushNamed(context, AppRoutes.home);
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return Report_Modal(
                  context: context,
                  labelTexts: AppLocale.getString(
                    context,
                    AppLocale.email_and_password_are_not_correct,
                    languageCode: current_locale,
                  ),
                  its_error: true);
            },
          );
        }
      } else if (!isValidEmail(emailController)) {
        showDialog(
          context: context,
          builder: (context) {
            return Report_Modal(
              context: context,
              labelTexts: AppLocale.getString(
                context,
                AppLocale.email_is_false_small_text,
                languageCode: current_locale,
              ),
              its_error: true,
            );
          },
        );
        return;
      } else if (!isValidPassword(passwordController)) {
        showDialog(
          context: context,
          builder: (context) {
            return Report_Modal(
              context: context,
              labelTexts: AppLocale.getString(
                context,
                AppLocale.password_is_false_small_text,
                languageCode: current_locale,
              ),
              its_error: true,
            );
          },
        );
      }
      return;
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return Report_Modal(
              context: context,
              labelTexts: AppLocale.getString(
                context,
                AppLocale.error_big_text_1,
                languageCode: current_locale,
              ),
              its_error: true);
        },
      );
      return;
    }
  } else {
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return Report_Modal(
    //         context: context,
    //         labelTexts: AppLocale.getString(
    //           context,
    //           AppLocale.you_are_out_of_tries_small_text,
    //           languageCode: current_locale,
    //         ),
    //         its_error: true);
    //   },
    // );
  }
}

// final GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: ['email'],
//     clientId:
//         "860340204881-bsfs4uiplrbffk1sefhgs01ubrlpka1a.apps.googleusercontent.com");

// Future<void> signInWith_Google(BuildContext context) async {
//   try {
//     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//     if (googleUser != null) {
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       // print('Auth: ${googleUser}');
//       // print('Token: ${googleAuth.idToken!}');

//       final response = await http.post(
//         Uri.parse('${dotenv.env['baseUrl']}/auth_google'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(<String, String>{
//           'idToken': googleAuth.idToken!,
//         }),
//       );

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> user = jsonDecode(response.body);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//               content: Text('Sign in successful! Welcome ${user['name']}')),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to sign in with Google')),
//         );
//       }
//     }
//   } catch (error) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Error occurred during Google sign in: $error')),
//     );
//     //print(error);
//   }
// }

//Future<void> signInWith_Apple(BuildContext context) async {
//   try {
//     final credential = await SignInWithApple.getAppleIDCredential(
//       scopes: [
//         AppleIDAuthorizationScopes.email,
//         AppleIDAuthorizationScopes.fullName,
//       ],
//       webAuthenticationOptions: WebAuthenticationOptions(
//         clientId: 'your_client_id',
//         redirectUri: Uri.parse('your_redirect_uri'),
//       ),
//       nonce: 'example-nonce',
//       state: 'example-state',
//     );

//     //print(credential);

//     final signInWithAppleEndpoint = Uri(
//       scheme: 'http',
//       host: '${dotenv.env['baseUrl']}',
//       path: '/auth_apple',
//       queryParameters: <String, String>{
//         'code': credential.authorizationCode,
//         if (credential.givenName != null) 'firstName': credential.givenName!,
//         if (credential.familyName != null) 'lastName': credential.familyName!,
//         'useBundleId': 'false', // Adjust based on your platform
//         if (credential.state != null) 'state': credential.state!,
//       },
//     );

//     final session = await http.Client().post(signInWithAppleEndpoint);

//     //print(session);
//   } catch (e) {
//     //print('Error signing in with Apple: $e');
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text('Error signing in with Apple: $e'),
//     ));
//   }
// }
