import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:projetsalon/auths/data/database_helper.dart';
import 'package:projetsalon/auths/models/user.dart';
import 'package:projetsalon/auths/pages/login/login_page.dart';
import 'package:projetsalon/catalogue/ui/listview_note.dart';
import 'package:projetsalon/client-fournisseurs/main.dart';
import 'package:projetsalon/depenses/model/note.dart';
import 'package:projetsalon/depenses/ui/listview_note.dart';
import 'package:projetsalon/depenses/util/database_helper.dart';
import 'package:projetsalon/employe/model/note.dart';
import 'package:projetsalon/employe/model/salaires.dart';
import 'package:projetsalon/employe/util/database_helper.dart';
import 'package:projetsalon/employe/util/datebase_helper_salaire.dart';
import 'package:projetsalon/prod-materiel/main.dart';
import 'package:http/http.dart' as http;
// ignore: must_be_immutable
class NoteScreen extends StatefulWidget {
  final Employee note;
  NoteScreen(this.note);
  final formats = {
    InputType.both: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
    InputType.date: DateFormat('yyyy-MM-dd'),
    InputType.time: DateFormat("HH:mm"),
  };
  // Changeable in demo
  InputType inputType = InputType.both;
  bool editable = true;
  DateTime date;
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
    db.saveNote(Employee(_nomemployeeController.text, _fonctionController.text, _salaireController.text,dateajout,'1')).then((_) {
      Navigator.pop(context, 'save');
    });
  }
  Future sendiItOffline() async{
    var dateajout='${now.year}-0${now.month}-${now.day}';

    db.saveNote(Employee(_nomemployeeController.text, _fonctionController.text, _salaireController.text,dateajout,'0')).then((_) {
      Navigator.pop(context, 'save');
    });
  }
  Future sendData() async{
    var dateajout='${now.year}-0${now.month}-${now.day}';
    final response = await http.post("http://192.168.8.100/monsalon/employe.php", body:{
      'nomemploye': _nomemployeeController.text,
      'fonction': _fonctionController.text,
      'salaire':_salaireController.text,

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
  checkConnectionSalary() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      sendDataSalary();
      print('donnees mobiles');
    }
    else if (connectivityResult == ConnectivityResult.wifi)
    {
      sendDataSalary();
      print('wifi');
    }
    else if (connectivityResult == ConnectivityResult.none)
    {
      sendiItOffline();
      print('offline');
    }
  }
  Future sendiItOnlineSalary() async{
    var dateajout='${now.day}-${now.month}-${now.year}-${now.hour}-${now.minute}';
    dbSalaire.saveNote(Salaire( widget.note.id.toString(),_moispaye.text,dateajout,_salaireController.text)).then((_) {
      dbDepenses.saveNote(Depense('Paiement salaire',_salaireController.text,_moispaye.text)).then((_) {
        Navigator.of(context).pop();
        print('Depense ajoutee');
        print('Salaire paye');
      });
    });
  }
  Future sendiItOfflineSalary() async{
    var dateajout='${now.day}-${now.month}-${now.year}-${now.hour}-${now.minute}';
    dbSalaire.saveNote(Salaire( widget.note.id.toString(),_moispaye.text,dateajout,_salaireController.text)).then((_) {
      dbDepenses.saveNote(Depense('Paiement salaire',_salaireController.text,_moispaye.text)).then((_) {
        Navigator.of(context).pop();
        print('Depense ajoutee');
        print('Salaire paye');
      });
    });
  }
  Future sendDataSalary() async{
    // ignore: unused_local_variable
    var dateajout='${now.year}-0${now.month}-${now.day}';
    final response = await http.post("http://192.168.8.100/monsalon/employe.php", body:{
      'nomemploye': _nomemployeeController.text,
      'fonction': _fonctionController.text,
      'salaire':_salaireController.text,
      'utilisation':'Paiement salaire',
      'salaire':_salaireController.text,
      'moispaye' :_moispaye.text
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
  DatabaseHelper dbUser = new DatabaseHelper();
  List<User> user = new List();
  List<Salaire> items = new List();
  List<Depense> depenses = new List( );
  DatabaseHelperDepenses dbDepenses = new DatabaseHelperDepenses( );
  DatabaseHelperEmployee db = new DatabaseHelperEmployee();
  DatabaseHelperSalaire dbSalaire = new DatabaseHelperSalaire();
  final formKey = new GlobalKey<FormState>();
  final formKey1 = new GlobalKey<FormState>();
  var now = DateTime.now();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _nomemployeeController;
  TextEditingController _salaireController;
  TextEditingController _fonctionController;
  TextEditingController _moispaye = new TextEditingController();
  @override
  void initState() {
    super.initState();
    _nomemployeeController = new TextEditingController(text: widget.note.nomemploye);
    _salaireController = new TextEditingController(text: widget.note.salaire);
    _fonctionController = new TextEditingController(text: widget.note.fonction);
    dbUser.getAllUser().then((users) {
      setState(() {
        users.forEach((user) {
          user.add(User.fromMap(user));
        });
      });
    });
    dbDepenses.getAllNotes().then((notes) {
      setState(() {
        notes.forEach((note) {
          depenses.add(Depense.fromMap(note));
        });
      });
    });
    dbSalaire.getAllNotesFromOne(widget.note.id).then((notes) {
      setState(() {
        items.clear();
        notes.forEach((note) {
          items.add(Salaire.fromMap(note));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'AlexandriaFLF'),
      title: 'Monsalon',
      color: Colors.black,
      debugShowCheckedModeBanner: false,
         home: Scaffold(
           key: _scaffoldKey,

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
          title: Text('Employee',style: TextStyle(color: Colors.black),)),
           drawer:Container(
             width: MediaQuery.of(context).size.width*2/3,
             child: Drawer(
               child: ListView.builder(
                   itemCount: user.length,
                   itemBuilder: (context, position) {
                     return Column(
                       mainAxisSize: MainAxisSize.max,

                       children: <Widget>[
                         Container(
                           height: MediaQuery.of(context).size.height>1000?MediaQuery.of(context).size.height/3.7:MediaQuery.of(context).size.height/2,
                           child: UserAccountsDrawerHeader(
                             decoration: BoxDecoration(color: Colors.white),
                             accountName: Text('${user[position].username}'),
                             accountEmail: Text('${user[position].username}'),
                             currentAccountPicture: Container(
                               child: CircleAvatar(
                                 backgroundColor: Colors.brown.shade800,
                                 child: Text('${user[position].username}'.substring(0,1)),
                               ),
                             ),
                           ),
                         ),
                         new ListTile(
                           title: new Text( "Bilan", style: TextStyle(fontSize:12), ) ,
                           onTap: () {
                           } ,
                         ) ,
                         new Divider(
                           height: 0.1,
                           color: Colors.black,
                         ),
                         new ListTile(
                             title: new Text( "Clients fournisseurs", style: TextStyle(fontSize:12), ) ,
                             onTap: (){
                               Route route = MaterialPageRoute(builder: (context) =>Collaborateurs());
                               Navigator.push(context, route);
                             }
                         ) ,
                         new Divider(
                           height: 0.1,
                           color: Colors.black,
                         ),
                         new ListTile(
                           title: new Text( "Achats", style: TextStyle(fontSize:12), ) ,
                           onTap: () {

                             Route route = MaterialPageRoute(builder: (context) =>ListViewDepense());
                             Navigator.push(context, route);                } ,
                         ) ,
                         new Divider(
                           height: 0.1,
                           color: Colors.black,
                         ),

                         new ListTile(
                           title: new Text( "Stock", style: TextStyle(fontSize:12), ) ,
                           onTap: () {
                             print(user[position].username);
                             Navigator.of(context).push(
                               MaterialPageRoute(builder: (context) => MainPersistentTabBar()),             );

                           } ,
                         )
                         ,
                         new Divider(
                           height: 0.1,
                           color: Colors.black,
                         ),
                         new ListTile(
                             title: new Text( "Catalogue", style: TextStyle(fontSize:12), ) ,
                             onTap: () {
                               Route route = MaterialPageRoute(builder: (context) => ListViewCatalogue());
                               Navigator.push(context, route);
                             }),
                         new Divider(
                           height: 0.1,
                           color: Colors.black,
                         ),
                         new ListTile(
                           title: new Text( "Fréquences", style: TextStyle(fontSize:12), ) ,
                           onTap: () {

                             Route route = MaterialPageRoute(builder: (context) =>LoginPage());
                             Navigator.push(context, route);                } ,
                         ) ,
                         new Divider(
                           height: 0.1,
                           color: Colors.black,
                         ),
                         new Divider(
                           height: 0.1,
                           color: Colors.black,
                         ),
                         new ListTile(
                           title: new Text( "Mon compte", style: TextStyle(fontSize:12), ) ,
                           onTap: () {

                             Route route = MaterialPageRoute(builder: (context) =>LoginPage());
                             Navigator.push(context, route);                } ,
                         ) ,
                         new Divider(
                           height: 0.1,
                           color: Colors.black,
                         ),
                         new ListTile(
                           title: new Text( "Préférences", style: TextStyle(fontSize:12), ) ,
                           onTap: () {

                             Route route = MaterialPageRoute(builder: (context) =>LoginPage());
                             Navigator.push(context, route);                } ,

                         ) ,
                         new Divider(
                           height: 0.1,
                           color: Colors.black,
                         ),
                         new ListTile(
                             title: new Text( "Déconnection", style: TextStyle(fontSize:12), ) ,
                             onTap: () {
                               Route route = MaterialPageRoute(builder: (context) =>LoginPage());
                               Navigator.push(context, route);
                             }
                         ) ,
                       ],
                     );
                   }

               ),

             ),
           ) ,
        body: Container(
          margin: EdgeInsets.all(15.0),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[

          (widget.note.id != null) ? Text('Modifier les informations') : Text('Ajouter un employé'),
         Padding(
           padding: const EdgeInsets.all(20.0),
           child: new Form(
              key: formKey,
              child: new Column(
              mainAxisSize: MainAxisSize.min,

                children: <Widget>[

                    new Padding(
                    padding: const EdgeInsets.symmetric(horizontal:50, vertical: 5),
                    child: new TextFormField(
                      controller:_nomemployeeController ,
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
                                labelText: "   Nom de l'employé",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  borderSide: new BorderSide(
                                  ),
                                ),
                      ),
                        ),
                  ),
 new Padding(
                    padding: const EdgeInsets.symmetric(horizontal:50, vertical: 5),
                    child: new TextFormField(
                      controller:_fonctionController ,
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
                                labelText: "   Fonction",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  borderSide: new BorderSide(
                                  ),
                                ),
                      ),
                        ),
                  ),
                   new Padding(
                    padding: const EdgeInsets.symmetric(horizontal:50, vertical: 5),
                    child: new TextFormField(
                      controller:_salaireController ,
                       validator: (val) {
                                if(val.length==0) {
                                  return "Votre numero est requis";
                                }else{
                                  return null;
                                }
                              },
                       textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization.words,
  decoration: new InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                                labelText: "   Salaire",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  borderSide: new BorderSide(
                                  ),
                                ),
                      ),
                        ),
                  ),

                ],
              ),
            ),
         ),
              (widget.note.id == null) ?  Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: (widget.note.id != null) ? Text('Modifier') : Text('Ajouter'),
                    onPressed: () {
                      if (widget.note.id != null) {
                        db.updateNote(Employee.fromMap({
                          'id': widget.note.id,
                          'nom': _nomemployeeController.text,
                          'salaire': _salaireController.text,
                          'fonction': _fonctionController.text
                        })).then((_) {
                          Navigator.pop(context, 'update');
                        });
                      }else {
                        checkConnection();

                      }
                    },
                  ),
                ],
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: (widget.note.id != null) ? Text('Modifier') : Text('Ajouter'),
                    onPressed: () {
                      if (widget.note.id != null) {
                        db.updateNote(Employee.fromMap({
                          'id': widget.note.id,
                          'nomemploye': _nomemployeeController.text,
                          'salaire': _salaireController.text,
                          'fonction': _fonctionController.text
                        })).then((_) {
                          Navigator.pop(context, 'update');
                        });
                      }else {
                        checkConnection();

                      }
                    },
                  ),
                  RaisedButton(
                    child: Text('Payer '),
                    onPressed: () {
                      _displayDialog(context);
                      /*
                      var dateajout='${now.day}-${now.month}-${now.year}-${now.hour}-${now.minute}';

    dbSalaire.saveNote(Salaire(_nomemployeeController.text, _salaireController.text, _fonctionController.text, dateajout)).then((_) {
    Navigator.pop(context, 'save');
    });
*/
    }

                  ),
                ],
              ),
          (widget.note.id != null)?      Html(
            data: """
                   <table><td align='center'>SALAIRE</td><td align='center'>Date paiement</td></tr></table>
  """ ,

          ):Text(''),



              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, position) {
                    return Column (children: <Widget>[
                    //  Text(items[position].moispaye),
                      Html(
                        data: """
                   <table><td>${items[position]
                            .salaire} Francs Cfa</td><td>${items[position].datepaiement}</td></tr></table>
  """ ,

                      )
                    ],);
                  },
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Payer les salaires'),
            content:
            Center(
              child: Form(
                key: formKey1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50,0,50,0),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(50,0,50,0),
                          child: Column(
                            children: <Widget>[
                            ],
                          ),
                        ),
                      ),

                      //Text('$regInfo',style: TextStyle(fontSize:20.0,color:Colors.red),),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 12),
                          child: new TextFormField(
                            enabled: false,
                            textAlign: TextAlign.center,
                            textCapitalization: TextCapitalization.words,
                            controller:  _nomemployeeController ,
                            decoration: new InputDecoration(
                              //reduire le height
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
                            validator: (val) {
                              if(val.length==0) {
                                return "Votre nom est requis";
                              }else{
                                return null;
                              }
                            },
                            keyboardType: TextInputType.text,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 12),
                          child: new TextFormField(
                            enabled: false,
                            textAlign: TextAlign.center,
                            textCapitalization: TextCapitalization.words,
                            controller:  _salaireController ,
                            decoration: new InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                              labelText: "   Salaire",
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(20.0),
                                borderSide: new BorderSide(
                                ),
                              ),
                              //fillColor: Colors.green
                            ),
                            validator: (val) {
                              if(val.length==0) {
                                return "Le nom du salon est requis";
                              }else{
                                return null;
                              }
                            },
                            keyboardType: TextInputType.text,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 12),
                          child: new TextFormField(
                            enabled: false,
                            textAlign: TextAlign.center,
                            textCapitalization: TextCapitalization.words,
                            controller:  _fonctionController ,
                            decoration: new InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                              labelText: "   Fonction",
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(20.0),
                                borderSide: new BorderSide(
                                ),
                              ),
                              //fillColor: Colors.green
                            ),
                            validator: (val) {
                              if(val.length==0) {
                                return "Le nom du salon est requis";
                              }else{
                                return null;
                              }
                            },
                            keyboardType: TextInputType.text,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                      ),

                      DateTimePickerFormField(
                        style: TextStyle(color: Colors.black),
                        controller: _moispaye,
                        inputType: InputType.date,
                        format: DateFormat('yyyy-MM'),
                        editable: false,
                        decoration: InputDecoration(
                            labelText: 'Mois à payer',
                            hasFloatingPlaceholder: false
                        ),
                        onSaved: (dt) {
                          DateTime date;
                          setState(() => date = dt);
                          print('Selected date: $date');
                        },
                      ),



                    ],
                  ),
                ),


              ),
            ),

            actions: <Widget>[
              Row(
                children: <Widget>[
                  new FlatButton(

                    child: new Text('Annuler'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  new FlatButton(
                    child: new Text('Payer'),
                    onPressed: () {

                    },
                  ),
                ],
              )
            ],
          );
        });
  }
}
