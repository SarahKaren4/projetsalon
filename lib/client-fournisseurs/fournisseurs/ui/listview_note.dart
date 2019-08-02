import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:projetsalon/client-fournisseurs/fournisseurs/model/note.dart';
import 'package:projetsalon/client-fournisseurs/fournisseurs/ui/note_screen.dart';
import 'package:projetsalon/client-fournisseurs/fournisseurs/util/database_helper.dart';
class ListViewFournisseurs extends StatefulWidget {
  @override
  _ListViewFournisseursState createState() => new _ListViewFournisseursState();
}

class _ListViewFournisseursState extends State<ListViewFournisseurs> {
  List<Fournisseurs> items = new List();
 DbHelperFournisseurs db = new DbHelperFournisseurs();

  @override
  void initState() {
    super.initState();

    db.getAllNotes().then((notes) {
      setState(() {
        notes.forEach((note) {
          items.add(Fournisseurs.fromMap(note));
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monsalon',
      theme: ThemeData(fontFamily: 'AlexandriaFLF'),
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
                          Padding( padding: EdgeInsets.all( 10.0 ) ) ,
                          /*
                            CircleAvatar(
                              backgroundColor: Colors.blueAccent,
                              radius: 15.0,
                              child: Text(
                                '${items[position].id}',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            */
                          /*
                            IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () => _deleteNote(context, items[position], position)),
                                */
                          Html(
                            data: """
                   <table border='1'><tr><th>${items[position]
                                .nomfournisseur}</th><th>${items[position]
                                .services}</th><th>${items[position]
                                .dateajoutfournisseur}</th></tr></table>
  """ ,

                          ) ,
                        ] ,
                      ) ,

                      onTap: () =>
                          _navigateToNote( context , items[position] ) ,
                    ) ,
                  ],
                );
              }),
        ),
       
      ),
    );
  }

  void _deleteNote(BuildContext context, Fournisseurs note, int position) async {
    db.deleteNote(note.id).then((notes) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToNote(BuildContext context, Fournisseurs note) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(note)),
    );

    if (result == 'update') {
      db.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Fournisseurs.fromMap(note));
          });
        });
      });
    }
  }

  void _createNewNote(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(Fournisseurs('', '','',))),
    );

    if (result == 'save') {
      db.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Fournisseurs.fromMap(note));
          });
        });
      });
    }
  }
}
