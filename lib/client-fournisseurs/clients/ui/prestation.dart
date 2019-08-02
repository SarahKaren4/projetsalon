import 'package:flutter/material.dart';
import 'package:projetsalon/client-fournisseurs/clients/model/note.dart';
import 'package:projetsalon/client-fournisseurs/clients/util/database_helper.dart';
import 'package:projetsalon/recettes/prestation/model/note.dart';
import 'package:projetsalon/recettes/prestation/ui/listview_note.dart';
import 'package:projetsalon/recettes/prestation/util/database_helper.dart';
import 'package:projetsalon/recettes/vente/util/database_helper.dart';
class NoteScreenPrestaDirect extends StatefulWidget {
  final Client note;
  NoteScreenPrestaDirect(this.note);

  @override
  State<StatefulWidget> createState() => new _NoteScreenPrestaDirectState();
}

class _NoteScreenPrestaDirectState extends State<NoteScreenPrestaDirect> {

  DbHelperPrestation db = new DbHelperPrestation();
  DbHelperVente bdVente = new DbHelperVente();
  DatabaseHelpeClientr bdclient = new DatabaseHelpeClientr(); 
  TextEditingController _nomprestationController =new TextEditingController();
  TextEditingController _nomclientController;
  TextEditingController _coutController=new TextEditingController();
    TextEditingController _numclientController;
bool enabletextfield=false;
 var now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _nomclientController = new TextEditingController(text: widget.note.nom);
    _numclientController = new TextEditingController(text: widget.note.numclient);

  

  }

  @override
  Widget build(BuildContext context) {
    if(widget.note.id==null) {
     enabletextfield=true;  
    }
    else{
      enabletextfield=false; 
    }
    return Scaffold(
     
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child:Column(
          children: <Widget>[
           
             new Padding(
                padding: const EdgeInsets.symmetric(horizontal:50, vertical: 5),
                child: new TextFormField(
                                   enabled:enabletextfield,

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
                   controller: _nomprestationController,
                  decoration: new InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                            labelText: "   Nom de la prestation",
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
                                   enabled:false,

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
              controller: _nomclientController,
                  decoration: new InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                            labelText: "   Nom du client",
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
                 enabled:enabletextfield,
                  			keyboardType: TextInputType.number,
                                controller: _coutController,

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
                            labelText: "   Cout de la prestation",
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
                                  enabled:false, 
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
                            labelText: "   Numero du client",
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
                   var dateajout='${now.day}-${now.month}-${now.year}-${now.hour}-${now.minute}';
                  db.saveNote(Prestation(_nomprestationController.text, _nomclientController.text, _coutController.text, _numclientController.text,'','', dateajout,'')).then((_) {
                      Navigator.pop(context, 'update');
                  }); 
                }
                else {
                    var dateajout='${now.day}-${now.month}-${now.year}-${now.hour}-${now.minute}';
                  db.saveNote(Prestation(_nomprestationController.text, _nomclientController.text, _coutController.text, _numclientController.text,'','', dateajout,'')).then((_) {
                     Route route = MaterialPageRoute(builder: (context) =>ListViewPrestation());
                    Navigator.push(context, route); 
                  });  
                }
           
              },
            ),
          ],
        ),
      ),
    );
  }
}
