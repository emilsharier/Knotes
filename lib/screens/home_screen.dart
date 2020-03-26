import 'package:flutter/material.dart';
import 'package:knotes/components/providers/LocalDBKnotesProvider.dart';
import 'package:knotes/screens/modules/KnotesGridView.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences _preferences;

  @override
  void initState() {
    super.initState();
    // initialise();
  }

  initialise() async {
    _preferences = await SharedPreferences.getInstance();
    if (!_preferences.containsKey('autosync')) {
      _preferences.setBool('autosync', false);
      print("Setting autosyync");
    }
    print(_preferences.getKeys());
  }

  @override
  Widget build(BuildContext context) {
    final _knotesProvider = Provider.of<LocalDBKnotesProvider>(context);
    _knotesProvider.getAllKnotes();
    return KnotesGridView(_knotesProvider.knotes);
  }
}
