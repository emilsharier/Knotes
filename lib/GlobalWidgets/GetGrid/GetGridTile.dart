import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:knotes/components/providers/LocalDBKnotesProvider.dart';
import 'package:knotes/modelClasses/knote_model.dart';
import 'package:knotes/screens/SingleKnote/single_knote.dart';
import 'package:provider/provider.dart';

import 'LocalWidgets/SelectedIndicator.dart';
import 'LocalWidgets/SingleCard.dart';

class GetGridTile extends StatefulWidget {
  final KnoteModel model;
  final int index;
  GetGridTile({this.index, this.model});
  @override
  _GetGridTileState createState() => _GetGridTileState();
}

class _GetGridTileState extends State<GetGridTile>
    with SingleTickerProviderStateMixin {
  LocalDBKnotesProvider _knoteProvider;

  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 700,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _knoteProvider = Provider.of<LocalDBKnotesProvider>(context);
    return getGridTile(widget.index, widget.model);
  }

  GridTile getGridTile(int index, KnoteModel knote) {
    if (_knoteProvider.selectionMode) {
      return GridTile(
        child: InkResponse(
          borderRadius: BorderRadius.circular(10.0),
          child: _getCardItem(knote),
          onLongPress: () {
            setState(() {
              _animationController.reverse();
              // wait();
              _knoteProvider.changeSelection(enable: false);
            });
          },
          onTap: () {
            setState(() {
              if (_knoteProvider.selectedKnotes.contains(knote.id)) {
                _animationController.reverse();
                // wait();
                _knoteProvider.removeFromSelectedKnotes(id: knote.id);
              } else {
                _animationController.forward();
                _knoteProvider.addToSelectedKnotes(id: knote.id);
              }
              if (_knoteProvider.selectedKnotes.isEmpty) {
                _animationController.reverse();
                // wait();
                _knoteProvider.changeSelection(enable: false);
              }
            });
          },
        ),
      );
    } else {
      return GridTile(
        child: InkResponse(
          borderRadius: BorderRadius.circular(10.0),
          child: _getCardItem(knote),
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                child: SingleKnote(knote),
                type: PageTransitionType.slideInUp,
              ),
            );
          },
          onLongPress: () {
            setState(() {
              print('ID : ' + knote.id);
              _knoteProvider.addToSelectedKnotes(id: knote.id);
              _animationController.forward();
            });
          },
        ),
      );
    }
  }

  _getCardItem(KnoteModel knote) {
    return Card(
      child: Stack(
        children: [
          SingleCard(knote: knote),
          Positioned(
            top: 0.0,
            right: 0.0,
            child: IconButton(
              icon: Icon(
                (knote.isStarred == 1) ? MaterialCommunityIcons.pin : MaterialCommunityIcons.pin_outline,
              ),
              onPressed: () {
                setState(() {
                  _knoteProvider.toggleKnoteStar(knote);
                });
              },
            ),
          ),
          _getOverlay(knote.id),
        ],
      ),
    );
  }

  wait () async {
    await Future.delayed(Duration(milliseconds: 4700));
  }

  _getOverlay(String id) {
    if (_knoteProvider.selectedKnotes.contains(id)) {
      return SelectedIndicator(_animationController);
    } else
      return SizedBox();
  }
}
