import 'dart:async';

import 'package:projetsalon/catalogue/model/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class  DatabaseHelperCatalogue {
  static final  DatabaseHelperCatalogue _instance = new  DatabaseHelperCatalogue.internal();
  factory  DatabaseHelperCatalogue() => _instance;

  final String tableNote = 'catalogue';
  final String columnId = 'id';
  final String columnnomprestation = 'nomprestation';
  final String columncategorie = 'categorie';
  final String columnimage = 'image';

  static Database _db;

   DatabaseHelperCatalogue.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'catalogue.db');

//    await deleteDatabase(path); // just for testing

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableNote($columnId INTEGER PRIMARY KEY, $columnnomprestation TEXT, $columncategorie TEXT,$columnimage TEXT)');
  }

  Future<int> saveNote(CatalogueOff note) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableNote, note.toMap());
//    var result = await dbClient.rawInsert(
//        'INSERT INTO $tableNote ($columnnomprestation, $columncategorie ) VALUES (\'${note.nomprestation}\', \'${note.categorie}\')');
    print(result);
    return result;
  }

  Future<List> getAllNotes() async {
    var dbClient = await db;
    var result = await dbClient.query(tableNote, columns: [columnId, columnnomprestation, columncategorie,columnimage]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote');

    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM $tableNote'));
  }

  Future<CatalogueOff> getNote(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableNote,
        columns: [columnId, columnnomprestation, columncategorie,columnimage],
        where: '$columnId = ?',
        whereArgs: [id]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote WHERE $columnId = $id');

    if (result.length > 0) {
      return new CatalogueOff.fromMap(result.first);
    }

    return null;
  }

  Future<int> deleteNote(int id) async {
    var dbClient = await db;
    return await dbClient.delete(tableNote, where: '$columnId = ?', whereArgs: [id]);
//    return await dbClient.rawDelete('DELETE FROM $tableNote WHERE $columnId = $id');
  }

  Future<int> updateNote(CatalogueOff note) async {
    var dbClient = await db;
    return await dbClient.update(tableNote, note.toMap(), where: "$columnId = ?", whereArgs: [note.id]);
//    return await dbClient.rawUpdate(
//        'UPDATE $tableNote SET $columnnomprestation = \'${note.nomprestation}\', $columncategorie = \'${note.categorie}\' WHERE $columnId = ${note.id}');
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
