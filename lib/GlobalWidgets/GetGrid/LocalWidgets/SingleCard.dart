import 'package:flutter/material.dart';
import 'package:knotes/modelClasses/knote_model.dart';

class SingleCard extends StatelessWidget {
  final KnoteModel knote;
  SingleCard({this.knote});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Text(
              '${knote.title}',
              style: TextStyle(fontSize: 20, fontFamily: 'NexaBold'),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text(
              '${knote.content}',
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style:
                  TextStyle(fontSize: 18, fontFamily: 'NexaLight', height: 1.3),
            ),
          ),
        ],
      ),
    );
  }
}
