// ignore_for_file: prefer_const_constructors_in_immutables
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
//.env
import 'package:flutter_dotenv/flutter_dotenv.dart';
//Languages
import 'package:ghostlypark/Languages.dart';
//Libs
import 'package:http/http.dart' as http;
//Controllers
import 'package:ghostlypark/src/Controller/Utils/load_save_language.dart';
//Components
import 'package:ghostlypark/src/View/Components/Small_Texts.dart';
import 'package:ghostlypark/src/View/Components/Width_Spacer.dart';

class Home_Header extends StatefulWidget {
  final Function(String) onPressedFindLocation;

  Home_Header({super.key, required this.onPressedFindLocation});

  @override
  _Home_Header createState() => _Home_Header();
}

class _Home_Header extends State<Home_Header> {
  //For Search Text
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  //Suggestions
  List<String> suggestions = [];
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
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  //Get the current suggestions
  Future<List<String>> fetchSuggestions(String query) async {
    final String apiURL =
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$query.json?access_token=${dotenv.env['token']}';
    final response = await http.get(Uri.parse(apiURL));
    final data = json.decode(response.body);

    if (data != null && data['features'] != null) {
      return List<String>.from(
          data['features'].map((feature) => feature['place_name']));
    }
    return [];
  }

  //Hear for text changes
  void onTextChanged() async {
    final query = textController.text;

    if (query.isNotEmpty) {
      final fetched_Suggestions = await fetchSuggestions(query);
      setState(() {
        suggestions = fetched_Suggestions;
      });
    } else {
      setState(() {
        suggestions = [];
        suggestions.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.fromLTRB(
          screenWidth <= 414
              ? screenWidth * 0.05
              : screenWidth <= 810
                  ? screenWidth * 0.05
                  : screenWidth * 0.05,
          0,
          screenWidth <= 414
              ? screenWidth * 0.05
              : screenWidth <= 810
                  ? screenWidth * 0.05
                  : screenWidth * 0.05,
          screenWidth <= 414
              ? screenWidth * 0.1
              : screenWidth <= 810
                  ? screenWidth * 0.1
                  : screenWidth * 0.1),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  width: screenWidth <= 414
                      ? screenWidth * 0.6
                      : screenWidth <= 810
                          ? screenWidth * 0.6
                          : screenWidth * 0.6,
                  height: screenWidth <= 414
                      ? screenWidth * 0.1
                      : screenWidth <= 810
                          ? screenWidth * 0.08
                          : screenWidth * 0.08,
                  child: TextField(
                    onChanged: (value) => {(onTextChanged())},
                    style: TextStyle(
                        fontSize: screenWidth <= 414
                            ? screenWidth * 0.04
                            : screenWidth <= 810
                                ? screenWidth * 0.04
                                : screenWidth * 0.04,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    obscureText: false,
                    controller: textController,
                    focusNode: focusNode,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white54,
                          width: screenWidth <= 414
                              ? screenWidth * 0.004
                              : screenWidth <= 810
                                  ? screenWidth * 0.003
                                  : screenWidth * 0.003,
                        ),
                      ),
                      hintText: AppLocale.getString(
                          context, AppLocale.find_location_textfield,
                          languageCode: current_locale),
                      hintStyle: TextStyle(
                        color: Colors.white54,
                        fontSize: screenWidth <= 414
                            ? screenWidth * 0.04
                            : screenWidth <= 810
                                ? screenWidth * 0.04
                                : screenWidth * 0.04,
                      ),
                      contentPadding: EdgeInsets.all(
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
              Width_Spacer(),
              Flexible(
                flex: 1,
                child: Container(
                  width: screenWidth <= 414
                      ? screenWidth * 0.4
                      : screenWidth <= 810
                          ? screenWidth * 0.4
                          : screenWidth * 0.4,
                  height: screenWidth <= 414
                      ? screenWidth * 0.1
                      : screenWidth <= 810
                          ? screenWidth * 0.08
                          : screenWidth * 0.08,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          screenWidth <= 414
                              ? screenWidth * 0.02
                              : screenWidth <= 810
                                  ? screenWidth * 0.02
                                  : screenWidth * 0.02,
                        ),
                      ),
                      backgroundColor: const Color.fromARGB(255, 100, 7, 223),
                      shadowColor: Colors.grey,
                      elevation: screenWidth <= 414
                          ? screenWidth * 0.01
                          : screenWidth <= 810
                              ? screenWidth * 0.01
                              : screenWidth * 0.01,
                    ),
                    child: Text(
                      AppLocale.getString(context, AppLocale.find_area_button,
                          languageCode: current_locale),
                      style: TextStyle(
                        fontSize: screenWidth <= 414
                            ? screenWidth * 0.04
                            : screenWidth <= 810
                                ? screenWidth * 0.04
                                : screenWidth * 0.04,
                        color: Colors.white70,
                      ),
                    ),
                    onPressed: () async {
                      widget.onPressedFindLocation(textController.text);
                      suggestions = [];
                      suggestions.clear();
                    },
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: suggestions.isNotEmpty,
            child: TapRegion(
              onTapOutside: (PointerEvent details) => setState(() {
                suggestions = [];
                suggestions.clear();
                focusNode.unfocus();
              }),
              child: Padding(
                padding: EdgeInsets.only(
                    top: screenWidth <= 414
                        ? screenWidth * 0.03
                        : screenWidth <= 810
                            ? screenWidth * 0.03
                            : screenWidth * 0.03),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: screenWidth <= 414
                        ? screenWidth * 0.8
                        : screenWidth <= 810
                            ? screenWidth * 0.8
                            : screenWidth * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(
                        screenWidth <= 414
                            ? screenWidth * 0.03
                            : screenWidth <= 810
                                ? screenWidth * 0.03
                                : screenWidth * 0.03,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 100, 7, 223),
                          blurRadius: screenWidth <= 414
                              ? screenWidth * 0.1
                              : screenWidth <= 810
                                  ? screenWidth * 0.1
                                  : screenWidth * 0.1,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (final suggestion in suggestions)
                          ListTile(
                            title: Small_Texts(
                              smallText: suggestion,
                              avoid_flex: true,
                            ),
                            onTap: () {
                              setState(() {
                                textController.text = suggestion;
                                suggestions = [];
                                suggestions.clear();
                                focusNode.unfocus();
                              });
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
