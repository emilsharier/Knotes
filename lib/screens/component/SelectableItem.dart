import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:knotes/modelClasses/knote_model.dart';
import 'package:knotes/screens/modules/single_knote.dart';

class SelectableItem extends StatefulWidget {
  const SelectableItem({
    Key key,
    @required this.index,
    @required this.color,
    @required this.selected,
    @required this.knoteModel,
    @required this.controller,
  }) : super(key: key);

  final int index;
  final MaterialColor color;
  final bool selected;
  final KnoteModel knoteModel;
  final DragSelectGridViewController controller;

  @override
  _SelectableItemState createState() => _SelectableItemState();
}

class _SelectableItemState extends State<SelectableItem>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    print(widget.knoteModel.title);
    _controller = AnimationController(
      value: widget.selected ? 1 : 0,
      duration: kThemeChangeDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );
  }

  @override
  void didUpdateWidget(SelectableItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected) {
      if (widget.selected) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Container(
          margin: EdgeInsets.all(10.0),
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: DecoratedBox(
              child: child,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: calculateColor(),
              ),
            ),
          ),
        );
      },
      child: Container(
//        alignment: Alignment.center,
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${widget.knoteModel.title}',
              style: TextStyle(fontSize: 20, fontFamily: 'NexaBold'),
            ),
            SizedBox(
              height: 10.0,
            ),
            Flexible(
              child: Text(
                '${widget.knoteModel.content}',
                style: TextStyle(fontSize: 18, fontFamily: 'NexaLight'),
                overflow: TextOverflow.fade,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color calculateColor() {
    if (Theme.of(context).brightness == Brightness.light)
      return Color.lerp(
        widget.color.shade300,
        widget.color.shade500,
        _controller.value,
      );
    else
      return Color.lerp(
        widget.color.shade800,
        widget.color.shade900,
        _controller.value,
      );
  }
}
