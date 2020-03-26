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
        SizedBox(
          height: 10.0,
        ),
        Column(
          children: <Widget>[
            Text(
              "Autosync",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'NexaBold',
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            FutureBuilder(
                future: getValue(),
                builder: (context, snapshot) {
                  return SizedBox(
                    width: 130.0,
                    height: 50.0,
                    child: LiteRollingSwitch(
                      textSize: 16.0,
                      textOn: 'Sync on',
                      textOff: 'Sync off',
                      value: (snapshot.data),
                      colorOff: Colors.redAccent,
                      colorOn: Colors.green,
                      iconOff: Icons.cloud_off,
                      iconOn: Icons.cloud_done,
                      onChanged: (v) {
                        toggleValue(v);
                      },
                    ),
                  );
                }),
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
