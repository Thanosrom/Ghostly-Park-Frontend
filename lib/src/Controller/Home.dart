// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//.env
import 'package:flutter_dotenv/flutter_dotenv.dart';
//Libs
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
//Controllers
import 'package:ghostlypark/src/Controller/Utils/Go_Back.dart';
import 'package:ghostlypark/src/Controller/Utils/load_Save_Language.dart';
//Providers
import 'package:ghostlypark/src/Model/Providers%20-%20Stores/UserState.dart';
//Components
import 'package:ghostlypark/src/View/Components/Small_Texts.dart';
import 'package:ghostlypark/src/View/Components/Toast/Toast_Message.dart';
import 'package:ghostlypark/src/View/Components/Modals/Report_Modal.dart';
//Models
import 'package:ghostlypark/src/Model/Home.dart';
import 'package:ghostlypark/src/Model/SubscriptionsCoinsGems.dart';

String? current_locale;
void initializeSettings(BuildContext context) async {
  bool isInitialized = false;
  if (!isInitialized) {
    //Languages
    current_locale = await load_Selected_Language();
    isInitialized = true;
  }
}

//Get last known parked location for the reward
Future<void> onPressed_get_Parked_Location_Reward(BuildContext context) async {
  initializeSettings(context);
  //Check if the user will have reward
  //bool reward = false;

  final status = await Permission.location.request();
  if (status.isGranted) {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    //Get previus parked location
    final response = await get_Parked_Location_Model();
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        //Lat and Long
        final firstData = data[0];
        final double parkedLat =
            double.parse(firstData['parked_latitude'].toString());
        final double parkedLong =
            double.parse(firstData['parked_longitude'].toString());
        //Check distance for the reward , if its less than 60 meters radius
        double distance = await Geolocator.distanceBetween(
            position.latitude, position.longitude, parkedLat, parkedLong);
        if (distance < 60) {
          final response = await plus_Coins_Model('reward');
          if (response.statusCode == 200) {
            //Variables to set
            var get_Coins;
            var coins_data;
            var coins_data2;
            //Get coins from database
            get_Coins = await get_Coins_Model();
            //Decode
            coins_data = json.decode(get_Coins.body);
            coins_data2 = coins_data[0]['coins'];
            //-----------------------------------------------------------------//
            //Save them in the Provider
            Provider.of<UserState>(context, listen: false)
                .setUserId(coins: coins_data2);

            showDialog(
              context: context,
              builder: (context) {
                return Report_Modal(
                  context: context,
                  labelTexts: AppLocale.getString(
                    context,
                    AppLocale.reward_one_coin,
                    languageCode: current_locale,
                  ),
                  its_error: false,
                );
              },
            );
          }
        } else {
          return;
        }
      } else {}
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
            its_error: true,
          );
        },
      );
    }
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return Report_Modal(
            context: context,
            labelTexts: AppLocale.getString(
              context,
              AppLocale.position_status_is_not_granted_small_text,
              languageCode: current_locale,
            ),
            its_error: true);
      },
    );
  }
}

//Find and locate user GPS
Future<void> onPressed_FindMe(
    MapController mapController, BuildContext context) async {
  initializeSettings(context);
  final status = await Permission.location.request();
  if (status.isGranted) {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    mapController.move(LatLng(position.latitude, position.longitude), 18);
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return Report_Modal(
            context: context,
            labelTexts: AppLocale.getString(
              context,
              AppLocale.position_status_is_not_granted_small_text,
              languageCode: current_locale,
            ),
            its_error: true);
      },
    );
  }
}

