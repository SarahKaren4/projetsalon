import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:projetsalon/recettes/vente/model/note.dart';
import 'package:projetsalon/recettes/vente/util/database_helper.dart';
import 'package:projetsalon/tresorerie/entree/model/note.dart';
import 'package:projetsalon/tresorerie/entree/ui/note_screen.dart';
import 'package:projetsalon/tresorerie/entree/util/database_helper.dart';
class ListViewEntree extends StatefulWidget {

  
  _ListViewEntreeState createState() => new _ListViewEntreeState();
}
class _ListViewEntreeState extends State<ListViewEntree> {
  List<Entree> items = new List();
   DatabaseHelperEntree db = new  DatabaseHelperEntree();
  void initState() {
    super.initState();
    db.getAllNotes().then((notes) {
      setState(() {
        notes.forEach((note) {
          items.add(Entree.fromMap(note));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.black,
      theme: ThemeData(fontFamily: 'AlexandriaFLF'),
      title: 'Monsalon',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
       
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (context, position) {
              var jour = new DateFormat("dd-MM-yyyy").parse(items[position].dateajout).toString();

                    return Column(
                  children: <Widget>[
                    Divider(height: 5.0),

                    InkWell(

                      child: Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(1.0)),
                          Html(
                            data: """
                   <table border='1'><tr><th>${items[position].usage}</th><th>${items[position].cout}<br>Francs Cfa</th><th>${items[position].dateajout}</th></tr></tr></table>
  """, ),
                          /*
                          Row(
                            children: <Widget>[
                              IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () => _deleteNote(context, items[position], position)),
                            ],
                          ),
                          */
                        ],
                      ),
                      onTap: () => _navigateToNote(context, items[position]),
                    ),

                  ],
                );
              }),
        ),
     
      ),
    );
  }

  void _deleteNote(BuildContext context, Entree note, int position) async {
    db.deleteNote(note.id).then((notes) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToNote(BuildContext context, Entree note) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(note)),
    );

    if (result == 'update') {
      db.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Entree.fromMap(note));
          });
        });
      });
    }
  }

  void _createNewNote(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(Entree('', '',''))),
    );

    if (result == 'save') {
      db.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Entree.fromMap(note));
          });
        });
      });
    }
  }
}
