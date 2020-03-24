import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:knotes/components/repositories/RepositoryServiceKnote.dart';
import 'package:knotes/modelClasses/knote_model.dart';

class SelectionProvider with ChangeNotifier {
  Stream<List<KnoteModel>> _knoteStream;

  SelectionProvider () {
    _knoteStream = RepositoryServiceKnote.getAllKnotes().asStream();
  }

  get knoteStream => _knoteStream = RepositoryServiceKnote.getAllKnotes().asStream();

  void refresh () {
    _knoteStream = RepositoryServiceKnote.getAllKnotes().asStream();
    notifyListeners();
  }
}
