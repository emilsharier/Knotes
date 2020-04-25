import 'dart:math';

import 'package:flutter/material.dart';

class SelectedIndicator extends StatefulWidget {
  
  AnimationController animationController;

  SelectedIndicator(this.animationController);
  @override
  _SelectedIndicatorState createState() => _SelectedIndicatorState();
}

class _SelectedIndicatorState extends State<SelectedIndicator>
    with SingleTickerProviderStateMixin {
  Animation _animation;
  Animation _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animation = Tween(
      begin: 0.0,
      end: 4.0,
    ).animate(
      CurvedAnimation(parent: widget.animationController, curve: Curves.bounceInOut),
    );

    _scaleAnimation = Tween(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(parent: widget.animationController, curve: Curves.bounceInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: widget.animationController,
            builder: (context, _) {
              return RotationTransition(
                turns: _animation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Icon(Icons.check_circle),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