Future<Map<String, dynamic>> onPressed_FindLocation(
  List<Marker> markers,
  MapController mapController,
  String searchLocation,
  LatLng startPoint,
  List<LatLng> route,
  BuildContext context,
) async {
  initializeSettings(context);
  if (searchLocation.isNotEmpty) {
    final String apiURL =
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$searchLocation.json?access_token=${dotenv.env['token']}';

    final response = await http.get(Uri.parse(apiURL));
    final data_Search_Location = json.decode(response.body);

    if (data_Search_Location != null &&
        data_Search_Location['features'] != null &&
        data_Search_Location['features'].isNotEmpty) {
      final newLng =
          data_Search_Location['features'][0]['geometry']['coordinates'][0];
      final newLat =
          data_Search_Location['features'][0]['geometry']['coordinates'][1];

      mapController.move(LatLng(newLat, newLng), 13.0);

      var minus_Coins;
      var get_Coins;
      var coins_data;
      var coins_data2;
      var minus_gems;
      var get_Gems;
      var gems_data;
      var gems_data2;

      final response = await get_FilteredMarkers_Model(
          markers, mapController, newLng, newLat);
      //Getting the Subscription
      final get_Subscription = await get_subscription_Model();
      final subscription_body =
          json.decode(get_Subscription.body)[0]['subscription'];

      if (get_Subscription.statusCode == 200 && subscription_body == 0) {
        //-----------------------------------------------------------------//
        //Get coins from database
        get_Coins = await get_Coins_Model();
        //Decode
        coins_data = json.decode(get_Coins.body);
        coins_data2 = coins_data[0]['coins'];
        //-----------------------------------------------------------------//
        //Get gems from database
        get_Gems = await get_Gems_Model();
        //Decode
        gems_data = json.decode(get_Gems.body);
        gems_data2 = gems_data[0]['gems'];
        //-----------------------------------------------------------------//

        //Coins mechanism
        if (coins_data2 > 0 && gems_data2 > 0) {
          //Minues -1 Coin
          minus_Coins = await minus_Coins_Model();

          //Save them in the Provider
          Provider.of<UserState>(context, listen: false)
              .setUserId(coins: coins_data2 - 1);

          //Make -1 the Gems
          minus_gems = await minus_Gems_Model();

          //Save them in the Provider
          Provider.of<UserState>(context, listen: false)
              .setUserId(gems: gems_data2 - 1);
        }
      }

      if (response.statusCode == 200 &&
              minus_Coins?.statusCode == 200 &&
              minus_gems?.statusCode == 200 &&
              get_Coins?.statusCode == 200 &&
              coins_data2 > 0 &&
              get_Gems?.statusCode == 200 &&
              gems_data2 > 0 ||
          (response.statusCode == 200 &&
              get_Subscription.statusCode == 200 &&
              subscription_body == 1)) {
        List<dynamic> data = json.decode(response.body);
        markers.clear();
        if (data.isNotEmpty) {
          for (var markerData in data) {
            final double lat = markerData['unParked_latitude'];
            final double lng = markerData['unParked_longitude'];

            final int timestampInMilliseconds = markerData['unParked_time'];

            final DateTime timestamp = DateTime.fromMillisecondsSinceEpoch(
                timestampInMilliseconds.toInt());

            final int minutesDifference =
                DateTime.now().difference(timestamp).inMinutes;

            //Icons Colors
            Gradient markerGradient;

            if (minutesDifference > 5 && minutesDifference < 15) {
              markerGradient = const LinearGradient(
                colors: [
                  Color(0xFFF2C94C),
                  Color(0xFFF2994A),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              );
            } else if (minutesDifference >= 15) {
              markerGradient = const LinearGradient(
                colors: [
                  Color.fromARGB(255, 212, 33, 33),
                  Color.fromARGB(255, 189, 119, 119),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              );
            } else {
              markerGradient = const LinearGradient(
                colors: [
                  Color(0xFF009245),
                  Color(0xFFFCEE21),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              );
            }

            final screenWidth = MediaQuery.of(context).size.width;

            final Marker marker = Marker(
              point: LatLng(lat, lng),
              builder: (BuildContext context) {
                return ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) {
                    return markerGradient.createShader(bounds);
                  },
                  child: Icon(
                    Icons.drive_eta,
                    size: screenWidth <= 414
                        ? screenWidth * 0.03
                        : screenWidth <= 810
                            ? screenWidth * 0.035
                            : screenWidth * 0.035,
                  ),
                );
              },
            );
            markers.add(marker);
          }
        } else {}
        route = await fetch_Route(
            context,
            LatLng(startPoint.latitude, startPoint.longitude),
            LatLng(newLat, newLng));

        Map<String, dynamic> result = {
          'markers': markers,
          'route': route,
        };
        return result;
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return Report_Modal(
              context: context,
              labelTexts: AppLocale.getString(
                context,
                AppLocale.no_coins_or_no_gems,
                languageCode: current_locale,
              ),
              its_error: true,
            );
          },
        );
      }
      return {};
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
            its_error: true,
          );
        },
      );

      return {};
    }
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return Report_Modal(
            context: context,
            labelTexts: AppLocale.getString(
              context,
              AppLocale.search_location_is_empty_small_text,
              languageCode: current_locale,
            ),
            its_error: true);
      },
    );
    return {};
  }
}

