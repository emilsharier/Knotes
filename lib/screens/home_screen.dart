import 'package:flutter/material.dart';
import 'package:knotes/components/providers/LocalDBKnotesProvider.dart';
import 'package:knotes/modelClasses/LocalDBKnotesModel.dart';
import 'package:knotes/screens/modules/KnotesGridView.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _knotesProvider = Provider.of<LocalDBKnotesProvider>(context);
    if (_knotesProvider.knoteStatus == LocalKnotesStatus.Initialising)
      return Center(
        child: Text("Initialising"),
      );
    else if (_knotesProvider.knoteStatus == LocalKnotesStatus.KnotesAvailable)
      return KnotesGridView(_knotesProvider.knotes);
    else
      return KnotesGridView(_knotesProvider.knotes);
  }
}
