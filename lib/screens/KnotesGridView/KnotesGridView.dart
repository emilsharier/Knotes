import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:knotes/components/PrefKeys/PrefKeys.dart';
import 'package:knotes/components/providers/AppPreferences.dart';
import 'package:knotes/components/providers/LocalDBKnotesProvider.dart';
import 'package:knotes/modelClasses/LocalDBKnotesModel.dart';
import 'package:knotes/screens/KnotesGridView/LocalWidgets/Fetching.dart';
import 'package:knotes/screens/NoteTakingScreen/note_taking_screen.dart';
import 'package:knotes/screens/SearchScreen/SearchScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LocalWidgets/NoDataFlareAnimation.dart';
import 'LocalWidgets/NonStarredKnotes.dart';
import 'LocalWidgets/StarredKnotes.dart';

class KnotesGridView extends StatefulWidget {
  KnotesGridView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _KnotesGridViewState createState() => _KnotesGridViewState();
}

class _KnotesGridViewState extends State<KnotesGridView> {
  LocalDBKnotesProvider _knoteProvider;

  SharedPreferences pref;
  String searchFeature = 'searchFeature';
  String addFeature = 'addFeature';

  Icon searchIcon = Icon(Icons.search);
  Icon fabIcon = Icon(Icons.add);

  @override
  void initState() {
    super.initState();
    initializeFeatureDiscovery();
  }

  initializeFeatureDiscovery() async {
    pref = await SharedPreferences.getInstance();
    bool val;
    FeatureDiscovery.clearPreferences(context, [searchFeature, addFeature]);
    if (pref.containsKey('${PrefKeys.isFeatureDiscoveryCompleted}'))
      val = pref.getBool('${PrefKeys.isFeatureDiscoveryCompleted}');
    else {
      FeatureDiscovery.discoverFeatures(context, [searchFeature, addFeature]);
      pref.setBool('${PrefKeys.isFeatureDiscoveryCompleted}', true);
      val = true;
    }
    print('Value is : ${val.toString()}');
    if (!val)
      FeatureDiscovery.discoverFeatures(context, [searchFeature, addFeature]);
  }

  @override
  Widget build(BuildContext context) {
    _knoteProvider = Provider.of<LocalDBKnotesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Knotes'),
        centerTitle: false,
        actions: <Widget>[
          StatefulBuilder(
            builder: (BuildContext context,
                    void Function(void Function()) setState) =>
                DescribedFeatureOverlay(
              featureId: searchFeature,
              tapTarget: searchIcon,
              targetColor:
                  (MediaQuery.of(context).platformBrightness == Brightness.dark)
                      ? Colors.black
                      : Colors.white,
              backgroundColor: (MediaQuery.of(context).platformBrightness ==
                      Brightness.light)
                  ? Color.fromRGBO(50, 50, 50, 0.5)
                  : Color.fromRGBO(130, 130, 130, 0.5),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Search for your knotes',
                    style: TextStyle(
                      fontFamily: 'NexaBold',
                      fontSize: 40.0,
                    ),
                  ),
                ],
              ),
              enablePulsingAnimation: true,
              child: IconButton(
                icon: searchIcon,
                onPressed: () {
                  print('Search');
                  Navigator.push(
                    context,
                    PageTransition(
                      child: SearchScreen(),
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                      type: PageTransitionType.rippleRightDown,
                    ),
                  );
                },
              ),
            ),
          ),
          // IconButton(
          //   icon: Icon(Icons.search),
          //   onPressed: () {
          //     print('Search');
          //   },
          // ),
        ],
      ),
      body: _createBody(),
      // body: _getBody(),
      floatingActionButton: StatefulBuilder(
        builder:
            (BuildContext context, void Function(void Function()) setState) =>
                DescribedFeatureOverlay(
          featureId: addFeature,
          tapTarget: _getIcon(),
          targetColor:
              (MediaQuery.of(context).platformBrightness == Brightness.dark)
                  ? Colors.black
                  : Colors.white,
          backgroundColor:
              (MediaQuery.of(context).platformBrightness == Brightness.light)
                  ? Color.fromRGBO(50, 50, 50, 0.5)
                  : Color.fromRGBO(130, 130, 130, 0.5),
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              'Add a new knote',
              style: TextStyle(
                fontFamily: 'NexaBold',
                fontSize: 40.0,
              ),
            ),
          ),
          child: _getFAB(),
        ),
      ),
    );
  }

  _getIcon() {
    if (_knoteProvider.selectionMode)
      return Icon(Icons.delete);
    else
      return Icon(Icons.add);
  }

  _getFAB() {
    return FloatingActionButton(
      child: _getIcon(),
      onPressed: () {
        FeatureDiscovery.completeCurrentStep(context);
        if (_knoteProvider.selectionMode) {
          _knoteProvider.deleteKnote(_knoteProvider.selectedKnotes);
          _knoteProvider.clearSelectedKnotes();
        } else
          Navigator.push(
            context,
            PageTransition(
              child: NoteTakingScreen(),
              type: PageTransitionType.rippleRightUp,
              duration: Duration(milliseconds: 450),
              curve: Curves.easeInOut,
            ),
          );
      },
    );
  }

  Widget _createBody() {
    print('KnotesGridView : ' + _knoteProvider.knoteStatus.toString());
    if (_knoteProvider.knoteStatus == LocalKnotesStatus.Initialising ||
        _knoteProvider.knoteStatus == LocalKnotesStatus.Refreshing)
      return Fetching();
    else if (_knoteProvider.knoteStatus == LocalKnotesStatus.NoKnotesAvailable)
      return NoDataFlareAnimation();
    else {
      // return Text('Hello');
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            (_knoteProvider.starredKontes.isNotEmpty)
                ? StarredKnotes()
                : SizedBox(),
            (_knoteProvider.starredKontes.isNotEmpty)
                ? Padding(
                    padding: EdgeInsets.only(
                      bottom: 10.0,
                    ),
                    child: Divider(
                      thickness: 2.0,
                    ),
                  )
                : SizedBox(),
            NonStarredKnotes(),
          ],
        ),
      );
    }
  }
}
