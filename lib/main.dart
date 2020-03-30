import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:knotes/components/providers/LocalDBKnotesProvider.dart';
import 'package:knotes/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'components/providers/UserProvider.dart';
import 'components/repositories/database_creator.dart';

import 'components/repositories/theme_repository/GlobalThemeData.dart'
    as globalThemeData;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  await Firestore.instance.enablePersistence(true);
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
          ChangeNotifierProvider.value(
            value: UserProvider.instance(),
          ),
          ChangeNotifierProvider.value(
            value: LocalDBKnotesProvider(),
          ),
        ],
        child: HomeScreen(),
      ),
    );
  }
}
