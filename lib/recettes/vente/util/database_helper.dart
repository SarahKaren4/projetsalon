import 'dart:async';
import 'package:intl/intl.dart';
import 'package:projetsalon/recettes/vente/model/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DbHelperVente {
  static final DbHelperVente _instance = new DbHelperVente.internal();
  factory DbHelperVente() => _instance;
  final String tableNote = 'vente';
  final String columnId = 'id';
  final String ColumnNom = 'nom';
  final String ColumnQte = 'qte';
  final String columnPrixVente = 'prixvente';
  final String columnCoutTotal = 'couttotal';
  final String columndateachat = 'dateachat';
  final String columnstatut = 'statut';
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

  DbHelperVente.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'ventes.db');

//    await deleteDatabase(path); // just for testing

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableNote($columnId INTEGER PRIMARY KEY, $ColumnNom TEXT, $ColumnQte TEXT, $columnPrixVente TEXT, $columnCoutTotal TEXT, $columndateachat, $columnstatut)');
  }

  Future<int> saveNote(Vente note) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableNote, note.toMap());
//    var result = await dbClient.rawInsert(
//        'INSERT INTO $tableNote ($ColumnNom, $ColumnQte) VALUES (\'${note.title}\', \'${note.description}\')');

    return result;
  }

  Future<List> getAllNotes() async {
    var dbClient = await db;
    var result = await dbClient.query(tableNote, columns: [columnId, ColumnNom, ColumnQte,columnPrixVente, columnCoutTotal, columndateachat,columnstatut]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote');

    return result.toList();
  }

Future calculateTotal() async {
  var dbClient = await db;
  var result = await dbClient.rawQuery("SELECT SUM(CAST($columnCoutTotal as double)) as Total FROM $tableNote");
  print(result.toList());
    return result.toList();

}
  Future<int> getCount() async {
    var dbClient = await db;
    // ignore: unused_local_variable
    //int count = Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM table_name'));

    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM $tableNote'));
  }
  Future<int> getCountNow() async {
    var dbClient = await db;
    // ignore: unused_local_variable
    //int count = Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM table_name'));

    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM $tableNote where  $columndateachat = "$today" '));
  }

   Future getSumOfAll() async {
     var dbClient = await db;
  var result = await dbClient.rawQuery("SELECT SUM($columnCoutTotal) FROM $tableNote where $columndateachat = '$today' ");
  int value = result[0]["SUM($columnCoutTotal)"]; // value = 220
  return value;
  
  }
  Future<Vente> getNote(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableNote,
        columns: [columnId, ColumnNom, ColumnQte],
        where: '$columnId = ?',
        whereArgs: [id]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote WHERE $columnId = $id');
    if (result.length > 0) {
      return new Vente.fromMap(result.first);
    }
    return null;
  }
  Future<int> deleteNote(int id) async {
    var dbClient = await db;
    return await dbClient.delete(tableNote, where: '$columnId = ?', whereArgs: [id]);
//    return await dbClient.rawDelete('DELETE FROM $tableNote WHERE $columnId = $id');
  }

  Future<int> updateNote(Vente note) async {
    var dbClient = await db;
    return await dbClient.update(tableNote, note.toMap(), where: "$columnId = ?", whereArgs: [note.id]);
//    return await dbClient.rawUpdate(
//        'UPDATE $tableNote SET $ColumnNom = \'${note.title}\', $ColumnQte = \'${note.description}\' WHERE $columnId = ${note.id}');
  }
  Future<List> getAllNotesNow() async {
    var dbClient = await db;
    // var result = await dbClient.query(tableNote, columns: [columnId, ColumnNom, ColumnQte,columnPrixVente, columnCoutTotal, columndateachat] );
    var result = await dbClient.rawQuery('SELECT * FROM $tableNote where  $columndateachat = "$today" ');
    return result.toList();
  }
  Future<List> getAllNotesMoisActuel() async {

    var dbClient = await db;
    // var result = await dbClient.query(tableNote, columns: [columnId, ColumnNom, ColumnQte,columnPrixVente, columnCoutTotal, columndateajout] );
    var result = await dbClient.rawQuery('SELECT * FROM $tableNote where  strftime("%m","$columndateachat") = "0$moisActuel" ');
    return result.toList();
  }
  //nombre de vente en fontion des jours
   Future<int> geCountMoisActuelMoins1() async {
    var dbClient = await db;
    // ignore: unused_local_variable
    //int count = Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM table_name'));
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT * FROM $tableNote where strftime("%m",$columndateachat) = "0$moisActuelMoins1" '));
  }
   Future<List> getAllNotesMoisActueljMoins1() async {

    var dbClient = await db;
    // var result = await dbClient.query(tableNote, columns: [columnId, ColumnNom, ColumnQte,columnPrixVente, columnCoutTotal, columndateachat] );
    var result = await dbClient.rawQuery('SELECT * FROM $tableNote where strftime("%m",$columndateachat) = "0$moisActuelMoins1" ');
    return result.toList();
  }
    Future<List> getAllNotesMoisActuelMoins2() async {

    var dbClient = await db;
    // var result = await dbClient.query(tableNote, columns: [columnId, ColumnNom, ColumnQte,columnPrixVente, columnCoutTotal, columndateachat] );
    var result = await dbClient.rawQuery('SELECT * FROM $tableNote where  strftime("%m",$columndateachat) = "0$moisActuelMoins2" ');
    return result.toList();
  }  Future<List> getAllNotesMoisActuelMoins3() async {

    var dbClient = await db;
    // var result = await dbClient.query(tableNote, columns: [columnId, ColumnNom, ColumnQte,columnPrixVente, columnCoutTotal, columndateachat] );
    var result = await dbClient.rawQuery('SELECT * FROM $tableNote where  strftime("%m",$columndateachat) = "0$moisActuelMoins3" ');
    return result.toList();
  }
    Future<List> getAllNotesMoisActuelMoins4() async {

    var dbClient = await db;
    // var result = await dbClient.query(tableNote, columns: [columnId, ColumnNom, ColumnQte,columnPrixVente, columnCoutTotal, columndateachat] );
    var result = await dbClient.rawQuery('SELECT * FROM $tableNote where  strftime("%m",$columndateachat) = "0$moisActuelMoins4" ');
    return result.toList();
  }  Future<List> getAllNotesMoisActueljMoins5() async {

    var dbClient = await db;
    // var result = await dbClient.query(tableNote, columns: [columnId, ColumnNom, ColumnQte,columnPrixVente, columnCoutTotal, columndateachat] );
    var result = await dbClient.rawQuery('SELECT * FROM $tableNote where  strftime("%m",$columndateachat) = "$moisActuelMoins5" ');
    return result.toList();
  }
   
  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
