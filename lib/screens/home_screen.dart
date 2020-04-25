import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';

import 'KnotesGridView/KnotesGridView.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FeatureDiscovery(
        child: DefaultBottomBarController(child: KnotesGridView()));
  }
}
