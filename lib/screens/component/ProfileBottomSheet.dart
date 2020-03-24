import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knotes/components/providers/UserProvider.dart';
import 'package:knotes/components/repositories/GoogleSignIn.dart';
import 'package:knotes/modelClasses/LoginStatus.dart';
import 'package:knotes/screens/component/ProfileBottomSheetUserInfoBeforeLogin.dart';
import 'package:knotes/screens/component/ProfileBottomSheetUserInfoAfterLogin.dart';
import 'package:provider/provider.dart';

import 'ProfileBottomSheetUserInfoBeforeLogin.dart';

class ProfileBottomSheet extends StatefulWidget {
  @override
  _ProfileBottomSheetState createState() => _ProfileBottomSheetState();
}

class _ProfileBottomSheetState extends State<ProfileBottomSheet> {

  @override
  void initState() {
    super.initState();
    print("Profile Bottom Sheet getting called!");
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = Theme.of(context).brightness;
    final _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
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
            (_userProvider.loginStatus != LoginStatus.Authenticated)
                ? ProfileBottomSheetuserInfoBeforeLogin()
                : ProfileBottomSheetUserInfoAfterLogin(),
            Divider(
              height: 100.0,
              color: Colors.white,
            ),
            Material(
              child: InkWell(
                onTap: () {
                  print("App Info");
                },
                child: ListTile(
                  title: Text("App Info"),
                ),
              ),
            ),
            ListTile(
              title: Text("Help"),
            ),
            ListTile(
              title: Text("Log Out"),
              onTap: () async {
                print("Signing out!");
                _userProvider.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
