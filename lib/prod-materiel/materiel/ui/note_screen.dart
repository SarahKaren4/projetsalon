import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projetsalon/client-fournisseurs/fournisseurs/model/note.dart';
import 'package:projetsalon/client-fournisseurs/fournisseurs/util/database_helper.dart';
import 'package:projetsalon/depenses/model/note.dart';
import 'package:projetsalon/depenses/util/database_helper.dart';
import 'package:projetsalon/prod-materiel/materiel/model/note.dart';
import 'package:projetsalon/prod-materiel/materiel/util/database_helper.dart';
import 'package:http/http.dart' as http;

class NoteScreen extends StatefulWidget {
  final Note note;
  NoteScreen(this.note);

  @override
  State<StatefulWidget> createState() => new _NoteScreenState();
}
class _NoteScreenState extends State<NoteScreen> {
  checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      sendData();
      print('donnees mobiles');
    }
    else if (connectivityResult == ConnectivityResult.wifi)
    {
      sendData();
      print('wifi');
    }
    else if (connectivityResult == ConnectivityResult.none)
    {
      sendiItOffline();
      print('offline');
    }
  }
  Future sendiItOnline() async{
    var dateajout='${now.year}-0${now.month}-${now.day}';
    db.saveNote(Note(_nomController.text, _qteController.text, _detailsController.text,_prixachatController.text , dateajout,'1',_nomfournisseurController.text)).then((_) {
      dbfournisseurs.saveNote(Fournisseurs(_nomfournisseurController.text,'Achat Materiel', dateajout)).then((_) {
        dbdepense.saveNote(Depense(_nomController.text,(int.parse(_prixachatController.text)*int.parse(_qteController.text)).toString() , dateajout)).then((_) {
          Navigator.pop(context, 'save');
        });
      });
    });
  }
  Future sendiItOffline() async{
    var dateajout='${now.year}-0${now.month}-${now.day}';
    db.saveNote(Note(_nomController.text, _qteController.text, _detailsController.text,_prixachatController.text , dateajout,'0',_nomfournisseurController.text)).then((_) {
      dbfournisseurs.saveNote(Fournisseurs(_nomfournisseurController.text,'Achat Materiel', dateajout)).then((_) {
        dbdepense.saveNote(Depense(_nomController.text,(int.parse(_prixachatController.text)*int.parse(_qteController.text)).toString() , dateajout)).then((_) {
          Navigator.pop(context, 'save');
        });
      });
    });
  }
  Future sendData() async{
    var dateajout='${now.year}-0${now.month}-${now.day}';

    final response = await http.post("http://192.168.8.100/monsalon/materiel.php", body:{
      'nom': _nomController.text,
      'qte': _qteController.text,
      'details':_detailsController.text,
      'prixachat': _prixachatController.text,
      'dateajoutprod' : dateajout.toString(),
      'nomfournisseur': _nomfournisseurController.text,
      'services': 'Achat materiel',
      'usage': _nomController.text,
      'statut' : '1'
    });
    //---- Info -------
    setState(() {
      var datauser = json.decode(response.body);
      if (datauser.length != 0){
        print(datauser.length);
        print(datauser);
        print('echec');
        sendiItOffline();
      }
      else if (datauser.length == 0){
        print(datauser.length);
        print('succes');
        sendiItOnline();
      }
    });
  }
  DatabaseHelper db = new DatabaseHelper();
    DatabaseHelperDepenses dbdepense = new DatabaseHelperDepenses();

  DbHelperFournisseurs dbfournisseurs = new DbHelperFournisseurs();
  final _formKey1 = GlobalKey<FormState>();

  TextEditingController _nomController;
  TextEditingController _qteController;
  TextEditingController _detailsController;
  TextEditingController _prixachatController;
  TextEditingController _prixventeController;
  TextEditingController _nomfournisseurController = new TextEditingController();
  TextEditingController _usageController;
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
            appBar: AppBar(
                actions: <Widget>[
                  RaisedButton(
                    elevation: 0.0,
                    color: Colors.white,
                    child:Icon(FontAwesomeIcons.angleLeft, size: 18,),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
                centerTitle: true,
                backgroundColor: Colors.white,
                title: Text('Matériels',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),

            body: Container(
          margin: EdgeInsets.all(15.0),
          alignment: Alignment.center,
          child:Form(
            key: _formKey1,
            child: ListView(
              children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Ajouter du Matériel', textAlign:TextAlign.center, style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, ),),
              ),
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
                                labelText: "   Nom du fournisseur",
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


                Padding(padding: new EdgeInsets.all(5.0)),
                RaisedButton(
                  child: (widget.note.id != null) ? Text('Modifier') : Text('Ajouter'),
                  onPressed: () {
                    if (widget.note.id != null) {
                      db.updateNote(Note.fromMap({
                        'id': widget.note.id,
                        'nom': _nomController.text,
                        'qte': _qteController.text,
                        'details':_detailsController.text,
                        'prixachat': _prixachatController.text,
                        'dateajoutmateriel' : widget.note.dateajoutmateriel,
                      })).then((_) {
                        Navigator.pop(context, 'update');
                      });
                    }else {
                   checkConnection();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
