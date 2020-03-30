import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knotes/components/providers/LocalDBKnotesProvider.dart';
import 'package:knotes/components/providers/UserProvider.dart';
import 'package:knotes/modelClasses/LoginStatus.dart';
import 'package:knotes/screens/component/ProfileMainCardAfterLogin.dart';
import 'package:knotes/screens/component/ProfileMainCardBeforeLogin.dart';
import 'package:knotes/screens/component/ProfileMainCardDuringLogOut.dart';
import 'package:knotes/screens/component/ProfileMainCardDuringLogin.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    print("Profile Bottom Sheet getting called!");
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _autoSync = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<UserProvider>(context, listen: false);
    // final _dbProvider = Provider.of<LocalDBKnotesProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(
            "Profile",
            style: TextStyle(
              fontFamily: 'NexaBold',
              color: Colors.white,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: ListView(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            Consumer<UserProvider>(
              builder: (context, _userProvider, child) {
                return _getMainCard(_userProvider.loginStatus);
              },
            ),
            Divider(
              height: 100.0,
              color: Colors.white,
              thickness: 1.0,
            ),
            Card(
              color: Colors.white24,
              child: InkWell(
                borderRadius: BorderRadius.circular(10.0),
                onTap: () {
                  print("App Info");
                },
                child: Container(
                  padding: EdgeInsets.all(25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Auto Sync",
                        style: TextStyle(
                          fontFamily: 'NexaBold',
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                      // Consumer<LocalDBKnotesProvider>(
                      //   builder: (context, _dbProvider, child) => SizedBox(
                      //     height: 40.0,
                      //     width: 125.0,
                      //     child: LiteRollingSwitch(
                      //       textSize: 16.0,
                      //       textOn: 'Sync on',
                      //       textOff: 'Sync off',
                      //       value: true,
                      //       // value: _dbProvider.autoSync,
                      //       colorOff: Colors.redAccent,
                      //       colorOn: Colors.green,
                      //       iconOff: Icons.cloud_off,
                      //       iconOn: Icons.cloud_done,
                      //       onChanged: (v) {
                      //         _dbProvider.toggle(v);
                      //       },
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.white24,
              child: InkWell(
                borderRadius: BorderRadius.circular(10.0),
                onTap: () {
                  print("About");
                },
                child: Container(
                  padding: EdgeInsets.all(25.0),
                  child: Text(
                    "About",
                    style: TextStyle(
                      fontFamily: 'NexaBold',
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.white24,
              child: InkWell(
                borderRadius: BorderRadius.circular(10.0),
                onTap: () {
                  if (_userProvider.loginStatus ==
                      LoginStatus.UnAuthenticated) {
                    _scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        content: Text(
                          "You're already logged out!",
                          style: TextStyle(
                            fontFamily: 'NexaBold',
                            color: Colors.white,
                          ),
                        ),
                        action: SnackBarAction(
                          label: 'Close',
                          textColor: Colors.white,
                          onPressed: () {
                            _scaffoldKey.currentState.hideCurrentSnackBar();
                          },
                        ),
                        backgroundColor: Colors.white24,
                      ),
                    );
                  }
                  _userProvider.signOut();
                },
                child: Container(
                  padding: EdgeInsets.all(25.0),
                  child: Text(
                    "Log out",
                    style: TextStyle(
                      fontFamily: 'NexaBold',
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getMainCard(LoginStatus status) {
    switch (status) {
      case LoginStatus.Authenticated:
        return ProfileMainCardAfterLogin();
        break;
      case LoginStatus.UnAuthenticated:
        return ProfileMainCardBeforeLogin();
        break;
      case LoginStatus.Authenticating:
        return ProfileMainCardDuringLogin();
        break;
      case LoginStatus.LoggingOut:
        return ProfileMainCardDuringLogOut();
        break;
      default:
        return ProfileMainCardBeforeLogin();
    }
  }
}
