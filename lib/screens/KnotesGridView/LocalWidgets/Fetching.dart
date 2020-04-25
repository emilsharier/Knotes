import 'package:flutter/material.dart';

class Fetching extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
      fontFamily: 'NexaLight',
      fontSize: MediaQuery.of(context).size.width / 20,
    );
    final Color color =
        (MediaQuery.of(context).platformBrightness == Brightness.dark)
            ? Colors.white
            : Colors.black;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'Refreshing',
          style: style,
        ),
      ],
    );
  }
}
