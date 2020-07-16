import 'package:flutter/material.dart';
import 'package:knotes/components/providers/UserProvider.dart';
import 'package:knotes/screens/ProfileWidget/LocalWidgets/NotLoggedIn.dart';
import 'package:knotes/screens/SettingsWidget/settings_widget.dart';
import 'package:provider/provider.dart';

class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    return Wrap(
      children: <Widget>[
        _getBody(provider.loginStatus),
        SettingsWidget(),
      ],
    );
  }

  _getBody(LoginStatus status) {
    Widget _child;
    switch (status) {
      case LoginStatus.NotLoggedIn:
        _child = NotLoggedIn();
        break;
      case LoginStatus.LoggingIn:
        _child = CircularProgressIndicator();
        break;
      case LoginStatus.LoginFailed:
        _child = Text('Not logged in');
        break;
      case LoginStatus.LoggedIn:
        _child = Text('Welcome');
        break;
      default:
        _child = Text('default');
        break;
    }
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 400),
      child: _child,
    );
  }
}
