// ignore_for_file: unnecessary_null_comparison, file_names, use_build_context_synchronously
import 'package:flutter/material.dart';
//Libs
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//Controllers
import 'package:ghostlypark/src/Controller/LogIn.dart';

final storage = FlutterSecureStorage();

//Save and load credentials for auto login
Future<bool> load_Saved_Credentials(BuildContext context) async {
  String? username = await storage.read(key: 'username');
  String? password = await storage.read(key: 'password');
  if (username != null &&
      password != null &&
      username.isNotEmpty &&
      password.isNotEmpty) {
    login(username, password, context);
    return true;
  } else {
    return false;
  }
}

save_Credentials(String emailController, String passwordController) async {
  await storage.write(key: 'username', value: emailController);
  await storage.write(key: 'password', value: passwordController);
}

delete_Credentials() async {
  await storage.delete(key: 'username');
  await storage.delete(key: 'password');
}
