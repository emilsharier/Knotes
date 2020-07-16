import 'package:flutter/material.dart';

class NoDataFlareAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentBrightness = Theme.of(context).brightness;
    TextStyle style = TextStyle(
      fontFamily: 'NexaLight',
      fontSize: MediaQuery.of(context).size.width / 20,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: Text('It feels so empty here ..', style: style),
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Click ',
              style: style,
            ),
            Container(
              alignment: Alignment.center,
              child: Icon(
                Icons.add_circle,
                size: MediaQuery.of(context).size.width / 15,
              ),
            ),
            Text(
              ' to get started',
              style: style,
            ),
          ],
        ),
      ],
    );
  }
}
