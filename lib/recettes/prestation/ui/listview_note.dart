import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:projetsalon/recettes/prestation/model/note.dart';
import 'package:projetsalon/recettes/prestation/ui/note_screen.dart';
import 'package:projetsalon/recettes/prestation/util/database_helper.dart';
class ListViewPrestation extends StatefulWidget {
  @override
  _ListViewPrestationState createState() => new _ListViewPrestationState();
}

class _ListViewPrestationState extends State<ListViewPrestation> {
  List<Prestation> items = new List();
  DbHelperPrestation db = new DbHelperPrestation();

  @override
  void initState() {
    super.initState();

    db.getAllNotes().then((notes) {
      setState(() {
        notes.forEach((note) {
          items.add(Prestation.fromMap(note));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'AlexandriaFLF'),
      title: 'Monsalon',
      debugShowCheckedModeBanner: false,
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
                   <table border='1'><tr><th>${items[position].nomclient}</th><th>${items[position].cout}<br>Francs Cfa</th><th>${items[position].nomprestation}</th></tr></tr></table>
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.add),
          onPressed: () => _createNewNote(context),
        ),
      ),
    );
  }

  void _deleteNote(BuildContext context, Prestation note, int position) async {
    db.deleteNote(note.id).then((notes) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToNote(BuildContext context, Prestation note) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreenFournisseurs(note)),
    );

    if (result == 'update') {
      db.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Prestation.fromMap(note));
          });
        });
      });
    }
  }

  void _createNewNote(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreenFournisseurs(Prestation('', '','','', '','','',''))),
    );

    if (result == 'save') {
      db.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Prestation.fromMap(note));
          });
        });
      });
    }
  }
}
