import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:knotes/GlobalWidgets/GetGrid/LocalWidgets/SingleCard.dart';
import 'package:knotes/components/providers/LocalDBKnotesProvider.dart';
import 'package:knotes/components/repositories/theme_repository/textField_custom_theme.dart'
    as ct;
import 'package:knotes/modelClasses/knote_model.dart';
import 'package:knotes/screens/SingleKnote/single_knote.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocalDBKnotesProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SearchBar<KnoteModel>(
            onSearch: provider.searchForKnotes,
            cancellationText: Text(
              'Clear',
              style: TextStyle(
                fontFamily: 'NexaBold',
                fontSize: MediaQuery.of(context).size.width / 20,
              ),
            ),
            suggestions: provider.knotes,
            textStyle: TextStyle(
              fontFamily: 'NexaBold',
              fontSize: MediaQuery.of(context).size.width / 20,
            ),
            onItemFound: (KnoteModel model, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        child: SingleKnote(model),
                        type: PageTransitionType.slideParallaxUp),
                  );
                },
                child: Card(child: SingleCard(knote: model)),
              );
            },
            minimumChars: 1,
            hintText: 'Search',
            hintStyle: TextStyle(
              fontFamily: 'NexaBold',
              fontSize: MediaQuery.of(context).size.width / 20,
            ),
            emptyWidget: Center(
              child: Text(
                'No results',
                style: TextStyle(
                  fontFamily: 'NexaBold',
                  fontSize: MediaQuery.of(context).size.width / 20,
                ),
              ),
            ),
            placeHolder: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0, right: 4.0),
                    child: Icon(Icons.search),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Search something',
                      style: TextStyle(
                        fontFamily: 'NexaBold',
                        fontSize: MediaQuery.of(context).size.width / 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            crossAxisCount: 4,
            indexedScaledTileBuilder: (index) {
              return ScaledTile.fit(2);
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
