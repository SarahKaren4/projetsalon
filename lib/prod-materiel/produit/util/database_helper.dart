import 'dart:async';

import 'package:intl/intl.dart';
import 'package:projetsalon/prod-materiel/produit/model/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelperProd {
  static final DbHelperProd _instance = new DbHelperProd.internal();

  factory DbHelperProd() => _instance;

  final String tableNote = 'produit';
  final String columnId = 'id';
  final String ColumnNom = 'nom';
  final String ColumnQte = 'qte';
  final String columnDetails = 'details';
  final String columnPrixAchat = 'prixachat';
  final String columnPrixVente = 'prixvente';
  final String columndateajoutprod = 'dateajoutprod';
  final String columnstatut = 'statut';
  final String columnnomfournisseur = 'nomfournisseur';

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

  DbHelperProd.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'produits.db');

//    await deleteDatabase(path); // just for testing

    var db = await openDatabase(path, version: 2, onCreate: _onCreate);
    return db;
  }
  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableNote($columnId INTEGER PRIMARY KEY, $ColumnNom TEXT, $ColumnQte TEXT, $columnDetails TEXT, $columnPrixAchat TEXT, $columnPrixVente TEXT, $columndateajoutprod, $columnstatut TEXT, $columnnomfournisseur TEXT)');
  }
  Future<int> saveNote(Produit note) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableNote, note.toMap());
//    var result = await dbClient.rawInsert(
//        'INSERT INTO $tableNote ($ColumnNom, $ColumnQte) VALUES (\'${note.title}\', \'${note.description}\')');
    return result;
  }
  Future<List> getAllNotes() async {
    var dbClient = await db;
    var result = await dbClient.query(tableNote, columns: [columnId, ColumnNom, ColumnQte, columnPrixAchat,columnPrixVente, columndateajoutprod,columnstatut, columnnomfournisseur]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote');
    return result.toList();
  }
  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM $tableNote'));
  }

  Future<Produit> getNote(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableNote,
        columns: [columnId, ColumnNom, ColumnQte],
        where: '$columnId = ?',
        whereArgs: [id]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote WHERE $columnId = $id');
    if (result.length > 0) {
      return new Produit.fromMap(result.first);
    }
    return null;
  }
  Future<int> deleteNote(int id) async {
    var dbClient = await db;
    return await dbClient.delete(tableNote, where: '$columnId = ?', whereArgs: [id]);
//    return await dbClient.rawDelete('DELETE FROM $tableNote WHERE $columnId = $id');
  }
  Future<int> updateNote(Produit note) async {
    var dbClient = await db;

    return await dbClient.update(tableNote, note.toMap(), where: "$columnId = ?", whereArgs: [note.id]);

//    return await dbClient.rawUpdate(
//        'UPDATE $tableNote SET $ColumnNom = \'${note.title}\', $ColumnQte = \'${note.description}\' WHERE $columnId = ${note.id}');
  }
Future<List> getAllNotesMoisActuel() async {

    var dbClient = await db;
    // var result = await dbClient.query(tableNote, columns: [columnId, ColumnNom, ColumnQte,columnPrixVente, columnCoutTotal, columndateajout] );
    var result = await dbClient.rawQuery('SELECT * FROM $tableNote where  strftime("%m","$columndateajoutprod") = "0$moisActuel" ');
    return result.toList();
  }
  //nombre de vente en fontion des jours

  Future<List> getAllNotesMoisActueljMoins1() async {
    var dbClient = await db;
    // var result = await dbClient.query(tableNote, columns: [columnId, ColumnNom, ColumnQte,columnPrixVente, columnCoutTotal, columndateajoutprod] );
    var result = await dbClient.rawQuery('SELECT * FROM $tableNote where strftime("%m",$columndateajoutprod) = "0$moisActuelMoins1" ');
    return result.toList();
  }
  Future<List> getAllNotesMoisActuelMoins2() async {

    var dbClient = await db;
    // var result = await dbClient.query(tableNote, columns: [columnId, ColumnNom, ColumnQte,columnPrixVente, columnCoutTotal, columndateajoutprod] );
    var result = await dbClient.rawQuery('SELECT * FROM $tableNote where  strftime("%m",$columndateajoutprod) = "0$moisActuelMoins2" ');
    return result.toList();
  }  Future<List> getAllNotesMoisActuelMoins3() async {

    var dbClient = await db;
    // var result = await dbClient.query(tableNote, columns: [columnId, ColumnNom, ColumnQte,columnPrixVente, columnCoutTotal, columndateajoutprod] );
    var result = await dbClient.rawQuery('SELECT * FROM $tableNote where  strftime("%m",$columndateajoutprod) = "0$moisActuelMoins3" ');
    return result.toList();
  }
  Future<List> getAllNotesMoisActuelMoins4() async {

    var dbClient = await db;
    // var result = await dbClient.query(tableNote, columns: [columnId, ColumnNom, ColumnQte,columnPrixVente, columnCoutTotal, columndateajoutprod] );
    var result = await dbClient.rawQuery('SELECT * FROM $tableNote where  strftime("%m",$columndateajoutprod) = "0$moisActuelMoins4" ');
    return result.toList();
  }  Future<List> getAllNotesMoisActueljMoins5() async {

    var dbClient = await db;
    // var result = await dbClient.query(tableNote, columns: [columnId, ColumnNom, ColumnQte,columnPrixVente, columnCoutTotal, columndateajoutprod] );
    var result = await dbClient.rawQuery('SELECT * FROM $tableNote where  strftime("%m",$columndateajoutprod) = "$moisActuelMoins5" ');
    return result.toList();
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