//About Parked - Unparked user locations
Future<bool> onPressed_UnParked(MapController mapController,
    List<Marker> markers, BuildContext context) async {
  initializeSettings(context);
  final status = await Permission.location.request();
  if (status.isGranted) {
    //Get the Lad and Lng
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );

    //Position Stream
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.best,
      timeLimit: Duration(minutes: 1),
      //distanceFilter: 0,
    );
    List<Position> positionList = [];
    bool isHighSpeed = false;
    Completer<bool> highSpeedCompleter = Completer<bool>();

    StreamSubscription<Position>? positionStreamSubscription;
    positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((Position position) {
      positionList.add(position);
      print('Speed Stream: ${position.speed * 3.6}');

      if (position.speed * 3.6 > 25) {
        print('Lat : ${position.latitude}');
        print('Lng : ${position.longitude}');
        print('Speed : ${position.speed}');
        isHighSpeed = true;
        positionStreamSubscription?.cancel();
        highSpeedCompleter.complete(true);
      }
    });

    Future.delayed(Duration(minutes: 1), () {
      if (!highSpeedCompleter.isCompleted) {
        highSpeedCompleter.complete(false);
        positionStreamSubscription?.cancel();
      }
    });

    double lat = position.latitude;
    double lng = position.longitude;
    double speed = position.speed * 3.6;
    print('Lat : ${lat}');
    print('Lng : ${lng}');
    print('Speed : ${speed}');

    await highSpeedCompleter.future;
    positionStreamSubscription.cancel();

    if (speed < 10 && isHighSpeed) {
      final response = await send_UnParked_Location_Model(lat, lng, context);
      if (response.statusCode != 200) {
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
              its_error: true,
            );
          },
        );
      } else {
        Toast_Message(
          context,
          AppLocale.getString(
            context,
            AppLocale.left_parking_slot_toast,
            languageCode: current_locale,
          ),
        );
      }
      return true;
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return Report_Modal(
              context: context,
              labelTexts: AppLocale.getString(
                context,
                AppLocale.you_are_currently_on_move_small_text,
                languageCode: current_locale,
              ),
              its_error: true);
        },
      );
    }
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return Report_Modal(
            context: context,
            labelTexts: AppLocale.getString(
              context,
              AppLocale.position_status_is_not_granted_small_text,
              languageCode: current_locale,
            ),
            its_error: true);
      },
    );
  }
  return false;
}

Future<void> onPressed_Parked(BuildContext context) async {
  initializeSettings(context);
  final status = await Permission.location.request();

  if (status.isGranted) {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );

    double lat = position.latitude;
    double lng = position.longitude;
    double speed = position.speed * 3.6;
    if (speed < 25) {
      final response = await send_Parked_Location_Model(lat, lng, context);
      if (response.statusCode != 200) {
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
              its_error: true,
            );
          },
        );
      } else {
        Toast_Message(
          context,
          AppLocale.getString(
            context,
            AppLocale.just_parked_toast,
            languageCode: current_locale,
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return Report_Modal(
              context: context,
              labelTexts: AppLocale.getString(
                context,
                AppLocale.you_are_currently_on_move_small_text,
                languageCode: current_locale,
              ),
              its_error: true);
        },
      );
    }
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return Report_Modal(
            context: context,
            labelTexts: AppLocale.getString(
              context,
              AppLocale.position_status_is_not_granted_small_text,
              languageCode: current_locale,
            ),
            its_error: true);
      },
    );
  }
}

