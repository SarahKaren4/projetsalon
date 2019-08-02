import 'package:flutter/material.dart';
import 'package:projetsalon/prod-materiel/materiel/model/note.dart';
import 'package:projetsalon/prod-materiel/materiel/util/database_helper.dart';

class NoteScreen extends StatefulWidget {
  final Note note;
  NoteScreen(this.note);

  @override
  State<StatefulWidget> createState() => new _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  DatabaseHelper db = new DatabaseHelper();

  TextEditingController _nomController;
  TextEditingController _qteController;
  TextEditingController _detailsController;
  TextEditingController _prixachatController;
  TextEditingController _prixventeController;
 var now = DateTime.now();

  @override
  void initState() {
    super.initState();

    _nomController = new TextEditingController(text: widget.note.nom);
    _qteController = new TextEditingController(text: widget.note.qte);
    _detailsController = new TextEditingController(text: widget.note.details);
    _prixachatController = new TextEditingController(text: widget.note.prixachat);

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'AlexandriaFLF'),
      debugShowCheckedModeBanner: false,
      title: 'Monsalon',
      color: Colors.black,
          home: Scaffold(
       
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
                controller: _qteController,
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
                                  controller: _detailsController,

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
                              labelText: "   Details",
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
                                  controller: _prixachatController,
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
                    decoration: new InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                              labelText: "   Prix d'achat",
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
                                  controller: _prixventeController,
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
                    decoration: new InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                              labelText: "   Prix de vente",
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
                    db.updateNote(Note.fromMap({
                      'id': widget.note.id,
                      'nom': _nomController.text,
                      'qte': _qteController.text,
                      'details':_detailsController.text,
                      'prixachat': _prixachatController.text,
                      'prixvente': _prixventeController.text  ,
                      'dateajoutmateriel' : widget.note.dateajoutmateriel,
                    })).then((_) {
                      Navigator.pop(context, 'update');
                    });
                  }else {
                      var dateajout='${now.day}-${now.month}-${now.year}-${now.hour}-${now.minute}';

                    db.saveNote(Note(_nomController.text, _qteController.text, _detailsController.text,_prixachatController.text , dateajout,'','')).then((_) {
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
}
