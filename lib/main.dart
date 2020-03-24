import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:knotes/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/providers/DynamicTheme.dart';
import 'components/providers/SelectionProvider.dart';
import 'components/providers/UserProvider.dart';
import 'components/repositories/database_creator.dart';

import 'components/repositories/theme_repository/GlobalThemeData.dart'
    as globalThemeData;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  await DatabaseCreator().initDatabase();
  FirebaseAuth.instance.currentUser().then((user) {
    if (user != null) {
      _initiateGoogleSignIn(user);
    } else
      print("Not signed in!");
  });
  runApp(
    MyApp(),
  );
}

_initiateGoogleSignIn(FirebaseUser user) async {
  SharedPreferences _preferences = await SharedPreferences.getInstance();
  _preferences.setBool('signedIn', true);
  _preferences.setString('displayName', user.displayName);
  _preferences.setString('emailID', user.email);
  _preferences.setString('profilePictureURL', user.photoUrl);
  _preferences.setString('phoneNumber', user.phoneNumber);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Knotes',
      debugShowCheckedModeBanner: false,
      theme: globalThemeData.lightThemeData,
      darkTheme: globalThemeData.darkThemeData,
      home: HomeScreen(),
    );
  }
}
