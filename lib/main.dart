import 'package:flutter/material.dart';
import 'package:knotes/Routes/routes.dart';
import 'package:knotes/components/providers/DynamicTheme.dart';
import 'package:knotes/components/providers/LocalDBKnotesProvider.dart';
import 'package:provider/provider.dart';

import 'package:flutter/scheduler.dart';

import 'components/providers/UserProvider.dart';
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
          value: DynamicTheme(),
        ),
        ChangeNotifierProvider.value(
          value: UserProvider(),
        ),
        ChangeNotifierProvider.value(
          value: LocalDBKnotesProvider(),
        ),
      ],
      child: Consumer<DynamicTheme>(
        builder: (context, value, child) {
          return MaterialApp(
            title: 'Knotes',
            debugShowCheckedModeBanner: false,
            initialRoute: Router.homePage,
            theme: value.fetchMyTheme(),
            onGenerateRoute: Router.generateRoute,
          );
        },
      ),
    );
  }
}
