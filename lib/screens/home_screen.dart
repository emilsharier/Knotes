import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:knotes/components/providers/UserProvider.dart';
import 'package:knotes/components/repositories/RepositoryServiceKnote.dart';
import 'package:knotes/modelClasses/knote_model.dart';
import 'package:knotes/screens/modules/KnotesGridView.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider.instance(),
      child: StreamBuilder<List<KnoteModel>>(
        stream: RepositoryServiceKnote.getAllKnotes().asStream(),
        builder: (context, snapshot) {
          // print(_userProvider.currentUser.email);
          if (snapshot.hasData) {
            return KnotesGridView(snapshot.data);
          } else if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: Text("Waiting!"),
            );
          else
            return Center(
              child: Text("Error!"),
            );
        },
      ),
    );
  }
}
