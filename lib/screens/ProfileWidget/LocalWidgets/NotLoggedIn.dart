import 'package:flutter/material.dart';

class NotLoggedIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        // color: Colors.red,
      ),
      child: Column(
        children: <Widget>[],
      ),
    );
  }
}
