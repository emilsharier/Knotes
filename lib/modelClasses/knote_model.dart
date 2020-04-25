import 'package:knotes/components/repositories/database_creator.dart';

class KnoteModel {
  String id, title, content;
  int isStarred;

  KnoteModel({this.id, this.title, this.content, this.isStarred});

  KnoteModel.fromJSON(Map<String, dynamic> json) {
    this.id = json[DatabaseCreator.id];
    this.title = json[DatabaseCreator.title];
    this.content = json[DatabaseCreator.content];
    this.isStarred = json[DatabaseCreator.isStarred];
  }

  toJSON() => {
        'id': this.id,
        'title': this.title,
        'content': this.content,
        'isStarred': this.isStarred,
      };
}
