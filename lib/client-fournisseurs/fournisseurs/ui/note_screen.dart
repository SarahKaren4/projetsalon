import 'package:flutter/material.dart';
import 'package:projetsalon/client-fournisseurs/fournisseurs/model/note.dart';
import 'package:projetsalon/client-fournisseurs/fournisseurs/ui/achat.dart';
import 'package:projetsalon/client-fournisseurs/fournisseurs/util/database_helper.dart';
class NoteScreen extends StatefulWidget {
  final Fournisseurs note;
  NoteScreen(this.note);

  @override
  State<StatefulWidget> createState() => new _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  DbHelperFournisseurs db = new DbHelperFournisseurs();
  List<Fournisseurs> ventes = new List();

  TextEditingController _nomfournisseurController;
  TextEditingController _servicesController;
  TextEditingController _dateajoutfournisseurController;
 var now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _nomfournisseurController = new TextEditingController(text: widget.note.nomfournisseur);
    _servicesController = new TextEditingController(text: widget.note.services);
    _dateajoutfournisseurController = new TextEditingController(text: widget.note.dateajoutfournisseur);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'AlexandriaFLF'),
debugShowCheckedModeBanner: false,
      home: Scaffold(
         floatingActionButton: FloatingActionButton(
           backgroundColor: Colors.black,
           hoverColor: Colors.black26,
                heroTag: "fbtn2",
            child: Icon(Icons.add),
            onPressed: () => _createNewNote(context),
          ),
        body: Container(
          margin: EdgeInsets.all(15.0),
          alignment: Alignment.center,
          child:ListView(
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
                     controller: _nomfournisseurController,
                    decoration: new InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                              labelText: "   nomfournisseur",
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
                controller: _servicesController,
                    decoration: new InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                              labelText: "   Quantite",
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
                    			keyboardType: TextInputType.text,
                                  controller: _dateajoutfournisseurController,

                     validator: (val) {
                              if(val.length==0) {
                                return "Votre numero est requis";
                              }else{
                                return null;
                              }
                            },
                     textAlign: TextAlign.center,
                            textCapitalization: TextCapitalization.words,
                    decoration: new InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                              labelText: "   dateajoutfournisseur",
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
              Padding(padding: new EdgeInsets.all(5.0)),
              RaisedButton(
                child: (widget.note.id != null) ? Text('Update') : Text('Add'),
                onPressed: () {
                  if (widget.note.id != null) {
                    db.updateNote(Fournisseurs.fromMap({
                      'id': widget.note.id,
                      'nomfournisseur': widget.note.nomfournisseur,
                      'services': widget.note.services,
                      'dateajoutfournisseur':widget.note.dateajoutfournisseur,
                    })).then((_) {
                      Navigator.pop(context, 'update');
                    });
                  }else {
                      var dateajout='${now.day}-${now.month}-${now.year}-${now.hour}-${now.minute}';

                    db.saveNote(Fournisseurs(_nomfournisseurController.text, _servicesController.text, dateajout)).then((_) {
                      Navigator.pop(context, 'save');
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _createNewNote(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>Achat(Fournisseurs(widget.note.nomfournisseur, '','',))),
    );
    if (result == 'save') {
      db.getAllNotes().then((notes) {
        setState(() {
          ventes.clear();
          notes.forEach((note) {
           ventes.add(Fournisseurs.fromMap(note));
          });
        });
      });
    }
  } 
}
