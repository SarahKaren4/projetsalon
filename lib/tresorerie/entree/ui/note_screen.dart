import 'package:flutter/material.dart';
import 'package:projetsalon/recettes/vente/model/note.dart';
import 'package:projetsalon/recettes/vente/util/database_helper.dart';
import 'package:projetsalon/tresorerie/entree/model/note.dart';
class NoteScreen extends StatefulWidget {
  final Entree note;
  NoteScreen(this.note);

  @override
  State<StatefulWidget> createState() => new _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
   DbHelperVente db = new  DbHelperVente();

  TextEditingController _usqgeController;
  TextEditingController _coutController;
  TextEditingController _dateajoutController;

  @override
  void initState() {
    super.initState();

   _usqgeController = new TextEditingController(text: widget.note.usage);
   _coutController = new TextEditingController(text: widget.note.cout);
   _dateajoutController = new TextEditingController(text: widget.note.dateajout);

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'AlexandriaFLF'),

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
                     controller:_usqgeController,
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
                controller:_coutController,
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
                                  controller:_dateajoutController,

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
                                  controller:_dateajoutController,
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
              /*
              Padding(padding: new EdgeInsets.all(5.0)),
              RaisedButton(
                child: (widget.note.id != null) ? Text('Update') : Text('Add'),
                onPressed: () {
                  if (widget.note.id != null) {
                    db.updateNote(Vente.fromMap({
                      'id': widget.note.id,
                      'nom':_usqgeController.text,
                      'qte':_coutController.text,
                      'details':_detailsController.text,
                      'prixachat': _prixachatController.text,
                      'prixvente':_dateajoutController.text

                    })).then((_) {
                      Navigator.pop(context, 'update');
                    });
                  }else {
                    db.saveNote(Vente(_nomController.text,_coutController.text,_prixventeController.text)).then((_) {
                      Navigator.pop(context, 'save');
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
}
