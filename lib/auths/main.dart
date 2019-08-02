import 'package:flutter/material.dart';
import 'package:projetsalon/auths/pages/home_page.dart';
import 'package:projetsalon/auths/pages/login/login_page.dart';
import 'package:projetsalon/auths/pages/register.dart';
import 'package:projetsalon/recettes/vente/model/note.dart';
import 'package:projetsalon/recettes/vente/util/database_helper.dart';

void main() => runApp(new MyApp());

final routes = {
  '/login': (BuildContext context) => new LoginPage(),
  '/home': (BuildContext context) => new HomePage(),
  '/register': (BuildContext context) => new RegisterPage(),
  '/': (BuildContext context) => new LoginPage(),
};

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
   List<Vente> items = new List();

   DbHelperVente db = new  DbHelperVente();

  void initState() {
    super.initState();
    db.getAllNotes().then((notes) {
      setState(() {
        notes.forEach((note) {
          items.add(Vente.fromMap(note));
        });
      });
    });
  }

  Widget build(BuildContext context) {
    return new MaterialApp(
            debugShowCheckedModeBanner: false,
color: Colors.black,
      title: 'Monsalon',
      theme: new ThemeData(primarySwatch: Colors.teal),
      routes: routes,
    );
  }
}
