import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum LoginStatus { NotLoggedIn, LoggingIn, LoginFailed, LoggedIn }

class API {
  static String token_key = 'x-access-token';
  static String production = '';
  static String development = 'https://192.168.1.6:3000/signin';
  static String env = development;
  static String base_url = env;
}

class UserProvider with ChangeNotifier {
  // Variables
  LoginStatus _loginStatus = LoginStatus.NotLoggedIn;
  int _userId = 0;
  String _accessToken = '';

  // Getters
  LoginStatus get loginStatus => _loginStatus;

  // Constructor
  UserProvider() {
    loadUserData();
  }

  // Methods

  loadUserData() async {
    _loginStatus = LoginStatus.NotLoggedIn;
    notifyListeners();
    FlutterSecureStorage storage = FlutterSecureStorage();
    _accessToken = await storage.read(key: API.token_key);
    if (_accessToken != null) {
      verifyLogin(_accessToken);
    } else {
      print('yet to sign in');
    }
  }

  verifyLogin(String token) async {
    HttpClient client = new HttpClient();
    HttpClientRequest request = await client.postUrl(Uri.parse(API.base_url));
    request.headers.set(API.token_key, token);
    HttpClientResponse response = await request.close();
    print(response.first);
  }

  Future login() async {}
}
