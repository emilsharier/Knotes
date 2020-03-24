import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
class NoDataFlareAnimation extends StatefulWidget {
  @override
  _NoDataFlareAnimationState createState() => _NoDataFlareAnimationState();
}

class _NoDataFlareAnimationState extends State<NoDataFlareAnimation> {
  final FlareControls _controls = FlareControls();

  @override
  Widget build(BuildContext context) {
    final currentBrightness = Theme.of(context).brightness;
    return Center(
      child: SizedBox(
        height: 600.0,
        width: 700.0,
        child: FlareActor(
          'assets/flareAnimations/noDataLoader.flr',
          color: (currentBrightness == Brightness.dark)
              ? Colors.white
              : Colors.black,
          alignment: Alignment.center,
          controller: _controls,
          animation: 'no_data_found',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
