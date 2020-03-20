import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:knotes/components/models/SelectionProvider.dart';
import 'package:knotes/components/models/knote_model.dart';
import 'package:knotes/components/repositories/RepositoryServiceKnote.dart';
import 'package:knotes/screens/modules/ErrorPage.dart';
import 'package:knotes/screens/modules/KnotesGridView.dart';
import 'package:knotes/screens/modules/KnotesListView.dart';
import 'package:knotes/screens/modules/WaitingForConnection.dart';
import 'package:knotes/screens/modules/empty_list.dart';
import 'package:knotes/screens/note_taking_screen.dart';
import 'package:provider/provider.dart';

import 'modules/single_knote.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Stream<List<KnoteModel>> _knoteStream;

  bool _isGrid;

  Icon _icon;

  @override
  void initState() {
    _isGrid = true;
    _icon = Icon(Icons.add);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final stream = Provider.of<SelectionProvider>(context);
    stream.refresh();
    return StreamBuilder<List<KnoteModel>>(
      stream: stream.knoteStream,
      builder: (context, snapshot) {
//            print(snapshot.data);
        if (snapshot.hasData) {
          return KnotesGridView(snapshot.data, stream);
        } else if (snapshot.connectionState == ConnectionState.waiting)
          return WaitingForConnection();
        else
          return ErrorPage();
      },
    );
  }

  _profileTap() {}
}
