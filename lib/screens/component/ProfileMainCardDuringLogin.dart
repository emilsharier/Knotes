import 'package:flutter/material.dart';

class ProfileMainCardDuringLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white24,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 70.0),
        child: Column(
          children: <Widget>[
            Text(
              "Loggin in. Please wait",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'NexaBold',
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
