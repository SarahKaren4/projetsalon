import 'dart:async';

import 'package:projetsalon/employe/model/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelperEmployee {
  static final DatabaseHelperEmployee _instance = new DatabaseHelperEmployee.internal();

  factory DatabaseHelperEmployee() => _instance;

  final String tableNote = 'employee';
  final String columnId = 'id';
  final String columnnomemployee = 'nomemploye';
  final String columnfonction = 'fonction';
  final String columnsalaire = 'salaire';
  final String columnStatut = 'statut';
  final String columndateajout = 'dateajout';

  static Database _db;

  DatabaseHelperEmployee.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'employee.db');

//    await deleteDatabase(path); // just for testing

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableNote($columnId INTEGER PRIMARY KEY, $columnnomemployee TEXT, $columnfonction TEXT, $columnsalaire TEXT, $columndateajout TEXT, $columnStatut TEXT)');
  }

  Future<int> saveNote(Employee note) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableNote, note.toMap());
//    var result = await dbClient.rawInsert(
//        'INSERT INTO $tableNote ($columnnomemployee, $columnfonction) VALUES (\'${note.nomemployee}\', \'${note.fonction}\')');

    return result;
  }

  Future<List> getAllNotes() async {
    var dbClient = await db;
    var result = await dbClient.query(tableNote, columns: [columnId, columnnomemployee, columnfonction, columnsalaire, columndateajout,columnStatut]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote');

    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM $tableNote'));
  }

  Future<Employee> getNote(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableNote,
        columns: [columnId, columnnomemployee, columnfonction, columnsalaire, columndateajout,columnStatut],
        where: '$columnId = ?',
        whereArgs: [id]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote WHERE $columnId = $id');

    if (result.length > 0) {
      return new Employee.fromMap(result.first);
    }

    return null;
  }

  Future<int> deleteNote(int id) async {
    var dbClient = await db;
    return await dbClient.delete(tableNote, where: '$columnId = ?', whereArgs: [id]);
//    return await dbClient.rawDelete('DELETE FROM $tableNote WHERE $columnId = $id');
  }

  Future<int> updateNote(Employee note) async {
    var dbClient = await db;
    return await dbClient.update(tableNote, note.toMap(), where: "$columnId = ?", whereArgs: [note.id]);
//    return await dbClient.rawUpdate(
//        'UPDATE $tableNote SET $columnnomemployee = \'${note.nomemployee}\', $columnfonction = \'${note.fonction}\' WHERE $columnId = ${note.id}');
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
