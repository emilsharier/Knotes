import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:knotes/components/repositories/database_creator.dart';
import 'package:knotes/modelClasses/LocalDBKnotesModel.dart';
import 'package:knotes/modelClasses/knote_model.dart';
import 'package:sqflite/sqlite_api.dart';

class LocalDBKnotesProvider with ChangeNotifier {
  LocalKnotesStatus _knotesStatus = LocalKnotesStatus.Unintialised;

  List<KnoteModel> _knotes = List<KnoteModel>();
  KnoteModel _singleKnote = KnoteModel();

  KnoteModel _tempKnote = KnoteModel();

  Firestore databaseReference = Firestore.instance;

  LocalKnotesStatus get knoteStatus => _knotesStatus;
  
  List<KnoteModel> get knotes {
    return [..._knotes];
  }

  KnoteModel get tempKnote => _tempKnote;

  KnoteModel get singleKnote => _singleKnote;

  Future<void> getAllKnotes() async {
    _knotesStatus = LocalKnotesStatus.Initialising;
    notifyListeners();
    final sql = '''select * from ${DatabaseCreator.knotes_table}''';

    final data = await db.rawQuery(sql);

    List<KnoteModel> knotes = List();
    if (data.length == 0) {
      _knotesStatus = LocalKnotesStatus.NoKnotesAvailable;
      notifyListeners();
    } else {
      _knotesStatus = LocalKnotesStatus.KnotesAvailable;
      notifyListeners();

      KnoteModel knote;

      for (final node in data) {
        knote = KnoteModel.fromJSON(node);
        knotes.add(knote);
      }
      _knotes = knotes;
    }
    notifyListeners();
  }

  Future<KnoteModel> getKnotesFromCloud() async {}

  Future<void> getKnote(String id) async {
    final sql =
        '''select * from ${DatabaseCreator.knotes_table} where ${DatabaseCreator.id} == $id''';

    final data = await db.rawQuery(sql);

    final knote = KnoteModel.fromJSON(data[0]);

    _singleKnote = knote;
    notifyListeners();
  }

  Future<void> addTempData(KnoteModel knoteModel) async {
    final sql = '''insert into ${DatabaseCreator.temp_table} (
      ${DatabaseCreator.title},
      ${DatabaseCreator.content}
    )
    values(
      ?,?
    )''';

    List<dynamic> params = [knoteModel.title, knoteModel.content];

    final sql2 = '''DELETE FROM ${DatabaseCreator.temp_table}''';

    Batch batch = db.batch();
    batch.execute(sql2);
    batch.execute(sql, params);

    await batch.commit();

    _tempKnote = knoteModel;
    notifyListeners();
  }

  Future<void> getTempData() async {
    final sql = '''SELECT * FROM ${DatabaseCreator.temp_table}''';

    final data = await db.rawQuery(sql);
    KnoteModel knoteModel;
    if (data.isEmpty) {
      knoteModel = KnoteModel(
        id: "",
        title: "",
        content: "",
      );
      return knoteModel;
    }
    knoteModel = KnoteModel.fromJSON(data[0]);

    print(knoteModel.title + " " + knoteModel.content);

    return knoteModel;
  }

  Future<void> addKnote(KnoteModel knoteModel) async {
    final sql = '''insert into ${DatabaseCreator.knotes_table} (
      '${DatabaseCreator.id}',
      '${DatabaseCreator.title}',
      '${DatabaseCreator.content}'
    ) 
    values(?,?,?)''';
    List<dynamic> params = [
      knoteModel.id,
      knoteModel.title,
      knoteModel.content
    ];
    final sql2 = '''DELETE FROM ${DatabaseCreator.temp_table}''';

    Batch batch = db.batch();
    batch.execute(sql, params);
    batch.execute(sql2);

    await batch.commit();

    _tempKnote = knoteModel;
    notifyListeners();
  }

  Future<void> updateKnote(KnoteModel knoteModel) async {
    final sql =
        '''update ${DatabaseCreator.knotes_table} set ${DatabaseCreator.title} = ? and ${DatabaseCreator.content} = ? id = ?''';

    List<dynamic> params = [
      knoteModel.title,
      knoteModel.content,
      knoteModel.id
    ];

    await db.rawUpdate(sql, params);
  }

  Future<void> updateTitleKnote(String id, String value) async {
    final sql =
        '''update ${DatabaseCreator.knotes_table} set ${DatabaseCreator.title} = ? where id = ?''';

    List<dynamic> params = [value, id];

    await db.rawUpdate(sql, params);

    print("Success!");
  }

  Future<void> updateContentKnote(String id, String value) async {
    final sql =
        '''update ${DatabaseCreator.knotes_table} set ${DatabaseCreator.content} = ? where id = ?''';

    List<dynamic> params = [value, id];

    await db.rawUpdate(sql, params);
    print("Success!");
  }

  Future<void> deleteKnote(List<String> id) async {
    String sql = "";
    for (String index in id) {
      sql =
          '''delete from ${DatabaseCreator.knotes_table} where ${DatabaseCreator.id} = ?''';
      List<dynamic> params = [index];

      await db.rawDelete(sql, params).then((t) => print("Deleted $index"));
    }
    getAllKnotes();
  }
}
