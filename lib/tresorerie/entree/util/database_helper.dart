import 'dart:async';
import 'package:intl/intl.dart';
import 'package:projetsalon/tresorerie/entree/model/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelperEntree {
  static final DatabaseHelperEntree _instance = new DatabaseHelperEntree.internal();

  factory DatabaseHelperEntree() => _instance;
  final String tableNote = 'entree';
  final String columnId = 'id';
  final String columnusage = 'usage';
  final String columncout = 'cout';
  final String columndateajout = 'dateajout';
  final String today = DateFormat("dd-MM-yyyy").format(DateTime.now()).toString();
  final jourjmoins1 = (DateTime.now().subtract(Duration(days: 1))).toString();
  final jourjmoins2 = DateTime.now().subtract(Duration(days: 2));
  final jourjmoins3 = DateTime.now().subtract(Duration(days: 3));
  final jourjmoins4 = DateTime.now().subtract(Duration(days: 4));
  final jourjmoins5= DateTime.now().subtract(Duration(days: 5));
  final jourjmoins6 = DateTime.now().subtract(Duration(days: 6));
  final moisActuel = (DateTime.now().month);
  var moisActuelMoins1 ='${DateTime.now().month-1}';
  var moisActuelMoins2 ='${DateTime.now().month-2}';
  var moisActuelMoins3 ='${DateTime.now().month-3}';
  var moisActuelMoins4 ='${DateTime.now().month-4}';
  var moisActuelMoins5 ='${DateTime.now().month-5}';


  static Database _db;

  DatabaseHelperEntree.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'entree.db');

//    await deleteDatabase(path); // just for testing

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }
  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableNote($columnId INTEGER PRIMARY KEY, $columnusage TEXT, $columncout TEXT, $columndateajout TEXT)');
  }
  Future<int> saveNote(Entree note) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableNote, note.toMap());
//    var result = await dbClient.rawInsert(
//        'INSERT INTO $tableNote ($columnusage, $columncout) VALUES (\'${note.usage}\', \'${note.cout}\')');
    return result;
  }

  Future<List> getAllNotes() async {
    var dbClient = await db;
    var result = await dbClient.query(tableNote, columns: [columnId, columnusage, columncout, columndateajout]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote');

    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM $tableNote'));
  }

  Future<Entree> getNote(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableNote,
        columns: [columnId, columnusage, columncout, columndateajout],
        where: '$columnId = ?',
        whereArgs: [id]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote WHERE $columnId = $id');

    if (result.length > 0) {
      return new Entree.fromMap(result.first);
    }

    return null;
  }

  Future<int> deleteNote(int id) async {
    var dbClient = await db;
    return await dbClient.delete(tableNote, where: '$columnId = ?', whereArgs: [id]);
//    return await dbClient.rawDelete('DELETE FROM $tableNote WHERE $columnId = $id');
  }

  Future<int> updateNote(Entree note) async {
    var dbClient = await db;
    return await dbClient.update(tableNote, note.toMap(), where: "$columnId = ?", whereArgs: [note.id]);
//    return await dbClient.rawUpdate(
//        'UPDATE $tableNote SET $columnusage = \'${note.usage}\', $columncout = \'${note.cout}\' WHERE $columnId = ${note.id}');
  }
  Future<List> getAllNotesNow() async {

    var dbClient = await db;
    // var result = await dbClient.query(tableNote, columns: [columnId, ColumnNom, ColumnQte,columnPrixVente, columnCoutTotal, columndateajout] );
    var result = await dbClient.rawQuery('SELECT * FROM $tableNote where  $columndateajout = "$today" ');
    return result.toList();
  }
    //nombre de vente en fontion des jours
     Future<int> getCountMoisActuel() async {
    var dbClient = await db;
    // ignore: unused_local_variable
    //int count = Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM table_name'));
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM $tableNote where strftime("%m",$columndateajout)  = "0$moisActuel" '));
  }
   Future<int> geCountMoisActuelMoins1() async {
    var dbClient = await db;
    // ignore: unused_local_variable
    //int count = Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM table_name'));
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM $tableNote where strftime("%m",$columndateajout)  = "$moisActuelMoins1" '));
  }
   Future<List> getAllNotesMoisActuel() async {

    var dbClient = await db;
    // var result = await dbClient.query(tableNote, columns: [columnId, ColumnNom, ColumnQte,columnPrixVente, columnCoutTotal, columndateajout] );
    var result = await dbClient.rawQuery('SELECT * FROM $tableNote where  strftime("%m","$columndateajout") = "0$moisActuel" ');
    return result.toList();
  }
   Future<List> getAllNotesMoisActueljMoins1() async {
    var dbClient = await db;
    // var result = await dbClient.query(tableNote, columns: [columnId, ColumnNom, ColumnQte,columnPrixVente, columnCoutTotal, columndateajout] );
    var result = await dbClient.rawQuery('SELECT * FROM $tableNote where  strftime("%m",$columndateajout) = "0$moisActuelMoins1" ');
    print(result);
    return result.toList();
  }
    Future<List> getAllNotesMoisActueljMoins2() async {
    var dbClient = await db;
    // var result = await dbClient.query(tableNote, columns: [columnId, ColumnNom, ColumnQte,columnPrixVente, columnCoutTotal, columndateajout] );
    var result = await dbClient.rawQuery('SELECT * FROM $tableNote where  strftime("%m",$columndateajout) = "0$moisActuelMoins2" ');
    return result.toList();
  }  Future<List> getAllNotesMoisActueljMoins3() async {
    var dbClient = await db;
    // var result = await dbClient.query(tableNote, columns: [columnId, ColumnNom, ColumnQte,columnPrixVente, columnCoutTotal, columndateajout] );
    var result = await dbClient.rawQuery('SELECT * FROM $tableNote where  strftime("%m",$columndateajout) = "0$moisActuelMoins3" ');
    return result.toList();
  }
    Future<List> getAllNotesMoisActueljMoins4() async {

    var dbClient = await db;
    // var result = await dbClient.query(tableNote, columns: [columnId, ColumnNom, ColumnQte,columnPrixVente, columnCoutTotal, columndateajout] );
    var result = await dbClient.rawQuery('SELECT * FROM $tableNote where  strftime("%m",$columndateajout) = "$moisActuelMoins4" ');
    return result.toList();
  }  Future<List> getAllNotesMoisActueljMoins5() async {

    var dbClient = await db;
    // var result = await dbClient.query(tableNote, columns: [columnId, ColumnNom, ColumnQte,columnPrixVente, columnCoutTotal, columndateajout] );
    var result = await dbClient.rawQuery('SELECT * FROM $tableNote where  strftime("%m",$columndateajout) = "$moisActuelMoins5" ');
    return result.toList();
  }
   //sum of price records
   Future getSumOfAll() async {
     var dbClient = await db;
  var result = await dbClient.rawQuery("SELECT SUM($columncout) FROM $tableNote");
  int value = result[0]["SUM($columncout)"]; // value = 220
  return value;
  
  }
  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