//Filter the Markers
Future<List<Marker>?> get_Filtered_Markers(List<Marker> markers,
    MapController mapController, BuildContext context) async {
  initializeSettings(context);
  //See Adds first
  // _createRewardedAd(userState);
  // _showRewardedAd(userState);
  var get_Coins;
  var minus_Coins;
  var coins_data;
  var coins_data2;

  final status = await Permission.location.request();
  if (status.isGranted) {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    //Get Filter Markers and spend 1 coin
    final response = await get_FilteredMarkers_Model(
        markers, mapController, position.longitude, position.latitude);

    //Getting the Subscription
    final get_Subscription = await get_subscription_Model();
    final subscription_body =
        json.decode(get_Subscription.body)[0]['subscription'];

    //If i dont have subscription then go and do minues-1 coin and continue
    if (get_Subscription.statusCode == 200 && subscription_body == 0) {
      //-----------------------------------------------------------------//
      //Get coins from database
      get_Coins = await get_Coins_Model();
      //Decode
      coins_data = json.decode(get_Coins.body);
      coins_data2 = coins_data[0]['coins'];
      //-----------------------------------------------------------------//

      //Coins mechanism
      if (coins_data2 > 0) {
        //Minues -1 Coin
        minus_Coins = await minus_Coins_Model();
        //Save them in the Provider
        Provider.of<UserState>(context, listen: false)
            .setUserId(coins: coins_data2 - 1);
      }
    }

    if ((response.statusCode == 200 &&
            minus_Coins?.statusCode == 200 &&
            get_Coins?.statusCode == 200 &&
            coins_data2 > 0) ||
        (response.statusCode == 200 &&
            get_Subscription.statusCode == 200 &&
            subscription_body == 1)) {
      List<dynamic> data = json.decode(response.body);
      markers.clear();

      if (data.isNotEmpty) {
        for (var markerData in data) {
          final double lat = markerData['unParked_latitude'];
          final double lng = markerData['unParked_longitude'];

          final int timestampInMilliseconds = markerData['unParked_time'];

          final DateTime timestamp = DateTime.fromMillisecondsSinceEpoch(
              timestampInMilliseconds.toInt());

          final int minutesDifference =
              DateTime.now().difference(timestamp).inMinutes;

          //Icons Colors
          Gradient markerGradient;

          if (minutesDifference > 5 && minutesDifference < 15) {
            markerGradient = const LinearGradient(
              colors: [
                Color(0xFFF2C94C),
                Color(0xFFF2994A),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            );
          } else if (minutesDifference >= 15) {
            markerGradient = const LinearGradient(
              colors: [
                Color.fromARGB(255, 212, 33, 33),
                Color.fromARGB(255, 189, 119, 119),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            );
          } else {
            markerGradient = const LinearGradient(
              colors: [
                Color(0xFF009245),
                Color(0xFFFCEE21),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            );
          }

          final screenWidth = MediaQuery.of(context).size.width;

          final Marker marker = Marker(
            point: LatLng(lat, lng),
            builder: (BuildContext context) {
              return ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (Rect bounds) {
                  return markerGradient.createShader(bounds);
                },
                child: Icon(
                  Icons.drive_eta,
                  size: screenWidth <= 414
                      ? screenWidth * 0.03
                      : screenWidth <= 810
                          ? screenWidth * 0.035
                          : screenWidth * 0.035,
                ),
              );
            },
          );
          markers.add(marker);
        }
      } else {}
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return Report_Modal(
            context: context,
            labelTexts: AppLocale.getString(
              context,
              AppLocale.no_coins,
              languageCode: current_locale,
            ),
            its_error: true,
          );
        },
      );
    }
    return markers;
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return Report_Modal(
            context: context,
            labelTexts: AppLocale.getString(
              context,
              AppLocale.position_status_is_not_granted_small_text,
              languageCode: current_locale,
            ),
            its_error: true);
      },
    );

    return [];
  }
}

//Route
Future<List<LatLng>> fetch_Route(
    BuildContext context, LatLng startPoint, LatLng endPoint) async {
  initializeSettings(context);
  String apiUrl =
      'https://api.mapbox.com/directions/v5/mapbox/driving/${startPoint.longitude},${startPoint.latitude};${endPoint.longitude},${endPoint.latitude}?alternatives=true&geometries=geojson&language=en&overview=full&steps=true&access_token=${dotenv.env['token']}';

  final response = await http.get(Uri.parse(apiUrl));
  if (response.statusCode == 200) {
    final data_route = json.decode(response.body);
    final geometry = data_route['routes'][0]['geometry']['coordinates'];

    List<LatLng> points = [];
    for (var item in geometry) {
      points.add(LatLng(item[1], item[0]));
    }
    return points;
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
          its_error: true,
        );
      },
    );
    return [];
  }
}

