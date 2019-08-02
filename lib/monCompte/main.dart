import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projetsalon/auths/models/user.dart';

void main() => runApp(Compte(User('','','','','','','','')));

class Compte extends StatefulWidget {
  final User note;
  Compte(this.note);

  @override
  _CompteState createState() => _CompteState();
}

class _CompteState extends State<Compte> {
  final _formKey1 = GlobalKey<FormState>();
  TextEditingController username ;
  TextEditingController nomsalon ;
  TextEditingController localisation ;
  TextEditingController numero ;
  TextEditingController mdp ;
  TextEditingController lon ;
  TextEditingController lat ;
  @override
  void initState() {
    super.initState();

    username = new TextEditingController(text: widget.note.username);
    nomsalon = new TextEditingController(text: widget.note.nomsalon);
    localisation = new TextEditingController(text: widget.note.localisation);
    numero = new TextEditingController(text: widget.note.numero);


  }


  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Modifier mes informations'),
            content:
            Center(
              child: Form(
                key: _formKey1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                            controller: username ,
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
                            controller: nomsalon ,
                            decoration: new InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                              labelText: "   Nom du salon",
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
                            controller: localisation ,
                            decoration: new InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                              labelText: "   Localisation",
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
                                return "La localistation du salon est requise";
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
                          padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0,12),
                          child: new TextFormField(
                            enabled: false,
                            textAlign: TextAlign.center,
                            textCapitalization: TextCapitalization.words,
                            controller: numero ,
                            decoration: new InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                              labelText: "   Numero",
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
                                return "Votre numero est requis";
                              }else{
                                return null;
                              }
                            },
                            keyboardType: TextInputType.number,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
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
                    child: new Text('Modifier'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ],
          );
        });
  }

  Path getClip(Size size) {
    Path path = Path(); // the starting point is the 0,0 position of the widget.
    path.lineTo(0, size.height); // this draws the line from current point to the left bottom position of widget
    path.lineTo(size.width, size.height); // this draws the line from current point to the right bottom position of the widget.
    path.lineTo(size.width, 0); // this draws the line from current point to the right top position of the widget 
    path.close(); // this closes the loop from current position to the starting point of widget 
    return path;
  }  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Monsalon',
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
          title: Text('Parametres',style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.white,
        ),
        body: Column(children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height/3,
             decoration: BoxDecoration(
        // Box decoration takes a gradient
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            Colors.indigo[800],
            Colors.indigo[700],
            Colors.indigo[600],
            Colors.indigo[400],
          ],
        ),
      ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
Container(
                 height: 120,
                 width: 120,
                 child: InkWell(
                                    child: CircleAvatar(
                                      backgroundColor: Colors.black,
                                      child: Center( child: Text('AK'), ),
                   ),
                   onTap: (){
                     _displayDialog(context);
                   },
                 ),
               ),
            ],
            
            ),
          ),
            Container(
            
            height: MediaQuery.of(context).size.height/3,
              child: ListView(
                children: <Widget>[
                  Center(
                    child: ListTile(
                      leading: Icon(Icons.add),
                      title: Text('informations'),
                      onTap: (){
                        _displayDialog(context);
                      },
                    ),
                  ),
                   ListTile(
                    leading: Icon(Icons.add),
                    title: Text('Abonnements'),
                     onTap: (){
                       _displayDialog(context);

                     },
                  ), ListTile(
                    leading: Icon(Icons.add),
                    title: Text('Pr&féérences'),
                    onTap: (){
                      _displayDialog(context);

                    },
                  ),
                ],
              ),
            ),
        ],),
      ),
    );
  }
}