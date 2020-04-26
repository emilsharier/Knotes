import 'package:flutter/foundation.dart';
import 'package:knotes/components/repositories/RepositoryServiceKnote.dart';
import 'package:knotes/components/repositories/database_creator.dart';
import 'package:knotes/modelClasses/LocalDBKnotesModel.dart';
import 'package:knotes/modelClasses/knote_model.dart';

class LocalDBKnotesProvider with ChangeNotifier {
  List<KnoteModel> _knotes = [];

  List<KnoteModel> _starredKnotes = [];
  List<KnoteModel> _nonStarredKnotes = [];
  List<String> _selectedKnotes = [];

  bool _selectionMode = false;

  LocalKnotesStatus _knotesStatus = LocalKnotesStatus.Unintialised;

  LocalDBKnotesProvider() {
    initDB();
  }

  List<KnoteModel> get knotes => _knotes;
  List<KnoteModel> get nonStarredKnotes => _nonStarredKnotes;
  List<KnoteModel> get starredKontes => _starredKnotes;
  List<String> get selectedKnotes => _selectedKnotes;

  bool get selectionMode => _selectionMode;

  LocalKnotesStatus get knoteStatus => _knotesStatus;

  initDB() async {
    await DatabaseCreator().initDatabase();
    init();
  }

  _addKnoteToList(KnoteModel model) {
    if (model.isStarred == 1)
      _starredKnotes.add(model);
    else
      _nonStarredKnotes.add(model);
    notifyListeners();
  }

  _updateKnote(KnoteModel model) {
    int index;
    if (model.isStarred == 1)
      index = _starredKnotes
          .indexWhere((value) => (value.id == model.id) ? true : false);
    else
      index = _nonStarredKnotes
          .indexWhere((value) => (value.id == model.id) ? true : false);
    //Have to write code for updating Knote
    if (_knotes.isNotEmpty) _knotes[index] = model;
  }

  _toggleStar(KnoteModel model) {
    if (model.isStarred == 0) {
      _nonStarredKnotes.removeWhere((value) {
        if (value.id == model.id)
          return true;
        else
          return false;
      });
      _starredKnotes.add(model);
    } else {
      _starredKnotes.removeWhere((value) {
        if (value.id == model.id)
          return true;
        else
          return false;
      });
      _nonStarredKnotes.add(model);
    }
    print(model.title + ' ' + model.isStarred.toString());
    notifyListeners();
    // print('Starred Knote : ' + _starredKnotes[0].title);
  }

  addToSelectedKnotes({String id}) {
    _selectedKnotes.add(id);
    changeSelection(enable: true);
  }

  removeFromSelectedKnotes({String id}) {
    _selectedKnotes.remove(id);
  }

  clearSelectedKnotes() {
    _selectedKnotes.clear();
    changeSelection(enable: false);
    notifyListeners();
  }

  changeSelection({bool enable}) {
    _selectionMode = enable;
    if (!_selectionMode) _selectedKnotes.clear();
    notifyListeners();
  }

  Future<void> init() async {
    _knotesStatus = LocalKnotesStatus.Refreshing;
    notifyListeners();
    _knotes.clear();
    _starredKnotes.clear();
    _nonStarredKnotes.clear();
    _knotes = await RepositoryServiceKnote.getAllKnotes();
    if (_knotes.isEmpty)
      _knotesStatus = LocalKnotesStatus.NoKnotesAvailable;
    else {
      _knotes.forEach((model) {
        if (model.isStarred == 1)
          _starredKnotes.add(model);
        else
          _nonStarredKnotes.add(model);
      });
      _knotesStatus = LocalKnotesStatus.KnotesAvailable;
    }
    notifyListeners();
  }

  refreshStatus() async {
    _knotesStatus = LocalKnotesStatus.Refreshing;
    notifyListeners();
    if (_knotes.isEmpty)
      _knotesStatus = LocalKnotesStatus.NoKnotesAvailable;
    else
      _knotesStatus = LocalKnotesStatus.KnotesAvailable;
    notifyListeners();
  }

  addKnote(KnoteModel model) async {
    await RepositoryServiceKnote.addKnote(model);
    // _addKnoteToList(model);
    // print(_knotes[0].toJSON());
    // notifyListeners();
    // refreshStatus();
    init();
  }

  Future<int> toggleKnoteStar(KnoteModel model) async {
    int val = await RepositoryServiceKnote.starKnote(model);
    // _toggleStar(model);
    init();
    // refreshStatus();
    // notifyListeners();
    return val;
  }

  Future<int> updateKnote(KnoteModel model) async {
    int val = await RepositoryServiceKnote.updateKnote(model);
    _updateKnote(model);
    print('The value is ${val.toString()}');
    notifyListeners();
    // init();
    return val;
  }

  deleteKnote(List<String> ids) async {
    int val = await RepositoryServiceKnote.deleteKnote(ids);
    print('Deletion : ${val.toString()}');
    init();
  }

  Future<List<KnoteModel>> searchForKnotes(String keywords) async {
    List<KnoteModel> searchResults = [];

    for (KnoteModel model in _knotes) {
      if (model.title.toLowerCase().contains('${keywords.toLowerCase()}') ||
          model.content.toLowerCase().contains('${keywords.toLowerCase()}')) {
        searchResults.add(model);
      }
    }
    return searchResults;
  }
}
