import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:knotes/components/providers/LocalDBKnotesProvider.dart';
import 'package:knotes/components/repositories/RepositoryServiceKnote.dart';
import 'package:knotes/components/repositories/theme_repository/textField_custom_theme.dart'
    as ct;
import 'package:knotes/modelClasses/knote_model.dart';
import 'package:provider/provider.dart';

class SingleKnote extends StatefulWidget {
  KnoteModel knoteModel;

  SingleKnote(this.knoteModel);

  @override
  _SingleKnoteState createState() => _SingleKnoteState();
}

class _SingleKnoteState extends State<SingleKnote> {
  TextEditingController _titleController = TextEditingController();

  TextEditingController _contentController = TextEditingController();

  bool _displayFloatingButton;

  GlobalKey<FormState> _formKey;

  LocalDBKnotesProvider provider;

  KnoteModel model;

  bool _starKnote;

  @override
  void initState() {
    super.initState();
    _displayFloatingButton = false;
    _titleController.text = widget.knoteModel.title;
    _contentController.text = widget.knoteModel.content;

    _starKnote = (widget.knoteModel.isStarred == 1) ? true : false;

    model = widget.knoteModel;

    _formKey = GlobalKey<FormState>();

    DateTime now =
        DateTime.fromMillisecondsSinceEpoch(int.parse(widget.knoteModel.id));
    print(now);

    //print("Tapping on ${widget.id}!");
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<LocalDBKnotesProvider>(context);
    return Scaffold(
      // backgroundColor: Color.fromRGBO(230, 230, 230, 1.0),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: (_starKnote)
                ? Icon(MaterialCommunityIcons.pin)
                : Icon(MaterialCommunityIcons.pin_outline),
            onPressed: () {
              setState(() {
                _starKnote = !_starKnote;
                provider.toggleKnoteStar(widget.knoteModel);
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          // margin: MediaQuery.of(context).padding,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                TextFormField(
                  controller: _titleController,
                  onSaved: (value) => model.title = value,
                  cursorWidth: 3.0,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(15.0),
                    hintText: 'Title',
                    hintStyle: ct.titleHint_singleKnote,
                    focusedBorder: InputBorder.none,
                  ),
                  style: (MediaQuery.of(context).platformBrightness ==
                          Brightness.dark)
                      ? ct.title_singleKnote_Dark
                      : ct.title_singleKnote,
                  maxLines: null,
                  onChanged: (value) => _displayFloatingButtonWidget(),
                ),
                TextFormField(
                  controller: _contentController,
                  onSaved: (value) => model.content = value,
                  cursorColor: Colors.black,
                  cursorWidth: 2.0,
                  autofocus: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15.0),
                    border: InputBorder.none,
                    hintText: 'Knotes',
                    hintStyle: ct.contentHint_singleKnote,
                    focusedBorder: InputBorder.none,
                  ),
                  style: (MediaQuery.of(context).platformBrightness ==
                          Brightness.dark)
                      ? ct.content_singleKnote_Dark
                      : ct.content_singleKnote,
                  maxLines: null,
                  onChanged: (value) => _displayFloatingButtonWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _displayFloatingButton
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FloatingActionButton(
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 20.0,
                  ),
                  onPressed: () {
                    _update();
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                //sFloatingActionButton(onPressed: null),
              ],
            )
          : null,
    );
  }

  _displayFloatingButtonWidget() {
    setState(() {
      _displayFloatingButton = true;
    });
  }

  _update() async {
    _formKey.currentState.save();
    await provider.updateKnote(model).then((value) {
      print(value);
      Navigator.pop(context);
    });
  }
}
