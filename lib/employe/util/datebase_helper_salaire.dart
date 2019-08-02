import 'dart:async';

import 'package:projetsalon/employe/model/note.dart';
import 'package:projetsalon/employe/model/salaires.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelperSalaire {
  static final DatabaseHelperSalaire _instance = new DatabaseHelperSalaire.internal();

  factory DatabaseHelperSalaire() => _instance;

  final String tableNote = 'salaire';
  final String columnId = 'id';
  final String columnidSalairee = 'idSalaire';
  final String columnmoispaye = 'moispaye';
  final String columnDatepaiement = 'datepaiement';
  final String columnsalaire = 'salaire';

  static Database _db;

  DatabaseHelperSalaire.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'Salaire.db');

//    await deleteDatabase(path); // just for testing

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableNote($columnId INTEGER PRIMARY KEY, $columnidSalairee TEXT, $columnmoispaye TEXT, $columnsalaire TEXT, $columnDatepaiement TEXT)');
  }

  Future<int> saveNote(Salaire note) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableNote, note.toMap());
//    var result = await dbClient.rawInsert(
//        'INSERT INTO $tableNote ($columnidSalairee, $columnmoispaye) VALUES (\'${note.idSalairee}\', \'${note.moispaye}\')');

    return result;
  }

  Future<List> getAllNotes() async {
    var dbClient = await db;
    var result = await dbClient.query(tableNote, columns: [columnId, columnidSalairee, columnmoispaye, columnsalaire, columnDatepaiement]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote');

    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM $tableNote'));
  }

  Future<Salaire> getNote(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableNote,
        columns: [columnId, columnidSalairee, columnmoispaye, columnsalaire, columnDatepaiement],
        where: '$columnId = ?',
        whereArgs: [id]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote WHERE $columnId = $id');

    if (result.length > 0) {
      return new Salaire.fromMap(result.first);
    }

    return null;
  }
  Future<List> getAllNotesFromOne(int id) async {
    var dbClient = await db;
    var result = await dbClient.query(tableNote, columns: [columnId, columnidSalairee, columnmoispaye, columnsalaire, columnDatepaiement]
        , where: '$columnId = ?',
        whereArgs: [id]);

//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote');

    return result.toList();
  }
  Future<int> deleteNote(int id) async {
    var dbClient = await db;
    return await dbClient.delete(tableNote, where: '$columnId = ?', whereArgs: [id]);
//    return await dbClient.rawDelete('DELETE FROM $tableNote WHERE $columnId = $id');
  }

  Future<int> updateNote(Salaire note) async {
    var dbClient = await db;
    return await dbClient.update(tableNote, note.toMap(), where: "$columnId = ?", whereArgs: [note.id]);
//    return await dbClient.rawUpdate(
//        'UPDATE $tableNote SET $columnidSalairee = \'${note.idSalairee}\', $columnmoispaye = \'${note.moispaye}\' WHERE $columnId = ${note.id}');
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
