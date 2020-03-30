import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:knotes/components/providers/UserProvider.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileMainCardAfterLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentTheme = Theme.of(context).brightness;

    return Card(
      color: Colors.white24,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0),
        child: Temp(),
      ),
    );
  }
}

class Temp extends StatefulWidget {
  @override
  _TempState createState() => _TempState();
}

class _TempState extends State<Temp> {
  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<UserProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(
                _userProvider.currentUser.photoUrl,
                scale: 1.0,
              ),
              radius: 50.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              _userProvider.currentUser.displayName,
              style: TextStyle(
                fontFamily: 'NexaBold',
                fontSize: 25.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<bool> getValue() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();

    if (!_preferences.containsKey('autosync'))
      return false;
    else
      return (_preferences.getBool('autosync'));
  }

  Future<void> toggleValue(value) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setBool('autosync', value);
  }
}
