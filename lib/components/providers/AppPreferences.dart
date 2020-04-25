import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:knotes/components/PrefKeys/PrefKeys.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ProfileLoadingStatus {
  Loading,
  Done,
  Error,
}

class AppPref with ChangeNotifier {
  //Variables
  bool _isLoggedIn;
  bool _autoSync;
  bool _sortByDate;
  bool _enableEncryptedKnotes;
  bool _followSystemTheme;
  Duration _autoSyncRefreshInterval;
  Brightness _customBrightness;
  ProfileLoadingStatus _loadingStatus;

  SharedPreferences pref;

  //Getters
  bool get isLoggedIn => _isLoggedIn;

  bool get autoSync => _autoSync;

  bool get sortByDate => _sortByDate;

  bool get enableEncryptedKnotes => _enableEncryptedKnotes;

  bool get followSystemTheme => _followSystemTheme;

  Duration get autoSyncRefreshInterval => _autoSyncRefreshInterval;

  Brightness get customBrightness => _customBrightness;

  ProfileLoadingStatus get loadingStatus => _loadingStatus;

  //Constructor
  AppPref() {
    init();
  }

  //Setters
  set setIsLoggedIn(bool arg) {
    pref.setBool('${PrefKeys.isLoggedIn}', arg);
    this._isLoggedIn = arg;
    notifyListeners();
  }

  set setAutoSync(bool arg) {
    pref.setBool('${PrefKeys.autoSync}', arg);
    this._autoSync = arg;
  }

  set setSortByDate(bool arg) {
    pref.setBool('${PrefKeys.sortByDate}', arg);
    this._sortByDate = arg;
    notifyListeners();
  }

  set setEnableEncryptedKnotes(bool arg) {
    pref.setBool('${PrefKeys.enableEncryptKnotes}', arg);
    this._enableEncryptedKnotes = arg;
    notifyListeners();
  }

  set setFollowSystemTheme(bool arg) {
    pref.setBool('${PrefKeys.followSystemTheme}', arg);
    this._followSystemTheme = arg;
    notifyListeners();
  }

  set setAutoRefreshInterval(Duration time) {
    pref.setString('${PrefKeys.autoSyncInterval}', time.toString());
    this._autoSyncRefreshInterval = time;
    notifyListeners();
  }

  set setCustomBrightness(Brightness brightness) {
    if (brightness == Brightness.light)
      pref.setString('${PrefKeys.customTheme}', 'Light');
    else
      pref.setString('${PrefKeys.customTheme}', 'Dark');
    this._customBrightness = brightness;
    notifyListeners();
  }

  set setLoadingStatus(ProfileLoadingStatus status) {
    this._loadingStatus = status;
    notifyListeners();
  }

  init() async {
    setLoadingStatus = ProfileLoadingStatus.Loading;
    pref = await SharedPreferences.getInstance();
    bool isFirst = (pref.containsKey('${PrefKeys.initialLaunch}'))
        ? pref.getBool('${PrefKeys.initialLaunch}')
        : false;

    if (!isFirst) {
      setSortByDate = pref.getBool('${PrefKeys.sortByDate}');
      setFollowSystemTheme = pref.getBool('${PrefKeys.followSystemTheme}');
      setAutoRefreshInterval =
          Duration(seconds: pref.getInt('${PrefKeys.autoSyncInterval}'));
      setCustomBrightness =
          (pref.getString('${PrefKeys.customTheme}') == "Light")
              ? Brightness.light
              : Brightness.dark;
      setEnableEncryptedKnotes =
          pref.getBool('${PrefKeys.enableEncryptKnotes}');
    } else {
      setSortByDate = true;
      setFollowSystemTheme = true;
      setEnableEncryptedKnotes = true;
      setAutoRefreshInterval = Duration(seconds: 15);
      setCustomBrightness = Brightness.dark;
    }
    setLoadingStatus = ProfileLoadingStatus.Done;
  }
}
