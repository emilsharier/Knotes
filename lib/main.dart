import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:knotes/components/providers/LocalDBKnotesProvider.dart';
import 'package:knotes/modelClasses/knote_model.dart';
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
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Knotes',
      debugShowCheckedModeBanner: false,
      theme: globalThemeData.lightThemeData,
      darkTheme: globalThemeData.darkThemeData,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider.instance(),
          ),
          ChangeNotifierProvider<LocalDBKnotesProvider>(
            create: (ctx) => LocalDBKnotesProvider(),
          ),
        ],
        child: HomeScreen(),
      ),
    );
  }
}
