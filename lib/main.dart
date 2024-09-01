// ignore_for_file: unused_import, prefer_const_constructors
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Utils/load_Save_Delete_UserInfo.dart';
//Components
import 'package:ghostlypark/src/View/Components/Circular_Indicator.dart';
//Headers
import 'package:ghostlypark/src/Model/Headers.dart';
//Libs
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
//Routes
import 'package:ghostlypark/src/Controller/Routes/Routes.dart';
//Screens-Files
import 'package:ghostlypark/src/View/Screens/Landing_Page.dart';
import 'package:ghostlypark/src/View/Screens/Maintenance.dart';
import 'package:ghostlypark/src/View/Screens/Error.dart';
import 'package:ghostlypark/src/Controller/Ads.dart';
import 'package:ghostlypark/src/View/Screens/Update.dart';
import 'package:ghostlypark/src/View/Screens/Billing.dart';
//Providers
import 'package:ghostlypark/src/Model/Providers%20-%20Stores/UserState.dart';
import 'package:ghostlypark/src/Model/Providers%20-%20Stores/Coins_And_Gems.dart';
import 'package:ghostlypark/src/Model/Providers%20-%20Stores/ImagePath.dart';

final FlutterLocalization localization = FlutterLocalization.instance;

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    MobileAds.instance.initialize();

    //Load .env Variables
    await dotenv.load();
  } catch (error) {
    //("Error :  $error");
  }
  runApp(MyApp());
}

//Check if location and mb-wifi permissions are on
bool isRequestingPermission = false;
Future<bool> check_Permissions() async {
  if (isRequestingPermission) {
    return false;
  }
  isRequestingPermission = true;
  try {
    final status = await Permission.location.status;
    if (status.isDenied) {
      final location_status = await Permission.location.request();
      if (location_status.isGranted) {
        final connectivityResult = await Connectivity().checkConnectivity();
        isRequestingPermission = false;
        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) {
          return true;
        } else {
          return false;
        }
      }
    }
    isRequestingPermission = false;
    return true;
  } catch (error) {
    isRequestingPermission = false;
    return false;
  }
}

//Check Server Status
Future<bool> server_Status() async {
  try {
    final response = await http.get(
      Uri.parse('${dotenv.env['baseUrl']}/server_Status'),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (error) {
    return false;
  }
}

//Check if Server is under maintenance
Future<bool> maintenance() async {
  try {
    final response = await http.get(
      Uri.parse('${dotenv.env['baseUrl']}/maintenance'),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (error) {
    return false;
  }
}

//Cheking App Version
String? server_version;
String? latest_version;
String? build_number;
String? formatted_version;
bool requiresUpdate = false;
Future<bool> check_For_Update() async {
  try {
    //Getting current Version of App
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    latest_version = packageInfo.version;
    build_number = packageInfo.buildNumber;
    //Getting current Version of Server in order to change it
    Map<String, dynamic> versionData = await check_app_Version_Model();
    int statusCode = versionData['statusCode'];
    server_version = versionData['body'];
    formatted_version = '$latest_version+$build_number';

    //If they are not the same then Update
    if (formatted_version == server_version && statusCode == 200) {
      requiresUpdate = false;
      return false;
    } else {
      requiresUpdate = true;
      return true;
    }
  } catch (error) {
    return false;
  }
}

Future<Map<String, dynamic>> check_app_Version_Model() async {
  try {
    final response = await http.get(
        Uri.parse('${dotenv.env['baseUrl']}/check_app_Version'),
        headers: simple_Headers());
    if (response.statusCode == 200) {
      return {
        'statusCode': response.statusCode,
        'body': jsonDecode(response.body),
      };
    } else {
      throw Exception('Failed to load package details');
    }
  } catch (error) {
    return {
      'statusCode': 500,
      'body': '',
    };
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    //Configure the Language
    configureLocalization();
    //Check if first Entry
    check_First_Launch();
    //Only Portrait mode is accepted,user can't rotate his phone
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  //Check if its first time
  bool isFirst_Landing = false;
  Future<void> check_First_Launch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isFirst_Landing = prefs.getBool('isFirstLanding') ?? true;
    if (isFirst_Landing) {
      setState(() {
        isFirst_Landing = true;
      });
      await prefs.setBool('isFirst_Landing', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<bool>>(
      future: checkAllConditions(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(home: Circular_Indicator());
        } else if (snapshot.hasError) {
          return MaterialApp(home: Circular_Indicator());
        } else {
          //---------------------------------------------------------------------//
          List<bool> conditions = snapshot.data ?? [];
          //---------------------------------------------------------------------//
          bool permissions_granted =
              conditions.isNotEmpty ? conditions[0] : false;
          //---------------------------------------------------------------------//
          bool server_status = conditions.isNotEmpty ? conditions[1] : false;
          //---------------------------------------------------------------------//
          bool server_under_maintenance =
              conditions.isNotEmpty ? conditions[2] : false;
          //---------------------------------------------------------------------//
          bool update_required = conditions.isNotEmpty ? conditions[3] : false;
          //---------------------------------------------------------------------//
          // print('Permissions : ${permissions_granted}');
          // print('Server Status : ${server_status}');
          // print('Maintenance : ${server_under_maintenance}');
          // print('Update : ${update_required}');
          //---------------------------------------------------------------------//

          if (!permissions_granted || !server_status) {
            return MaterialApp(home: Error());
          } else if (server_under_maintenance) {
            return MaterialApp(home: Maintenance());
          } else if (update_required) {
            return MaterialApp(home: Update());
          } else if (permissions_granted &&
              server_status &&
              !server_under_maintenance &&
              !update_required) {
            return MultiProvider(
              providers: [
                //Providers
                ChangeNotifierProvider<Coins_And_Gems_State>(
                  create: (context) => Coins_And_Gems_State(),
                ),
                ChangeNotifierProvider<UserState>(
                  create: (context) => UserState(),
                ),
                ChangeNotifierProvider<ImageState>(
                  create: (context) => ImageState(),
                ),
              ],
              child: MaterialApp(
                supportedLocales: localization.supportedLocales,
                localizationsDelegates: localization.localizationsDelegates,
                // initialRoute: '/',
                home: Landing_Page(),
                routes: AppRoutes.routes,
                onGenerateRoute: AppRoutes.generateRoute,
                onUnknownRoute: (settings) =>
                    MaterialPageRoute(builder: (context) => Landing_Page()),
              ),
            );
          } else {
            return MaterialApp(home: Circular_Indicator());
          }
        }
      },
    );
  }

  Future<List<bool>> checkAllConditions() async {
    List<bool> conditions = [];

    bool permissions_granted = await check_Permissions();
    conditions.add(permissions_granted || isFirst_Landing);

    bool server_status = await server_Status();
    conditions.add(server_status);

    bool server_under_maintenance = await maintenance();
    conditions.add(server_under_maintenance);

    bool update_required = await check_For_Update();
    conditions.add(update_required);

    return conditions;
  }

  //Languages
  void configureLocalization() {
    localization.init(mapLocales: [
      const MapLocale('en', AppLocale.EN),
      const MapLocale('gr', AppLocale.GR),
      const MapLocale('es', AppLocale.ES),
      const MapLocale('por', AppLocale.POR),
      const MapLocale('fr', AppLocale.FR),
      const MapLocale('de', AppLocale.DE),
      const MapLocale('ru', AppLocale.RU),
      const MapLocale('ja', AppLocale.JA),
      const MapLocale('ch', AppLocale.CH),
    ], initLanguageCode: 'en');
    localization.onTranslatedLanguage = onTranslatedLanguage;
  }

  void onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }
}
