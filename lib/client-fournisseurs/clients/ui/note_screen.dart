import 'package:flutter/material.dart';
import 'package:projetsalon/client-fournisseurs/clients/model/note.dart';
import 'package:projetsalon/client-fournisseurs/clients/ui/prestation.dart';
import 'package:projetsalon/prod-materiel/materiel/util/database_helper.dart';
import 'package:projetsalon/recettes/prestation/model/note.dart';
import 'package:projetsalon/recettes/prestation/util/database_helper.dart';

class NoteScreen extends StatefulWidget {
  final Client note;
  NoteScreen(this.note);

  @override
  State<StatefulWidget> createState() => new _NoteScreenState();
}
class _NoteScreenState extends State<NoteScreen> {
  DatabaseHelper db = new DatabaseHelper();
  List<Prestation> ventes = new List();
  
DbHelperPrestation dbClient = new DbHelperPrestation();
  TextEditingController _nomController;
  TextEditingController _numclientController;
 var now = DateTime.now();

  @override
  void initState() {
    super.initState();

 dbClient.getAllNotesFromOne(widget.note.nom).then((notes) {
        setState(() {
          ventes.clear();
          notes.forEach((note) {
           ventes.add(Prestation.fromMap(note));
          });
        });
      });
    _nomController = new TextEditingController(text: widget.note.nom);

    _numclientController = new TextEditingController(text: widget.note.numclient);
    /*
    _prixachatController = new TextEditingController(text: widget.note.prixachat);
    _prixventeController = new TextEditingController(text: widget.note.prixvente);
*/
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      title: 'Monsalon',
      color: Colors.black,
          home: Scaffold(
        floatingActionButton: FloatingActionButton(
              heroTag: "fbtn2",
          child: Icon(Icons.add),
          onPressed: () => _createNewNote(context),
        ),
        body: Container(
          margin: EdgeInsets.all(15.0),
          alignment: Alignment.center,
          child:Column(
            children: <Widget>[
             
               new Padding(
                  padding: const EdgeInsets.symmetric(horizontal:50, vertical: 5),
                  child: new TextFormField(
                    			keyboardType: TextInputType.text,
                     validator: (val) {
                              if(val.length==0) {
                                return "Votre numero est requis";
                              }else{
                                return null;
                              }
                            },
                     textAlign: TextAlign.center,
                            textCapitalization: TextCapitalization.words,
                     controller: _nomController,
                    decoration: new InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                              labelText: "   Nom",
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(20.0),
                                borderSide: new BorderSide(
                                ),
                              ),
                              //fillColor: Colors.green
                            ),        
                           ),
                ),
               new Padding(
                  padding: const EdgeInsets.symmetric(horizontal:50, vertical: 5),
                  child: new TextFormField(
                    			keyboardType: TextInputType.number,
                     validator: (val) {
                              if(val.length==0) {
                                return "Votre numero est requis";
                              }else{
                                return null;
                              }
                            },
                     textAlign: TextAlign.center,
                            textCapitalization: TextCapitalization.words,
                controller: _numclientController,
                    decoration: new InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                              labelText: "   Numéro",
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(20.0),
                                borderSide: new BorderSide(
                                ),
                              ),
                              //fillColor: Colors.green
                            ),        
                           ),
                ),
              Expanded(
                child: ListView.builder(
                  itemCount: ventes.length,
                  itemBuilder: (context, position) {
                  return Column (children: <Widget>[
                        Text(ventes[position].nomprestation),
                  ],);
                  },
                ),
              )              /*
              RaisedButton(
                child: (widget.note.id != null) ? Text('Update') : Text('Add'),
                onPressed: () {
                  if (widget.note.id != null) {
                    db.updateNote(Note.fromMap({
                      'id': widget.note.id,
                      'nom': _nomController.text,
                      'numclient': _numclientController.text,
                      'numclient':_numclientController.text,  
                      'dateajoutclient' : widget.note.dateajoutclient,
                    })).then((_) {
                      Navigator.pop(context, 'update');
                    });
                  }
                },
              ),
             */
            ],
          ),
        ),
      ),
    );
  }
    void _createNewNote(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreenPrestaDirect(Client(widget.note.nom, widget.note.numclient,'',))),
    );
    if (result == 'save') {
      dbClient.getAllNotes().then((notes) {
        setState(() {
          ventes.clear();
          notes.forEach((note) {
           ventes.add(Prestation.fromMap(note));
          });
        });
      });
    }
  }
}
