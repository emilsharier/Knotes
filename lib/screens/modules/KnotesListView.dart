import 'package:flutter/material.dart';
import 'package:knotes/components/models/knote_model.dart';

class KnotesListView extends StatefulWidget {

  List<KnoteModel> snapshot;
  KnotesListView(this.snapshot);
  @override
  _KnotesListViewState createState() => _KnotesListViewState();
}

class _KnotesListViewState extends State<KnotesListView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: widget.snapshot.map((knote) {
        return ListTile(
          title: Text(knote.title),
          subtitle: Text(knote.content),
        );
      }).toList(),
    );
  }
}
