import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:projetsalon/prod-materiel/produit/model/note.dart';
import 'package:projetsalon/prod-materiel/produit/util/database_helper.dart';
import 'package:projetsalon/recettes/vente/ui/note_screen.dart';
class ListViewVente extends StatefulWidget {
  @override
  _ListViewVenteState createState() => new _ListViewVenteState();
}

class _ListViewVenteState extends State<ListViewVente> {
  List<Produit> items = new List();
  DbHelperProd db = new DbHelperProd();

  @override
  void initState() {
    super.initState();

    db.getAllNotes().then((notes) {
      setState(() {
        notes.forEach((note) {
          items.add(Produit.fromMap(note));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'AlexandriaFLF'),
      title: 'Monsalon',
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
                   <table border='1'><tr><th>${items[position].nom}</th><th>${items[position].prixvente}<br>Francs Cfa</th><th>${items[position].qte}</th></tr></tr></table>
  """, ),

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

  void _deleteNote(BuildContext context, Produit note, int position) async {
    db.deleteNote(note.id).then((notes) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToNote(BuildContext context, Produit note) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(note)),
    );

    if (result == 'update') {
      db.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Produit.fromMap(note));
          });
        });
      });
    }
  }

  void _createNewNote(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(Produit('', '','','','','','',''))),
    );

    if (result == 'save') {
      db.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Produit.fromMap(note));
          });
        });
      });
    }
  }
}
