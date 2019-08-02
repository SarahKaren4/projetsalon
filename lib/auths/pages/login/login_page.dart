import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:projetsalon/auths/data/database_helper.dart';
import 'package:projetsalon/auths/models/user.dart';
import 'package:projetsalon/auths/pages/login/login_presenter.dart';
import 'package:geolocator/geolocator.dart';

class LoginPage extends StatefulWidget {
  
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageContract {
   List<User> items = new List();
  DatabaseHelper db = new DatabaseHelper();
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
    Geolocator geolocator = Geolocator();

  Position userLocation;
  String _username, _password, _nomsalon,_localisation,_numero,_lon,_lat, _img;
  LoginPagePresenter _presenter;

  _LoginPageState() {
    _presenter = new LoginPagePresenter(this);
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _presenter.doLogin(_username, _password,  _nomsalon,_localisation,_numero,_lon,_lat, _img);
      });
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var loginBtn = Padding(
      padding: const EdgeInsets.all(16.0),
      child: new RaisedButton(
        child: new Text("Connexion", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
        onPressed: _submit,
        color: Colors.black,
      ),
    );

    
    var registerBtn = new CupertinoButton(child: new Text("Inscription", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 16)), onPressed: (){
      Navigator.of(context).pushNamed("/register");
    });
    var pswupdateBtn = new CupertinoButton(child: new Text("Mot de passe oublie", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 16)), onPressed: (){
      Navigator.of(context).pushNamed("/register");
    });
    var loginForm = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: new Text(
            "Connectez-vous",
            textScaleFactor: 1.0,
          ),
        ),
        new Form(
          key: formKey,
          child: 
                    new Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.symmetric(horizontal:50, vertical: 2),
                  child: new TextFormField(
                    onSaved: (val) => _numero = val,
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
                      labelText: "   Numero",
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
                    obscureText: true,
                    onSaved: (val) => _password = val,
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      if(val.length==0) {
                        return "Votre mot de passe est requis";
                      }else{
                        return null;
                      }
                    },
                    textAlign: TextAlign.center,
                    textCapitalization: TextCapitalization.words,
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
                  ),
                ),
              ],
            ),
                               
        ),
        loginBtn,
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              registerBtn,
              pswupdateBtn
            ],
          ),
        ),
      ],
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'AlexandriaFLF'),

          title: 'Monsalon',
          color: Colors.black,
          home: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          title: new Text("Connexion", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
       centerTitle: true,
        ),

        key: scaffoldKey,
        body: new Container(
          child: new Center(
            child: loginForm,
          ),
        ),
      ),
    );
  }

  @override
  void onLoginError(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) async {
    // TODO: implement onLoginSuccess
    _showSnackBar(user.toString());
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pushReplacementNamed("/home");
  }
}
