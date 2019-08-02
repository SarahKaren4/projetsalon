import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projetsalon/client-fournisseurs/clients/model/note.dart';
import 'package:projetsalon/client-fournisseurs/clients/util/database_helper.dart';
import 'package:projetsalon/recettes/prestation/model/note.dart';
import 'package:projetsalon/recettes/prestation/util/database_helper.dart';
import 'package:projetsalon/recettes/vente/model/note.dart';
import 'package:projetsalon/recettes/vente/util/database_helper.dart';
import 'package:projetsalon/tresorerie/entree/model/note.dart';
import 'package:projetsalon/tresorerie/entree/util/database_helper.dart';
import 'package:http/http.dart' as http;
class NoteScreenFournisseurs extends StatefulWidget {
  final Prestation note;
  NoteScreenFournisseurs(this.note);

  @override
  State<StatefulWidget> createState() => new _NoteScreenFournisseursState();
}

class _NoteScreenFournisseursState extends State<NoteScreenFournisseurs> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
    db.saveNote(Prestation(_currentCity, _nomclientController.text, _coutController.text, _numclientController.text,'','', dateajout,'1')).then((_) {
      bdclient.saveNote(Client(_nomclientController.text, _numclientController.text,dateajout)).then((_) {
        dbEntree.saveNote(Entree(_currentCity, _coutController.text,dateajout)).then((_) {
          Navigator.pop(context, 'save');
        });                    });
    });

  }
  Future sendiItOffline() async{
    var dateajout='${now.year}-0${now.month}-${now.day}';
    db.saveNote(Prestation(_currentCity, _nomclientController.text, _coutController.text, _numclientController.text,'','', dateajout,'0')).then((_) {
      bdclient.saveNote(Client(_nomclientController.text, _numclientController.text,dateajout)).then((_) {
        dbEntree.saveNote(Entree(_currentCity, _coutController.text,dateajout)).then((_) {
          Navigator.pop(context, 'save');
        });                    });
    });
  }
  Future sendData() async{
    var dateajout='${now.year}-0${now.month}-${now.day}';
    final response = await http.post("http://192.168.8.100/monsalon/prestation.php", body:{
      'nom': _currentCity,
      'nomclient': _nomclientController.text,
      'cout':_coutController.text,
      'dateprestation' : widget.note.dateprestation,
      'numclient' :widget.note.numclient,
      'avance' : widget.note.avance,
      'reste' :widget.note.reste
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
  DbHelperPrestation db = new DbHelperPrestation();
  DbHelperVente bdVente = new DbHelperVente();
  DatabaseHelperEntree dbEntree = new DatabaseHelperEntree();
  DatabaseHelpeClientr bdclient = new DatabaseHelpeClientr(); 
  TextEditingController _nomprestationController =new TextEditingController();
  TextEditingController _nomclientController=new TextEditingController();
  TextEditingController _coutController=new TextEditingController();
    TextEditingController _numclientController=new TextEditingController();
bool enabletextfield=false;
 var now = DateTime.now();
  List _cities =
  ["Manucure", "Pédicure", "Coiffure", "Soins des cheveux"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCity;
  @override
  void initState() {
    super.initState();
  _currentCity = widget.note.nomprestation;
    _nomclientController = new TextEditingController(text: widget.note.nomclient);
   _coutController = new TextEditingController(text: widget.note.cout);
    _numclientController = new TextEditingController(text: widget.note.numclient);
 super.initState();
_dropDownMenuItems = getDropDownMenuItems();
    _currentCity = _dropDownMenuItems[0].value;
  

  }
 List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _cities) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(
          value: city,
          child: new Text(city)
      ));
    }
    return items;
  }
  @override
  Widget build(BuildContext context) {
    if(widget.note.id==null) {
     enabletextfield=true;  
    }
    else{
      enabletextfield=false; 
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'AlexandriaFLF'),
      home: Scaffold(
        appBar: AppBar(
            actions: <Widget>[
              RaisedButton(
                elevation: 0.0 ,
                color: Colors.white ,
                child: Icon( FontAwesomeIcons.angleLeft , size: 18 , ) ,
                onPressed: () {
                  Navigator.of( context ).pop( );
                } ,
              )
            ] ,
            leading: new IconButton(iconSize: 30, color:Colors.black87, icon: new Icon(FontAwesomeIcons.bars, size: 15,),
                onPressed: () => _scaffoldKey.currentState.openDrawer()),
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text('Prestations',style: TextStyle(color: Colors.black),)),
        body: Container(
          margin: EdgeInsets.all(15.0),
          alignment: Alignment.center,
          child:ListView(
            children: <Widget>[

               new Padding(
                  padding: const EdgeInsets.symmetric(horizontal:50, vertical: 5),
                  child:  new DropdownButton(
                value: _currentCity,
                items: _dropDownMenuItems,
                onChanged: changedDropDownItem,
              )
                ),
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
                                    enabled:enabletextfield,
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
                  var dateajout='${now.year}-0${now.month}-${now.day}';
  bdVente.saveNote(Vente(_currentCity, _nomclientController.text, _coutController.text, _numclientController.text, dateajout,'0')).then((_) {
  db.updateNote(Prestation.fromMap({
                      'id': widget.note.id,
                      'nomprestation': _currentCity,
                      'nomclient': _nomclientController.text,
                      'coutController':_coutController.text,
                      'dateprestation' : widget.note.dateprestation,
                      'numclient' :widget.note.numclient,
                      'avance' : widget.note.avance,
                      'reste' :widget.note.reste
                    })).then((_) {
                    });
                    });
                  }
                  else
                  {
                  checkConnection();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
    void changedDropDownItem(String selectedCity) {
    print("Selected city $selectedCity, we are going to refresh the UI");
    setState(() {
      _currentCity = selectedCity;
    });
  }
}