Future<List<LatLng>?> tap_Route(
  BuildContext context,
  LatLng tapPosition,
) async {
  initializeSettings(context);
  final status = await Permission.location.request();
  if (status.isGranted) {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    //Route
    List<Placemark> placemarks = await placemarkFromCoordinates(
        tapPosition.latitude, tapPosition.longitude);
    Placemark? placemark = placemarks.isNotEmpty ? placemarks.first : null;
    String address = placemark != null
        ? '${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}'
        : 'Unknown Address';
    Completer<List<LatLng>?> completer = Completer();
    //Navigation
    final startingCoords = Coords(position.latitude, position.longitude);
    final destinationCoords =
        Coords(tapPosition.latitude, tapPosition.longitude);
    final available_Maps = await MapLauncher.installedMaps;

    showDialog<List<LatLng>>(
      context: context,
      builder: (BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;

        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(
              screenWidth <= 414
                  ? screenWidth * 0.05
                  : screenWidth <= 810
                      ? screenWidth * 0.05
                      : screenWidth * 0.05,
            ),
            width: screenWidth <= 414
                ? screenWidth * 0.7
                : screenWidth <= 810
                    ? screenWidth * 0.5
                    : screenWidth * 0.5,
            height: screenWidth <= 414
                ? screenWidth * 0.65
                : screenWidth <= 810
                    ? screenWidth * 0.5
                    : screenWidth * 0.5,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  screenWidth <= 414
                      ? screenWidth * 0.1
                      : screenWidth <= 810
                          ? screenWidth * 0.1
                          : screenWidth * 0.1,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 100, 7, 223),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Small_Texts(
                  smallText: '${address} 📍',
                  avoid_flex: true,
                ),
                SizedBox(
                  height: screenWidth <= 414
                      ? screenWidth * 0.01
                      : screenWidth <= 810
                          ? screenWidth * 0.01
                          : screenWidth * 0.01,
                ),
                Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Go_Back(context);
                      },
                      child: Small_Texts(
                        avoid_flex: true,
                        smallText: AppLocale.getString(
                          context,
                          AppLocale.close_text,
                          languageCode: current_locale,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        var minus_gems;
                        var get_Gems;
                        var gems_data;
                        var gems_data2;

                        //Getting the Subscription
                        final get_Subscription = await get_subscription_Model();
                        final subscription_body = json
                            .decode(get_Subscription.body)[0]['subscription'];

                        if (get_Subscription.statusCode == 200 &&
                            subscription_body == 0) {
                          //-----------------------------------------------------------------//
                          //Get gems from database
                          get_Gems = await get_Gems_Model();
                          //Decode
                          gems_data = json.decode(get_Gems.body);
                          gems_data2 = gems_data[0]['gems'];
                          //-----------------------------------------------------------------//

                          //Coins mechanism
                          if (gems_data2 > 0) {
                            //Make -1 the Gems
                            minus_gems = await minus_Gems_Model();
                            //Save them in the Provider
                            Provider.of<UserState>(context, listen: false)
                                .setUserId(gems: gems_data2 - 1);
                          }
                        }

                        if (minus_gems?.statusCode == 200 &&
                                get_Gems?.statusCode == 200 &&
                                gems_data2 > 0 ||
                            (get_Subscription.statusCode == 200 &&
                                subscription_body == 1)) {
                          LatLng destination = LatLng(
                              tapPosition.latitude, tapPosition.longitude);
                          List<LatLng> newRoute = await fetch_Route(
                            context,
                            LatLng(position.latitude, position.longitude),
                            destination,
                          );
                          Navigator.of(context).pop(newRoute);
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Report_Modal(
                                context: context,
                                labelTexts: AppLocale.getString(
                                  context,
                                  AppLocale.no_gems,
                                  languageCode: current_locale,
                                ),
                                its_error: true,
                              );
                            },
                          );
                        }
                      },
                      child: Small_Texts(
                        avoid_flex: true,
                        smallText: AppLocale.getString(
                          context,
                          AppLocale.route_small_text,
                          languageCode: current_locale,
                        ),
                        color: Color.fromARGB(255, 100, 7, 223),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          for (var map in available_Maps)
                            TextButton(
                              onPressed: () => map.showDirections(
                                destination: destinationCoords,
                                origin: startingCoords,
                                originTitle: 'Starting Point',
                              ),
                              child: Small_Texts(
                                avoid_flex: true,
                                smallText: '${map.mapName}',
                                color: Color.fromARGB(255, 100, 7, 223),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                )),
              ],
            ),
          ),
        );
      },
    ).then((value) {
      completer.complete(value);
    });

    return completer.future;
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return Report_Modal(
            context: context,
            labelTexts: AppLocale.getString(
              context,
              AppLocale.position_status_is_not_granted_small_text,
              languageCode: current_locale,
            ),
            its_error: true);
      },
    );
  }
  return [];
}

//History of Counter for Markers - Parked Car
int search_Markers_Counter = 0;
Future<void> load_Search_Markers_Counter() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  search_Markers_Counter = prefs.getInt('searchMarkersCounter') ?? 0;
}

Future<void> save_Search_Markers_Counter(int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('searchMarkersCounter', value);
}
