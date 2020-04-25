import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Database db;

class DatabaseCreator {
  static const temp_table = "temp";
  static const knotes_table = "knotes";
  static const id = 'id';
  static const title = 'title';
  static const content = 'content';
  static const isStarred = 'isStarred';

  Future<void> createKnotesTable(Database db) async {
    final todoSql = '''CREATE TABLE IF NOT EXISTS $knotes_table (
      $id TEXT PRIMARY KEY,
      $title TEXT,
      $content TEXT,
      $isStarred INTEGER
    )''';

    final tempSql = '''CREATE TABLE IF NOT EXISTS $temp_table (
      $title TEXT,
      $content TEXT
    )''';

    Batch batch = db.batch();

    batch.execute(todoSql);
    batch.execute(tempSql);

    await batch.commit();
  }

  Future<String> getDatabasePath(String name) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, name);

    return path;
  }

  Future<void> initDatabase() async {
    final path = await getDatabasePath('knotes_db');
    db = await openDatabase(path, version: 1, onCreate: onCreate);
    print(db);
  }

  Future<void> onCreate(Database db, int version) async {
    await createKnotesTable(db);
  }
}
