import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:projetsalon/auths/data/database_helper.dart';
import 'package:projetsalon/auths/models/user.dart';
import 'package:projetsalon/auths/pages/home_page.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override


  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'AlexandriaFLF'),
color: Colors.black,
      title: 'Monsalon',
      debugShowCheckedModeBanner:false,

      home: RegisterPage(title: 'Flutter Home Page'),


    );
  }
}
// ignore: non_constant_identifier_names

class RegisterPage extends StatefulWidget {

  RegisterPage({Key key, this.title}) : super(key: key);
  final String title;

  @override

  _RegisterPageState createState() => _RegisterPageState();
}
final _formKey1 = GlobalKey<FormState>();

class _RegisterPageState extends State<RegisterPage> {
  Geolocator geolocator = Geolocator();

  Position userLocation;
  //Localisation
  String phpMsg;
  String regInfo;
   double longitude;
  double latitude;
  TextEditingController username = new TextEditingController();
  TextEditingController nomsalon = new TextEditingController();
  TextEditingController localisation = new TextEditingController();
  TextEditingController numero = new TextEditingController();
  TextEditingController mdp = new TextEditingController();
  TextEditingController lon = new TextEditingController();
  TextEditingController lat = new TextEditingController();
  bool  _agreedToTOS = false;
  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  



//Validation
  // ignore: unused_element
 Future<void> _success(BuildContext context) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Inscription'),
            content: const Text(' Vous ètes bien connectés'),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                 
                  Route route = MaterialPageRoute(builder: (context) => HomePage());
                  Navigator.push(context, route);

                },
              ),
            ],
          );
        },
      );
    }

    Future<void> _fail(BuildContext context) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Inscription'),
            content: const Text(' Inscription échouée, rééssayez!'),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  sendData() async{
    final response = await http.post("http://192.168.8.100/monsalon/auths/index.php", body:{
      "nom":username.text,
      "nomsalon":nomsalon.text,
      "localisation":localisation.text,
      "numero":numero.text,
      "mdp":mdp.text,
      "lon":longitude.toString(),
      "lat":latitude.toString(),
    });
   //---- Info -------
    phpMsg =  response.body;
    setState(() {
        var datauser = json.decode(response.body);
        if (datauser.length == null){
          _fail(context);
          print(datauser.length);
          print(datauser);
          
        }
        else{
    print(datauser.length);
    _success(context);
    deLete();
 addReccord();
           print(datauser);

        }
      });


  }

  Future addReccord() async{
     DatabaseHelper db = new DatabaseHelper();
  var user = User( username.text,mdp.text,nomsalon.text,localisation.text,numero.text,'','',''); 
  await db.saveUser(user);
  print('Record saved');
   }
 Future deLete() async{
     DatabaseHelper db = new DatabaseHelper();
  var user = User( username.text,mdp.text,nomsalon.text,localisation.text,numero.text,'','',''); 
  await db.deleteAll();
  print('Record deleted');
   }
  @override
//fonction localisation

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Padding(
          padding: const EdgeInsets.fromLTRB(50 , 0, 0, 0),
          child: Text('Monsalon', style: TextStyle(color: Colors.black),),

        ),
        bottom: new PreferredSize(
            child: new Container(
              color: Colors.black,
              padding: const EdgeInsets.all(0.5),
            ),
            preferredSize: const Size.fromHeight(0.5)
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[

        ],
      ),
      body:
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
                Text(
                  'Enregistrez-vous',style: TextStyle(fontSize:15.0,color:Colors.black, fontFamily: 'Roboto'),
                ),
                //Text('$regInfo',style: TextStyle(fontSize:20.0,color:Colors.red),),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 12),
                    child: new TextFormField(
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
                Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0,12),
                    child: new TextFormField(
                      textAlign: TextAlign.center,
                      textCapitalization: TextCapitalization.words,
                      controller: mdp ,
                      decoration: new InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                        labelText: "   Mot de passe",
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
                          return "Un mot de passe est requis";
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                        value: _agreedToTOS,
                        onChanged: _setAgreedToTOS,
                      ),
                      GestureDetector(
                        onTap: () => _setAgreedToTOS(!_agreedToTOS),
                        child: const Text(
                          'I agree to the Terms of Services \n and Privacy Policy',
                        ),
                      ),
                    ],
                  ),
                ),
                new Row(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: SizedBox(
                        height: 95,
                        width: 95,
                        child: RaisedButton(
                          child: const Text(
                            'Valider',
                            style: TextStyle(fontSize:20.0,color:Colors.white), ),
                          shape: StadiumBorder(),
                          color: Colors.black,
                          onPressed: (){
                            if (_formKey1.currentState.validate()) {
                              _getLocation().then((value) {
                                setState(() {
                                  userLocation = value;
                                  longitude = userLocation.longitude;
                                  latitude = userLocation.latitude;
                                });
                              });
                              print(longitude);
                              print(latitude);//checkConnection();
                               _formKey1.currentState.save();
                               //print(longitude);
                                sendData();
/*
                              username.clear();
                              nomsalon.clear();
                              localisation.clear();
                              numero.clear();
                              mdp.clear();
                              */
                              //print(userLocation.latitude);

                            }
                          },
                        ),

                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),


        ),
      ),


    );


  }


  checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
if (connectivityResult == ConnectivityResult.mobile) {
sendData();
} else if (connectivityResult == ConnectivityResult.wifi) {
sendData();
}
else if (connectivityResult == ConnectivityResult.wifi) 
{
}
  }
 

  Future<Position> _getLocation() async {
    var currentLocation;
    try {
      currentLocation = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }
}
