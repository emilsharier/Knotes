import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:knotes/components/providers/UserProvider.dart';
import 'package:provider/provider.dart';

class ProfileBottomSheetuserInfoBeforeLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<UserProvider>(context);
    return Card(
      color: Colors.white24,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                radius: 50.0,
                child: Icon(
                  MaterialCommunityIcons.face_profile,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.grey,
                onTap: () {
                  print("Something");
                },
                borderRadius: BorderRadius.circular(10.0),
                child: Ink(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Ionicons.logo_google,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Sign in/up",
                        style: TextStyle(
                          fontFamily: 'NexaBold',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
