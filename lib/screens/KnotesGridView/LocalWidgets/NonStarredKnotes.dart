import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:knotes/GlobalWidgets/GetGrid/GetGridTile.dart';
import 'package:knotes/components/providers/LocalDBKnotesProvider.dart';
import 'package:provider/provider.dart';

class NonStarredKnotes extends StatefulWidget {
  @override
  _NonStarredKnotesState createState() => _NonStarredKnotesState();
}

class _NonStarredKnotesState extends State<NonStarredKnotes> {
  LocalDBKnotesProvider _knoteProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _knoteProvider = Provider.of<LocalDBKnotesProvider>(context);
    print('Selection mode is ${_knoteProvider.selectionMode.toString()}');
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      crossAxisSpacing: 7.0,
      mainAxisSpacing: 7.0,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: _knoteProvider.nonStarredKnotes.length,
      itemBuilder: (BuildContext context, int index) {
        return GetGridTile(
            index: index, model: _knoteProvider.nonStarredKnotes[index]);
      },
      staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
      padding: const EdgeInsets.all(4.0),
    );
  }
}
