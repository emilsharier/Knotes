import 'package:flutter/material.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';

class SelectionAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SelectionAppBar({
    Key key,
    this.title,
    this.selection = Selection.empty,
    this.selectedKnotes,
  })  : assert(selection != null),
        super(key: key);

  final Widget title;
  final Selection selection;
  final List<String> selectedKnotes;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 1000),
      reverseDuration: Duration(milliseconds: 1000),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOutBack,
      child: selection.isSelecting
          ? AppBar(
              key: Key('selecting'),
              titleSpacing: 0,
              leading: const CloseButton(),
              title: Text(
                '${selection.amount} item(s) selected',
                style: TextStyle(fontSize: 20.0, fontFamily: 'NexaLight'),
              ),
            )
          : SizedBox(),
    );
  }
}
