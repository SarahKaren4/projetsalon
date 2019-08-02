import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:projetsalon/client-fournisseurs/clients/model/note.dart';
import 'package:projetsalon/client-fournisseurs/clients/ui/note_screen.dart';
import 'package:projetsalon/client-fournisseurs/clients/util/database_helper.dart';

class ListViewClient extends StatefulWidget {
  @override
  _ListViewClientState createState() => new _ListViewClientState();
}

class _ListViewClientState extends State<ListViewClient> {
  List<Client> items = new List();
  
DatabaseHelpeClientr dbClient = new DatabaseHelpeClientr();
  @override
  void initState() {
    super.initState();
   dbClient.getAllNotes().then((notes) {
      setState(() {
        notes.forEach((note) {
          items.add(Client.fromMap(note));
        });
      });
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
                                .nom}</th><th>${items[position]
                                .numclient}</th><th>${items[position]
                                .dateajoutclient}</th></tr></table>
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
  void _deleteNote(BuildContext context, Client note, int position) async {
    dbClient.deleteNote(note.id).then((notes) {
      setState(() {
        items.removeAt(position);
      });
    });
  }
  void _navigateToNote(BuildContext context, Client note) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(note)),
    );
    if (result == 'update') {
      dbClient.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Client.fromMap(note));
          });
        });
      });
    }
  }
  void _createNewNote(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(Client('', '',''))),
    );
    if (result == 'save') {
      dbClient.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Client.fromMap(note));
          });
        });
      });
    }
  }
}
