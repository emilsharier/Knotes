import 'package:flutter/material.dart';
import 'package:knotes/components/providers/LocalDBKnotesProvider.dart';
import 'package:knotes/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'components/providers/UserProvider.dart';

import 'package:flutter/scheduler.dart';

import 'components/repositories/theme_repository/GlobalThemeData.dart'
    as globalThemeData;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  timeDilation = 1.0;
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: UserProvider.instance(),
        ),
        ChangeNotifierProvider.value(
          value: LocalDBKnotesProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Knotes',
        debugShowCheckedModeBanner: false,
        theme: globalThemeData.lightThemeData,
        darkTheme: globalThemeData.darkThemeData,
        home: HomeScreen(),
      ),
    );
  }
}
