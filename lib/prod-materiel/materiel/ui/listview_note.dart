import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projetsalon/prod-materiel/materiel/model/note.dart';
import 'package:projetsalon/prod-materiel/materiel/ui/note_screen.dart';
import 'package:projetsalon/prod-materiel/materiel/util/database_helper.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
class ListViewNote extends StatefulWidget {
  @override
  _ListViewNoteState createState() => new _ListViewNoteState();
}

class _ListViewNoteState extends State<ListViewNote> {
  List<Note> items = new List();
  DatabaseHelper db = new DatabaseHelper();

  @override
  void initState() {
    super.initState();

    db.getAllNotes().then((notes) {
      setState(() {
        notes.forEach((note) {
          items.add(Note.fromMap(note));
        });
      });
    });
  }
  Future sendData(BuildContext context, Note note, int position) async{
    final response = await http.post("http://192.168.8.101/monsalon/produits.php", body:{
      'id': items[position].id,
      'nom': items[position].nom,
      'qte': items[position].qte,
      'details':items[position].details,
      'prixachat': items[position].prixachat,
      'nomfournisseur':items[position].nomfournisseur,
      'dateajoutprod' :items[position].dateajoutmateriel,
      'statut' : '1',
    });
    //---- Info -------
    setState(() {
      var datauser = json.decode(response.body);
      if (datauser.length != 0){
        print(datauser.length);
        print(datauser);
        print('echec');
      }
      else if (datauser.length == 0){
        print(datauser.length);
        db.updateNote(Note.fromMap({
          'id': items[position].id,
          'nom': items[position].nom,
          'qte': items[position].qte,
          'details':items[position].details,
          'prixachat': items[position].prixachat,
          'nomfournisseur':items[position].nomfournisseur,
          'statut' : '1',
        })).then((_) {
          print('succes');
          Route route = MaterialPageRoute(builder: (context) =>ListViewNote());
          Navigator.push(context, route);
        });
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'AlexandriaFLF'),
      debugShowCheckedModeBanner: false,
      title: 'Monsalon',
      color: Colors.black,
      home: Scaffold(
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (context, position) {
                return Column(
                  children: <Widget>[
                    Divider(height: 5.0),

                    InkWell(

                      child: Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(1.0)),
                          Html(
                            data: """
                   <table border='1'><tr><th>${items[position].nom}</th><th>${items[position].prixachat}<br>Francs Cfa</th><th>${items[position].qte}</th></tr><th>${items[position].qte}</th></tr></table>
  """, ),
                          Row(
                            children: <Widget>[
                              IconButton(
                                  icon: const Icon(Icons.remove_circle_outline, size: 10,),
                                  onPressed: () => _deleteNote(context, items[position], position)),
                              items[position].statut=='0'? IconButton(
                                  icon: const Icon(Icons.update,size: 10),
                                  onPressed: () => sendData(context, items[position], position)): Text('') ,
                            ],
                          )
                        ],
                      ),
                      onTap: () => _navigateToNote(context, items[position]),
                    ),
                  ],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.add),
          onPressed: () => _createNewNote(context),
        ),
      ),
    );
  }
  void _deleteNote(BuildContext context, Note note, int position) async {
    db.deleteNote(note.id).then((notes) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToNote(BuildContext context, Note note) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(note)),
    );

    if (result == 'update') {
      db.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Note.fromMap(note));
          });
        });
      });
    }
  }
  void _createNewNote(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(Note('', '','','','','',''))),
    );

    if (result == 'save') {
      db.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Note.fromMap(note));
          });
        });
      });
    }
  }
}
