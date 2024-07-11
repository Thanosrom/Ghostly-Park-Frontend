// ignore_for_file: avoid_print
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
//.envs
import 'package:flutter_dotenv/flutter_dotenv.dart';
//Libs
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

GoogleSignIn _googleSignIn = GoogleSignIn(
    //clientId: 'your-client_id.apps.googleusercontent.com',
    //scopes: scopes,
    );
const List<String> scopes = <String>['openid', 'profile'];

class Google_Auth extends StatefulWidget {
  const Google_Auth({super.key});

  @override
  State createState() => _Google_AuthState();
}

class _Google_AuthState extends State<Google_Auth> {
  bool _isAuthorized = false;
  GoogleSignInAccount? _currentUser;
  Map<String, dynamic>? _userJson;
  @override
  void initState() {
    super.initState();

    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      _isAuthorized = account != null;

      setState(() {
        _currentUser = account;
        if (_currentUser != null) {
          _userJson = {
            'displayName': _currentUser!.displayName,
            'email': _currentUser!.email,
            'id': _currentUser!.id,
            'photoUrl': _currentUser!.photoUrl,
          };
          print(_userJson);
        } else {
          _userJson = null;
        }
      });
    });
    _googleSignIn.signInSilently();
  }

  //Send User Data to Backend
  Future<void> send_Auth(String? token) async {
    try {
      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to sign in with Google (token is null)'),
          ),
        );
        return;
      }
      final response = await http.post(
        Uri.parse('${dotenv.env['baseUrl']}/auth_google'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'idToken': token,
        }),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> user = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign in successful! Welcome ${user['name']}'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to sign in with Google'),
          ),
        );
      }
    } catch (error) {
      print(error);
    }
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
      print(googleSignInAuthentication.accessToken);
      print(googleSignInAuthentication.idToken);
      send_Auth(googleSignInAuthentication.accessToken);
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() async {
    await _googleSignIn.disconnect();
    setState(() {
      _currentUser = null;
      _userJson = null;
    });
  }

  Widget _buildBody() {
    final GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: user,
            ),
            title: Text(user.displayName ?? ''),
            subtitle: Text(user.email),
          ),
          const Text('Signed in successfully.'),
          if (!_isAuthorized) ...<Widget>[
            const Text('Additional permissions needed to read your contacts.'),
            ElevatedButton(
              onPressed: _handleAuthorizeScopes,
              child: const Text('REQUEST PERMISSIONS'),
            ),
          ],
          ElevatedButton(
            onPressed: _handleSignOut,
            child: const Text('SIGN OUT'),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text('You are not currently signed in.'),
          ElevatedButton(
            onPressed: _handleSignIn,
            child: Text('Press here'),
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Sign In'),
      ),
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: _buildBody(),
      ),
    );
  }
}
