import 'dart:io';

import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:knotes/components/providers/LocalDBKnotesProvider.dart';
import 'package:knotes/components/providers/UserProvider.dart';
import 'package:knotes/components/repositories/RepositoryServiceKnote.dart';
import 'package:knotes/modelClasses/knote_model.dart';
import 'package:knotes/screens/component/NoDataFlareAnimation.dart';
import 'package:knotes/screens/component/ProfilePage.dart';
import 'package:knotes/screens/component/SelectableItem.dart';
import 'package:knotes/screens/component/SelectionAppBar.dart';
import 'package:knotes/screens/home_screen.dart';
import 'package:knotes/screens/modules/single_knote.dart';
import 'package:provider/provider.dart';

import '../note_taking_screen.dart';

class KnotesGridView extends StatefulWidget {
  List<KnoteModel> snapshot;

  KnotesGridView(this.snapshot);

  @override
  _KnotesGridViewState createState() => _KnotesGridViewState();
}

class _KnotesGridViewState extends State<KnotesGridView> {
  List<KnoteModel> data;
  Map<int, String> _selectedIDs;
  List<String> _selectedKnotes;

  final controller = DragSelectGridViewController();

  Set<int> idSet;

  @override
  void initState() {
    super.initState();
    controller.addListener(scheduleRebuild);
    data = widget.snapshot;
    _selectedIDs = Map<int, String>();
    _selectedKnotes = List<String>();
    idSet = Set<int>();

    for (int i = 0; i < widget.snapshot.length; i++)
      _selectedIDs.addAll({i: widget.snapshot[i].id});
  }

//  @override
//  void dispose() {
//    controller.removeListener(scheduleRebuild);
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    final _knoteProvider = Provider.of<LocalDBKnotesProvider>(context);

    _selectedKnotes.clear();
    idSet = controller.selection.selectedIndexes;
    for (int i in idSet) _selectedKnotes.add(_selectedIDs[i]);
//    _selectedKnotes.remove(null);
    // print("Current selection ");
    // print(_selectedKnotes);
    print(idSet);
    return WillPopScope(
      onWillPop: () async {
        return (await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Are you sure?"),
                    content: Text("Do you want to exit?"),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () => exit(0),
                        child: Text("Yes"),
                      ),
                      FlatButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("No"),
                      ),
                    ],
                  );
                })) ??
            false;
      },
      child: Scaffold(
        appBar: (_selectedKnotes.isNotEmpty)
            ? SelectionAppBar(
                selection: controller.selection,
                selectedKnotes: _selectedKnotes,
              )
            : AppBar(
                automaticallyImplyLeading: false,
                title: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text("Knotes"),
                ),
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(MaterialCommunityIcons.face),
                    onPressed: () {
                      _profileTap();
                    },
                  ),
                ],
              ),
        body: (widget.snapshot.length == 0)
            ? NoDataFlareAnimation()
            : DragSelectGridView(
                physics: BouncingScrollPhysics(),
                gridController: controller,
                padding: EdgeInsets.all(8),
                itemCount: widget.snapshot.length,
                unselectOnWillPop: true,
                itemBuilder: (context, index, selected) {
                  if (idSet.isNotEmpty) {
                    // print("Selected IDs");
                    // print(_selectedKnotes);
                    return SelectableItem(
                      index: index,
                      color: (Theme.of(context).brightness == Brightness.dark)
                          ? Colors.grey
                          : Colors.grey,
                      selected: selected,
                      knoteModel: widget.snapshot[index],
                      controller: controller,
                    );
                  } else
                    return InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: () {
//                print("User tap");
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.slideInUp,
                            child: SingleKnote(widget.snapshot[index]),
                          ),
                        );
                      },
                      child: SelectableItem(
                        index: index,
                        color: (Theme.of(context).brightness == Brightness.dark)
                            ? Colors.grey
                            : Colors.grey,
                        selected: selected,
                        knoteModel: widget.snapshot[index],
                        controller: controller,
                      ),
                    );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  childAspectRatio: 0.8,
                ),
              ),
        floatingActionButton: FloatingActionButton(
          child:
              (_selectedKnotes.isEmpty) ? Icon(Icons.add) : Icon(Icons.delete),
          onPressed: () async {
            if (_selectedKnotes.isNotEmpty) {
              await _knoteProvider.deleteKnote(_selectedKnotes).then((t) {
                _selectedKnotes.clear();
                // Navigator.push(
                //   context,
                //   PageTransition(
                //     type: PageTransitionType.rippleRightUp,
                //     duration: Duration(milliseconds: 350),
                //     child: HomeScreen(),
                //   ),
                // );
              });
            } else
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rippleRightUp,
                  duration: Duration(milliseconds: 350),
                  child: NoteTakingScreen(),
                ),
              );
          },
        ),
      ),
    );
  }

  _profileTap() {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.rippleRightDown,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 400),
        child: ChangeNotifierProvider(
          create: (_) => UserProvider.instance(),
          child: ProfilePage(),
        ),
      ),
    );
  }

  void scheduleRebuild() => setState(() {});
}
