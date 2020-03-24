import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:knotes/components/providers/UserProvider.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:provider/provider.dart';

class ProfileBottomSheetUserInfoAfterLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentTheme = Theme.of(context).brightness;
    final _userProvider = Provider.of<UserProvider>(context);

    final _iconAndTextColor = (currentTheme == Brightness.dark) ? Colors.black : Colors.white;
    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(
            _userProvider.currentUser.photoUrl,
            scale: 1.0,
          ),
          radius: 70.0,
        ),
        SizedBox(
          height: 10.0,
        ),
        NiceButton(
          background:
              (currentTheme == Brightness.dark) ? Colors.white : Colors.black,
          icon: MaterialCommunityIcons.cloud,
          text: 'Sync',
          fontSize: 20.0,
          radius: 20.0,
          width: 150.0,
          iconColor: _iconAndTextColor,
          textColor: _iconAndTextColor,
          onPressed: () {},
        ),
      ],
    );
  }
}
