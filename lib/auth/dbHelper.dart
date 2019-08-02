import 'package:projetsalon/auth/proprio.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io ;
import 'dart:async';
class DbHelper{
  static final DbHelper _instance = new DbHelper.internal();
  DbHelper.internal();
  factory DbHelper() => _instance;
  static Database _db;
  Future <Database> get db async {
   if(_db!=null)return _db;
   _db = await setDB();
   return _db;
  }
setDB()async{
    io.Directory directory = await getApplicationDocumentsDirectory();
  String path = join(directory.path,"salons");
  var dB = await openDatabase(path, version:1, onCreate: _onCreate);
  return dB;
}
void _onCreate(Database db, int version) async{
    await db.execute("CREATE TABLE salons(id_boutique INTEGER PRIMARY KEY, nom TEXT, prenom TEXT, nomsalon TEXT, localisation TEXT, numero TEXT, mdp TEXT, lon TEXT, lat TEXT,dateajout TEXT, img TEXT)");
print('DB CREATED');
  }
  Future<int> saveProprio(Proprio proprio) async{
    var dbClient = await db;
   int res = await dbClient.insert("salons", proprio.toMap());
print('data inserted');
    return res;
  }
Future<List<Proprio>> getProprio() async{
var dbClient = await db;
List<Map> list = await dbClient.rawQuery("SELECT * FROM salons");
List<Proprio> propriodata = new List();
for(int i =0; i<list.length; i++){
  var note = new Proprio(list[i]['nom'], list[i]['prenom'],list[i]['nomsalon'],list[i]['localisation'],list[i]['numero'], list[i]['mdp'], list[i]['lon'], list[i]['lat'], list[i]['dateajout'],list[i]['img'] );
note.setProprioId(list[i]['id_boutique']);
propriodata.add(note);
}
return propriodata;
}

Future<bool> updateProprio(Proprio proprio) async{
  var dbClient = await db;
int res =await dbClient.update("salons", proprio.toMap(), where: "id_boutique=?",whereArgs: <int>[proprio.id_boutique]);
print('data updated');
return res> 0 ? true:false;
}
}
