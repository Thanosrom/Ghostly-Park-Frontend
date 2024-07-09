// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//.env
import 'package:flutter_dotenv/flutter_dotenv.dart';
//Libs
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:shared_preferences/shared_preferences.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Home.dart';
import 'package:ghostlypark/src/Controller/Utils/Handle_Button_Clicks.dart';
import 'package:ghostlypark/src/Controller/Utils/load_save_language.dart';
//Animations
import 'package:ghostlypark/src/View/Animations/Home_Ghost.dart';
import 'package:ghostlypark/src/View/Animations/Police_Ghost.dart';
import 'package:ghostlypark/src/View/Animations/Police_Ghost_Aware.dart';
import 'package:ghostlypark/src/View/Animations/Search_Spots_Ghost.dart';
//Components
import 'package:ghostlypark/src/View/Components/Rewards_And_Help.dart';
import 'package:ghostlypark/src/View/Components/Toast/Toast_Message.dart';
import 'package:ghostlypark/src/View/Components/Circular_Indicator.dart';
//Screens
import 'Home_Header.dart';
import 'Home_Footer.dart';
// import 'package:park/src/View/Screens/Ads.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Map vars
  final mapController = MapController();
  List<Marker> markers = [];
  LatLng? startPoint;
  //Route
  late List<LatLng> route = [];
  late List<LatLng> new_route = [];
  bool has_route = false;
  bool isLoading = false;
  //Ghost Animations
  bool show_search_spot_ghost = false;
  bool show_police_ghost_aware = false;
  bool show_police_ghost = false;

  //Languages
  String? current_locale;

  @override
  void initState() {
    super.initState();
    //Get first location
    get_Current_Location();
    //Check if first time launch the app
    check_First_Launch();
    //Count the search markers button
    load_Search_Markers_Counter();
    //Get back the 1  Coin Reward
    //onPressed_get_Parked_Location_Reward(context);
    //Languages
    load_Selected_Language().then((value) {
      setState(() {
        current_locale = value;
      });
    });
  }

  //Get Location
  Future<void> get_Current_Location() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    setState(() {
      startPoint = LatLng(position.latitude, position.longitude);
    });
  }

  //Check if its first time
  bool isFirst_Launch = false;
  Future<void> check_First_Launch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isFirst_Launch = prefs.getBool('isFirstLaunch') ?? true;
    if (isFirst_Launch) {
      setState(() {
        isFirst_Launch = true;
      });
      await prefs.setBool('isFirstLaunch', false);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: startPoint == null
          ? const Circular_Indicator()
          : Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: FlutterMap(
                        mapController: mapController,
                        options: MapOptions(
                          center: startPoint,
                          maxZoom: 18,
                          minZoom: 10,
                          zoom: 18,
                          onTap: (tapPosition, point) async {
                            if (await handle_Button_Click('onTap')) {
                              setState(() {
                                isLoading = true;
                              });
                              List<LatLng>? new_route =
                                  await tap_Route(context, point);
                              if (new_route != null) {
                                setState(() {
                                  route = new_route;
                                  has_route = true;
                                });
                              }
                              setState(() {
                                isLoading = false; // Hide circular indicator
                              });
                            }
                          },
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                "https://api.mapbox.com/styles/v1/thanosrom/cllhsqs4o017w01p8e7o792i5/tiles/256/{z}/{x}/{y}@2x?access_token=${dotenv.env['token']}",
                            additionalOptions: {
                              'accessToken': dotenv.env['token']!,
                              'id': 'Monochrome',
                            },
                          ),
                          SimpleAttributionWidget(
                            backgroundColor: Colors.white70.withOpacity(0.1),
                            source: Text(
                              'OpenStreetMap contributors',
                              style: TextStyle(
                                fontSize: screenWidth <= 414
                                    ? screenWidth * 0.04
                                    : screenWidth <= 810
                                        ? screenWidth * 0.04
                                        : screenWidth * 0.04,
                              ),
                            ),
                          ),
                          MarkerLayer(
                            markers: markers,
                          ),
                          CurrentLocationLayer(
                            followOnLocationUpdate:
                                FollowOnLocationUpdate.never,
                            turnOnHeadingUpdate: TurnOnHeadingUpdate.never,
                            style: LocationMarkerStyle(
                              marker: const DefaultLocationMarker(
                                child: Icon(
                                  Icons.navigation,
                                  color: Colors.white,
                                ),
                              ),
                              markerSize: Size(
                                screenWidth <= 414
                                    ? screenWidth * 0.1
                                    : screenWidth <= 810
                                        ? screenWidth * 0.1
                                        : screenWidth * 0.1,
                                screenWidth <= 414
                                    ? screenWidth * 0.1
                                    : screenWidth <= 810
                                        ? screenWidth * 0.05
                                        : screenWidth * 0.05,
                              ),
                              headingSectorColor: Colors.blue,
                              markerDirection: MarkerDirection.heading,
                            ),
                          ),
                          PolylineLayer(
                            polylines: [
                              Polyline(
                                points: route,
                                strokeWidth: screenWidth <= 414
                                    ? screenWidth * 0.01
                                    : screenWidth <= 810
                                        ? screenWidth * 0.01
                                        : screenWidth * 0.01,
                                isDotted: true,
                                colorsStop: List.filled(0, 122),
                                gradientColors: [
                                  const Color.fromARGB(255, 100, 7, 223),
                                  Colors.blue
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        0,
                        screenWidth <= 414
                            ? screenWidth * 0.1
                            : screenWidth <= 810
                                ? screenWidth * 0.06
                                : screenWidth * 0.06,
                        0,
                        0),
                    child: Home_Header(
                      onPressedFindLocation: (String searchLocation) async {
                        if (await handle_Button_Click(
                            'onPressedFindLocation')) {
                          setState(() {
                            isLoading = true;
                          });
                          Position position =
                              await Geolocator.getCurrentPosition(
                                  desiredAccuracy:
                                      LocationAccuracy.bestForNavigation);
                          if (startPoint != null) {
                            onPressed_FindLocation(
                              markers,
                              mapController,
                              searchLocation,
                              LatLng(position.latitude, position.longitude),
                              route,
                              context,
                            ).then((data) {
                              setState(() {
                                markers = data['markers'];
                                route = data['route'];
                                has_route = true;
                              });
                            }).catchError((error) {});
                          }
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        screenWidth <= 414
                            ? screenWidth * 0.001
                            : screenWidth <= 810
                                ? screenWidth * 0.055
                                : screenWidth * 0.055,
                        0,
                        screenWidth <= 414
                            ? screenWidth * 0.001
                            : screenWidth <= 810
                                ? screenWidth * 0.055
                                : screenWidth * 0.055,
                        screenWidth <= 414
                            ? screenWidth * 0.001
                            : screenWidth <= 810
                                ? screenWidth * 0.001
                                : screenWidth * 0.001),
                    child: Home_Footer(
                      onPressed_SearchMarkers: () async {
                        if (await handle_Button_Click(
                            'onPressed_SearchMarkers')) {
                          setState(() {
                            isLoading = true;
                          });
                          //Count the times is pressed
                          setState(() {
                            search_Markers_Counter++;
                          });
                          save_Search_Markers_Counter(search_Markers_Counter);
                          //Check how many times pressed and show ghost
                          if (search_Markers_Counter >= 10) {
                            setState(() {
                              show_police_ghost = true;
                            });
                          } else {
                            setState(() {
                              show_search_spot_ghost = true;
                            });
                            await Future.delayed(Duration(milliseconds: 2000));
                            await get_Filtered_Markers(
                                    markers, mapController, context)
                                .then((newMarkers) {
                              setState(() {
                                markers = newMarkers!;
                              });
                            });
                            await Future.delayed(Duration(milliseconds: 2000));
                            setState(() {
                              show_search_spot_ghost = false;
                            });
                            if (markers.isEmpty) {
                              Toast_Message(
                                context,
                                AppLocale.getString(
                                    context, AppLocale.no_markers_toast,
                                    languageCode: current_locale),
                              );
                            }
                            if (search_Markers_Counter == 8 &&
                                !show_search_spot_ghost) {
                              setState(() {
                                show_police_ghost_aware = true;
                              });
                            }
                          }
                          setState(() {
                            isLoading = false;
                          });
                        } else {
                          Toast_Message(
                            context,
                            AppLocale.getString(
                                context, AppLocale.pressed_too_many_times_toast,
                                languageCode: current_locale),
                          );
                        }
                      },
                      onPressed_UnParked: () async {
                        if (await handle_Button_Click('onPressed_UnParked')) {
                          setState(() {
                            isLoading = true;
                          });
                          save_Search_Markers_Counter(search_Markers_Counter);
                          final unparked_bool = onPressed_UnParked(
                              mapController, markers, context);
                          if (await unparked_bool) {
                            setState(() {
                              search_Markers_Counter = 0;
                            });
                          }
                          setState(() {
                            isLoading = false;
                          });
                        } else {
                          Toast_Message(
                            context,
                            AppLocale.getString(
                                context, AppLocale.pressed_too_many_times_toast,
                                languageCode: current_locale),
                          );
                        }
                      },
                      // onPressed_Parked: () async {
                      //   if (await handle_Button_Click('onPressed_Parked')) {
                      //  setState(() {
                      //       isLoading = true;
                      //     });
                      //     onPressed_Parked(context);
                      //  setState(() {
                      //       isLoading = true;
                      //     });
                      //   } else {
                      //     Toast_Message(context, 'Pressed too many times');
                      //   }
                      // },
                      onPressed_FindMe: () async {
                        setState(() {
                          isLoading = true;
                        });
                        onPressed_FindMe(mapController, context);
                        setState(() {
                          isLoading = false;
                        });
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: isLoading,
                  child: const Circular_Indicator(isTransparent: true),
                ),
                Visibility(
                  visible: has_route,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          0,
                          screenWidth <= 414
                              ? screenWidth * 0.25
                              : screenWidth <= 810
                                  ? screenWidth * 0.25
                                  : screenWidth * 0.25,
                          0,
                          0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            route.clear();
                            has_route = false;
                          });
                        },
                        child: Text(
                          AppLocale.getString(context, AppLocale.close_text,
                              languageCode: current_locale),
                          style: TextStyle(
                            fontSize: screenWidth <= 414
                                ? screenWidth * 0.04
                                : screenWidth <= 810
                                    ? screenWidth * 0.04
                                    : screenWidth * 0.04,
                            color: Color.fromARGB(255, 100, 7, 223),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      0,
                      0,
                      screenWidth <= 414
                          ? screenWidth * 0.01
                          : screenWidth <= 810
                              ? screenWidth * 0.01
                              : screenWidth * 0.01,
                      screenWidth <= 414
                          ? screenWidth * 0.5
                          : screenWidth <= 810
                              ? screenWidth * 0.3
                              : screenWidth * 0.3,
                    ),
                    child: Reward_And_help(),
                  ),
                ),
                Visibility(
                  visible: isFirst_Launch,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        screenWidth <= 414
                            ? screenWidth * 0.01
                            : screenWidth <= 810
                                ? screenWidth * 0.01
                                : screenWidth * 0.01,
                        0,
                        0,
                        screenWidth <= 414
                            ? screenWidth * 0.35
                            : screenWidth <= 810
                                ? screenWidth * 0.25
                                : screenWidth * 0.25,
                      ),
                      child: Home_Ghost(),
                    ),
                  ),
                ),
                Visibility(
                  visible: show_police_ghost_aware,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        screenWidth <= 414
                            ? screenWidth * 0.01
                            : screenWidth <= 810
                                ? screenWidth * 0.01
                                : screenWidth * 0.01,
                        0,
                        0,
                        screenWidth <= 414
                            ? screenWidth * 0.35
                            : screenWidth <= 810
                                ? screenWidth * 0.25
                                : screenWidth * 0.25,
                      ),
                      child: Police_Ghost_Aware(),
                    ),
                  ),
                ),
                Visibility(
                  visible: show_search_spot_ghost,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        screenWidth <= 414
                            ? screenWidth * 0.01
                            : screenWidth <= 810
                                ? screenWidth * 0.01
                                : screenWidth * 0.01,
                        0,
                        0,
                        screenWidth <= 414
                            ? screenWidth * 0.35
                            : screenWidth <= 810
                                ? screenWidth * 0.25
                                : screenWidth * 0.25,
                      ),
                      child: Search_Spots_Ghost(),
                    ),
                  ),
                ),
                Visibility(
                  visible: show_police_ghost,
                  child: const Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Police_Ghost(),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
