import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:knotes/GlobalWidgets/GetGrid/GetGridTile.dart';
import 'package:knotes/components/providers/LocalDBKnotesProvider.dart';
import 'package:knotes/modelClasses/knote_model.dart';
import 'package:provider/provider.dart';

class StarredKnotes extends StatefulWidget {
  @override
  _StarredKnotesState createState() => _StarredKnotesState();
}

class _StarredKnotesState extends State<StarredKnotes> {
  LocalDBKnotesProvider _knoteProvider;
  @override
  Widget build(BuildContext context) {
    _knoteProvider = Provider.of<LocalDBKnotesProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // _getHeader(),
        _getGrid(),
      ],
    );
  }

  _getHeader() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Icon(MaterialCommunityIcons.pin),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'Knotes',
              style: TextStyle(fontFamily: 'NexaBold'),
            ),
          ),
        ],
      ),
    );
  }

  _getGrid() {
    
      return StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        crossAxisSpacing: 7.0,
        mainAxisSpacing: 7.0,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: _knoteProvider.starredKontes.length,
        itemBuilder: (BuildContext context, int index) {
          return GetGridTile(
              index: index, model: _knoteProvider.starredKontes[index]);
        },
        staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
        padding: const EdgeInsets.all(4.0),
      );
  }
}
