import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:projetsalon/auths/models/user.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE User(id INTEGER PRIMARY KEY, username TEXT, password TEXT, nomsalon TEXT, localisation TEXT, numero TEXT, lon TEXT, lat TEXT, img TEXT)");
    print("Table is created");
  }

//insertion
  Future<int> saveUser(User user) async {
    var dbClient = await db;

    int res = await dbClient.insert("User", user.toMap());
    print(res);
    print('succes');
    return res;
  }
  Future<User> checkUser( User user) async{
    var dbClient = await db;
    List<Map<String,dynamic>> res = await dbClient.query("User",where:'"numero" = ? and "password"=?',whereArgs: [user.numero,user.password]);
    print(res);
    for (var row in res)
    {
      return new Future<User>.value(User.map(row));
    }
    return new Future<User>.error("Unable to find User");
  }
  Future<int> deleteUsers() async {
    var dbClient  = await db;
   // return await dbClient.delete(tableProprio, where: '$columnId = ?', whereArgs: [id]);
 return await dbClient.delete('DELETE FROM User ');
  }

  //deletion
  Future<int> deleteUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.delete("User");
    return res;
  }
 


/*
  Future<List<User>> getAllUser() async {
    var dbClient = await db;
    List<User> users=[];
    List<Map<String,dynamic>> res = await dbClient.query("User");
    for(var row in res)
    {
      //print(row['id']);
      users.add(User.map(row));
    }
    return new Future<List<User>>.value(users);
  }
*/
  Future<List> getAllUser() async {
    var dbClient = await db;
    //var result = await dbClient.query("salons", columns: [id , columnTitle, columnDescription]);
    var result = await dbClient.rawQuery('SELECT * FROM user');

    return result.toList();
  }
 // ignore: missing_return
 Future<List> getUser(int id) async {
   var dbClient = await db;

   List<Map<String,dynamic>> 
   res = await dbClient.query("User",where:'"id" = ?',whereArgs: [id]);
   for(var row in res)
   {
     print(row['id']);
     return res.toList();

   }
  }

 Future deleteAll() async {
   var dbClient = await db;
    dbClient.delete("User");
    print('db empty');
  }


  Future<int> deleteSingleUser(int id) async {
    var dbClient  = await db;
    Future<int> res = dbClient.delete("User",where:'"id" = ?',whereArgs: [id]);
    return res;
  }
}

  