import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:projetsalon/prod-materiel/produit/model/note.dart';
import 'package:projetsalon/prod-materiel/produit/util/database_helper.dart';
import 'package:projetsalon/recettes/vente/model/note.dart';
import 'package:projetsalon/recettes/vente/util/database_helper.dart';
import 'package:projetsalon/tresorerie/entree/model/note.dart';
import 'package:projetsalon/tresorerie/entree/util/database_helper.dart';
import 'package:http/http.dart' as http;
class NoteScreen extends StatefulWidget {
  final Produit note;
  NoteScreen(this.note);

  @override
  State<StatefulWidget> createState() => new _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  DbHelperProd db = new DbHelperProd();
  DbHelperVente bdVente = new DbHelperVente();
  DatabaseHelperEntree dbEntree = new DatabaseHelperEntree();

  TextEditingController _nomController;
  TextEditingController _qteAcheteController = new TextEditingController();
  TextEditingController _detailsController;
  TextEditingController _prixachatController;
  TextEditingController _prixventeController;
  bool _enabled = false;
  final formKey = new GlobalKey<FormState>();
 var now = DateTime.now();
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
    print('saved');
    bdVente.saveNote(Vente(_nomController.text, _qteAcheteController.text, _prixventeController.text,(int.parse(_prixventeController.text)*int.parse(_qteAcheteController.text)).toString(),dateajout,'' )).then((_) {
      db.updateNote(Produit.fromMap({
        'id': widget.note.id,
        'nom': _nomController.text,
        'qte': (int.parse(widget.note.qte)-int.parse(_qteAcheteController.text)).toString(),
        'details':widget.note.details,
        'prixachat':widget.note.prixachat,
        'prixvente': widget.note.prixvente,
        'dateachat':widget.note.dateajoutprod
      })).then((_) {
        dbEntree.saveNote(Entree( _nomController.text,(int.parse(widget.note.qte)*int.parse(_qteAcheteController.text)).toString(),dateajout)).then((_) {
          Navigator.pop(context, 'save');
        });
      });
    });
    print(int.parse(widget.note.qte)-int.parse(_qteAcheteController.text));
  }
  Future sendiItOffline() async{
    print('saved');
    var dateajout='${now.year}-0${now.month}-${now.day}';
    bdVente.saveNote(Vente(_nomController.text, _qteAcheteController.text, _prixventeController.text,(int.parse(_prixventeController.text)*int.parse(_qteAcheteController.text)).toString(),dateajout,'' )).then((_) {
      db.updateNote(Produit.fromMap({
        'id': widget.note.id,
        'nom': _nomController.text,
        'qte': (int.parse(widget.note.qte)-int.parse(_qteAcheteController.text)).toString(),
        'details':widget.note.details,
        'prixachat':widget.note.prixachat,
        'prixvente': widget.note.prixvente,
        'dateachat':widget.note.dateajoutprod
      })).then((_) {
        dbEntree.saveNote(Entree( _nomController.text,(int.parse(widget.note.qte)*int.parse(_qteAcheteController.text)).toString(),dateajout)).then((_) {
          Navigator.pop(context, 'save');
        });
      });
    });
    print(int.parse(widget.note.qte)-int.parse(_qteAcheteController.text));
  }
  Future sendData() async{
    var dateajout='${now.year}-0${now.month}-${now.day}';

    final response = await http.post("http://192.168.8.100/monsalon/ventes.php", body:{
      'nom': _nomController.text,
      'qte': (int.parse(widget.note.qte)-int.parse(_qteAcheteController.text)).toString(),
      'prixvente': widget.note.prixvente,
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
  @override
  
  void initState() {
    super.initState();
    _prixventeController = new TextEditingController(text: widget.note.prixvente);
    _nomController = new TextEditingController(text: widget.note.nom);

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'AlexandriaFLF'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
appBar: AppBar(backgroundColor: Colors.white, title: Text(''),),
        body: Container(
          margin: EdgeInsets.all(15.0),
          alignment: Alignment.center,
          child:Column(
            children: <Widget>[

              Form(
                key: formKey,
child: Column(
  children: <Widget>[

               new Padding(
                  padding: const EdgeInsets.symmetric(horizontal:50, vertical: 5),
                  child: new TextFormField(
                      enabled: false,

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
                controller: _qteAcheteController,
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
                    enabled: false,
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
  ],
),

              ),
              Padding(padding: new EdgeInsets.all(5.0)),
             Padding(padding: new EdgeInsets.all(5.0)),
              RaisedButton(
                child: (widget.note.id != null) ? Text('Ajouter') : Text('Ajouter'),
                onPressed: () {
      if (formKey.currentState.validate()) {
        if (widget.note.id != null && int.parse(widget.note.qte)>int.parse(_qteAcheteController.text)) {
          checkConnection();

        }else {
          print('qte insuffisante');
        }
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
