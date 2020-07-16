import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:knotes/modelClasses/knote_model.dart';
import 'package:knotes/screens/NoteTakingScreen/note_taking_screen.dart';
import 'package:knotes/screens/SearchScreen/SearchScreen.dart';
import 'package:knotes/screens/SingleKnote/single_knote.dart';
import 'package:knotes/screens/home_screen.dart';

class Router {
  static const String homePage = '/';
  static const String addKnote = '/add_knote';
  static const String singleKnote = '/single_knote';
  static const String searchScreen = '/search_screen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return PageTransition(
          child: HomeScreen(),
          type: PageTransitionType.fadeIn,
        );
        break;
      case addKnote:
        return PageTransition(
          child: NoteTakingScreen(),
          type: PageTransitionType.slideInUp,
        );
        break;
      case singleKnote:
        KnoteModel model = settings.arguments as KnoteModel;
        return PageTransition(
          child: SingleKnote(model),
          type: PageTransitionType.slideDown,
        );
        break;
      case searchScreen:
        return PageTransition(
          child: SearchScreen(),
          type: PageTransitionType.slideInDown,
        );
        break;
    }
  }
}
