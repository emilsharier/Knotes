import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:knotes/components/PrefKeys/PrefKeys.dart';
import 'package:knotes/components/repositories/theme_repository/GlobalThemeData.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum CustomThemes { Light, Black, Grey }

class DynamicTheme with ChangeNotifier {
  // Variables
  CustomThemes _currentTheme = CustomThemes.Black;
  SharedPreferences _pref;

  // Constructor
  DynamicTheme() {
    init();
  }

  //Getters
  CustomThemes get currentTheme => _currentTheme;

  // Methods
  init() async {
    _pref = await SharedPreferences.getInstance();
    if (_pref.getString(PrefKeys.currentTheme) != null) {
      _currentTheme = loadThemeFromPref(_pref.getString(PrefKeys.currentTheme));
    } else {
      _setTheme(CustomThemes.Black);
    }
    notifyListeners();
  }

  ThemeData fetchMyTheme() {
    switch (_currentTheme) {
      case CustomThemes.Black:
        return GlobalThemeData().darkTheme();
        break;
      case CustomThemes.Light:
        return GlobalThemeData().lightTheme();
        break;
      case CustomThemes.Grey:
        return GlobalThemeData().greyTheme();
        break;
      default:
        return GlobalThemeData().darkTheme();
        break;
    }
  }

  CustomThemes loadThemeFromPref(String arg) {
    switch (arg) {
      case 'CustomThemes.Black':
        return CustomThemes.Black;
        break;
      case 'CustomThemes.Light':
        return CustomThemes.Light;
        break;
      case 'CustomThemes.Grey':
        return CustomThemes.Grey;
        break;
      default:
        return CustomThemes.Black;
        break;
    }
  }

  toggleTheme() async {
    CustomThemes temp;
    if (_currentTheme == CustomThemes.Black)
      temp = CustomThemes.Grey;
    else if (_currentTheme == CustomThemes.Grey)
      temp = CustomThemes.Light;
    else
      temp = CustomThemes.Black;
    _setTheme(temp);
  }

  // Private methods
  _setTheme(CustomThemes theme) {
    _currentTheme = theme;
    notifyListeners();
    _pref.setString(PrefKeys.currentTheme, theme.toString());
  }
}
