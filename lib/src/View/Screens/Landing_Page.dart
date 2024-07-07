import 'package:flutter/material.dart';
//Controllers
import 'package:ghostlypark/src/Controller/Utils/load_Save_Delete_UserInfo.dart';
//Components
import 'package:ghostlypark/src/View/Components/Circular_Indicator.dart';
//Screens
import 'package:ghostlypark/src/View/Screens/LogIn.dart';

class Landing_Page extends StatefulWidget {
  const Landing_Page({super.key});

  @override
  _Landing_PageState createState() => _Landing_PageState();
}

class _Landing_PageState extends State<Landing_Page> {
  //Variable flag for login
  bool should_show_login = false;
  @override
  void initState() {
    super.initState();
    loadSavedCredentials();
  }

  //Function flag for login
  Future<void> loadSavedCredentials() async {
    bool has_saved_credentials = await load_Saved_Credentials(context);
    setState(() {
      should_show_login = !has_saved_credentials;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: Future.delayed(Duration(seconds: 1), () => true),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Circular_Indicator();
          }
          if (snapshot.hasError) {
            return Circular_Indicator();
          } else {
            if (snapshot.data == true) {
              if (should_show_login) {
                return LogIn();
              }
            } else {
              return Circular_Indicator();
            }
          }
          return Circular_Indicator();
        },
      ),
    );
  }
}
