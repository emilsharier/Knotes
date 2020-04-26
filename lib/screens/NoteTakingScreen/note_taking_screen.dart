import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:knotes/components/providers/LocalDBKnotesProvider.dart';
import 'package:knotes/components/repositories/RepositoryServiceKnote.dart';
import 'package:knotes/components/repositories/theme_repository/textField_custom_theme.dart'
    as ct;

import 'package:flutter/services.dart';
import 'package:knotes/modelClasses/knote_model.dart';
import 'package:provider/provider.dart';

class NoteTakingScreen extends StatefulWidget {
  @override
  _NoteTakingScreenState createState() => _NoteTakingScreenState();
}

class _NoteTakingScreenState extends State<NoteTakingScreen> {
  final _formState = GlobalKey<FormState>();
  FocusNode _contentFocus;
  FocusNode _titleFocus;

  TextEditingController _titleController = new TextEditingController();
  TextEditingController _contentController = new TextEditingController();

  String id, title, content;

  bool _starKnote;

  KnoteModel knoteModel;

  LocalDBKnotesProvider _knotesProvider;

  Color color;

  @override
  void initState() {
    _initialise();
    _contentFocus = FocusNode();
    _titleFocus = FocusNode();
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        if (!visible) {
          _contentFocus.unfocus();
          _titleFocus.unfocus();
        }
      },
    );
    SystemChannels.lifecycle.setMessageHandler((String state) {
      if (state.contains("paused") || state.contains("inactive")) {
        _contentFocus.unfocus();
        _titleFocus.unfocus();
      } else {
        _contentFocus.requestFocus();
        _titleFocus.requestFocus();
      }
    });
    super.initState();
  }

  _initialise() async {
    // print("Initialisation is being done!");
    _starKnote = false;
    knoteModel = await RepositoryServiceKnote.getTempData();
    setState(() {
      _titleController.text = knoteModel.title;
      _contentController.text = knoteModel.content;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _contentFocus.dispose();
  }

  inverseColor() {
    return (color == Colors.white) ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    _knotesProvider = Provider.of<LocalDBKnotesProvider>(context);
    color = (MediaQuery.of(context).platformBrightness == Brightness.dark)
        ? Colors.black
        : Colors.white;
    return WillPopScope(
      onWillPop: () async {
        title = (_titleController.text == null) ? "" : _titleController.text;
        content =
            (_contentController.text == null) ? "" : _contentController.text;

        knoteModel = new KnoteModel(
          id: "",
          title: title,
          content: content,
        );

        RepositoryServiceKnote.addTempData(knoteModel);
        // Navigator.pop(context);

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: color,
          iconTheme: IconThemeData(
            color: inverseColor(),
          ),
          actions: <Widget>[
            IconButton(
              icon: (_starKnote) ? Icon(MaterialCommunityIcons.pin) : Icon(MaterialCommunityIcons.pin_outline),
              onPressed: () {
                setState(() {
                  _starKnote = !_starKnote;
                });
              },
            ),
          ],
        ),
        backgroundColor: color,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _formState,
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _titleController,
                  focusNode: _titleFocus,
                  cursorWidth: 3.0,
                  cursorColor: inverseColor(),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(15.0),
                    hintText: 'Title',
                    hintStyle: (color == Colors.white)
                        ? ct.darkTitleHint
                        : ct.lightTitleHint,
                    focusedBorder: InputBorder.none,
                  ),
                  style: (color == Colors.white) ? ct.lightTitle : ct.darkTitle,
                  maxLines: null,
                  autofocus: false,
                ),
                TextField(
                  controller: _contentController,
                  focusNode: _contentFocus,
                  cursorColor: inverseColor(),
                  cursorWidth: 2.0,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15.0),
                    border: InputBorder.none,
                    hintText: 'Knotes',
                    hintStyle: (color == Colors.black)
                        ? ct.lightContentHint
                        : ct.darkContentHint,
                    focusedBorder: InputBorder.none,
                  ),
                  style: (color == Colors.white)
                      ? ct.lightContent
                      : ct.darkContent,
                  maxLines: null,
                  autofocus: false,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: inverseColor(),
          elevation: 10.0,
          heroTag: 'floating',
          onPressed: () {
            onClick();
          },
          child: Icon(
            Icons.save,
            color: color,
          ),
        ),
      ),
    );
  }

  onClick() async {
    var now = DateTime.now();

    id = now.millisecondsSinceEpoch.toString();
    title = _titleController.text;
    content = _contentController.text;

    if (title.isEmpty && content.isEmpty) {
      Navigator.pop(context);
      return;
    }
    knoteModel = new KnoteModel(
      id: id,
      title: title,
      content: content,
      isStarred: (_starKnote) ? 1 : 0,
    );
    await _knotesProvider.addKnote(knoteModel);
    _titleController.clear();
    _contentController.clear();
    // Navigator.push(
    //   context,
    //   PageTransition(
    //     type: PageTransitionType.rippleRightUp,
    //     duration: Duration(milliseconds: 400),
    //     child: HomeScreen(),
    //   ),
    // );
    Navigator.pop(context);
  }
}
