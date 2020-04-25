import 'package:flutter/material.dart';

ThemeData darkThemeData = ThemeData(
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    color: Color.fromRGBO(30, 30, 30, 1.0),
    elevation: 0.0,
  ),
  accentColor: Colors.white,
  primaryColor: Colors.white,
  appBarTheme: AppBarTheme(
    brightness: Brightness.dark,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    color: Color.fromRGBO(45, 45, 45, 1.0),
    elevation: 0.0,
    textTheme: TextTheme(
      title: TextStyle(
        color: Colors.white,
        fontSize: 35.0,
        // letterSpacing: 2.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'NexaBold',
      ),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.white,
    elevation: 0.0,
    focusColor: Color.fromRGBO(230, 230, 230, 0.5),
  ),
  brightness: Brightness.dark,
);

ThemeData lightThemeData = ThemeData(
  accentColor: Colors.black,
  brightness: Brightness.light,
  textSelectionColor: Color.fromRGBO(217, 217, 217, 1.0),
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    color: Color.fromRGBO(230, 230, 230, 1.0),
    elevation: 0.0,
  ),
  appBarTheme: AppBarTheme(
    brightness: Brightness.light,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    color: Colors.white,
    elevation: 0.0,
    textTheme: TextTheme(
      title: TextStyle(
        color: Colors.black87,
        fontSize: 35.0,
        // letterSpacing: 2.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'NexaBold',
      ),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.black,
    elevation: 0.0,
    focusColor: Color.fromRGBO(230, 230, 230, 0.5),
  ),
);
