import 'package:flutter/material.dart';
import 'package:projetsalon/auth/dbHelper.dart';
import 'package:projetsalon/auth/proprio.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Monsalon',
      color: Colors.black,

    );
  }
}

class ProprioPage extends StatefulWidget {
  ProprioPage(this.proprio, this._isNew,  );
  final Proprio proprio;
  final bool _isNew;
 


  @override

  _ProprioPageState createState() => _ProprioPageState();
}
class _ProprioPageState extends State<ProprioPage> {
  Proprio _proprio;
  String title;
  bool btnSave = false;
   bool btnEdit = true;
   bool btnDelete = true;
   Proprio proprio;
  final _formKey = GlobalKey<FormState>();
final nom = TextEditingController();
final prenom = TextEditingController();
final nomsalon = TextEditingController();
final localisation = TextEditingController();
final numero = TextEditingController();
final mdp = TextEditingController();
final img = '';
final lon= 'a';
final lat = 'a';
 var now = DateTime.now();
 bool _enabledTextfield = true;
Future addProprio() async {
  var db = new DbHelper();
  var dateajout='${now.day}-${now.month}-${now.year}-${now.hour}-${now.minute}';
 var proprio = Proprio(nom.text,prenom.text,nomsalon.text,localisation.text,numero.text, mdp.text,lon.toString(),lat.toString(),dateajout, img );
  await db.saveProprio(proprio);
  print('Record saved');

}
Future updateProprio() async{
  var db = new DbHelper();
    var dateajout='${now.day}-${now.month}-${now.year}-${now.hour}-${now.minute}';
  var proprio = Proprio(nom.text,prenom.text,nomsalon.text,localisation.text,numero.text, mdp.text,lon.toString(),lat.toString(),dateajout, img );
//proprio.setProprioId(this.proprio.id_boutique);
await db.updateProprio(proprio);
  print(_proprio.id_boutique);
}

void _saveProprio()  {
  if(widget._isNew) {
    addProprio();

  }
  else {
    updateProprio();
  }



  Navigator.of(context).pop();
}
  void _editProprio() {
    setState(() {
      _enabledTextfield = true;
      btnSave =true;
      btnEdit = false;
      btnDelete = false;
      title = 'edit';
    });
  }
  @override
  void initState() {
    if(widget.proprio!=null) {
_proprio = widget.proprio;
nom.text = _proprio.nom;
prenom.text = _proprio.prenom;
nomsalon.text = _proprio.nomsalon;
localisation.text = _proprio.localisation;
numero.text = _proprio.numero;
mdp.text = _proprio.mdp;
title= "Add data";
_enabledTextfield = false;
    }
    super.initState();
  }
 @override

  Geolocator geolocator = Geolocator();
  Position userLocation;
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
  
 

  Widget build(BuildContext context) {
if(widget._isNew) {
  title="New note";
  btnSave = true;
  btnEdit = false;
  btnDelete = false;
}

    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.white,
         title: Text(title, style: TextStyle(color: Colors.black),),
         elevation: 0.0,
         actions: <Widget>[
           IconButton(
             onPressed: ()=>Navigator.pop(context),
             icon: Icon(Icons.close), color: Colors.black,)
         ],
      ),
     body: ListView(
       children: <Widget>[
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: <Widget>[
CreateButton(icon: Icons.save, enable:btnSave , onpress: _saveProprio, ),
CreateButton(icon: Icons.edit, enable:btnEdit , onpress: _editProprio ,),
CreateButton(icon: Icons.delete, enable:btnDelete , onpress: (){},) 
           ],
         ),
         Form(
           key: _formKey,
           child: Column(
             children: <Widget>[
 Padding(
   padding: EdgeInsets.all(40.0),
    child: Column(
      children: <Widget>[
    Padding(
      padding: const EdgeInsets.all(6.0),
      child: new TextFormField(
        enabled: _enabledTextfield,
                                 textAlign: TextAlign.center,
                                    textCapitalization: TextCapitalization.words,
                                    controller: nom ,
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
    Padding(
      padding: const EdgeInsets.all(6.0),
      child: new TextFormField(
        enabled: _enabledTextfield,

        textAlign: TextAlign.center,
                                    textCapitalization: TextCapitalization.words,
                                    controller: prenom ,
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
       Padding(
      padding: const EdgeInsets.all(6.0),
      child: new TextFormField(
        enabled: _enabledTextfield,
        textAlign: TextAlign.center,
                                    textCapitalization: TextCapitalization.words,
                                    controller: nomsalon ,
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
      Padding(
      padding: const EdgeInsets.all(6.0),
      child: new TextFormField(
        enabled: _enabledTextfield,

        textAlign: TextAlign.center,
                                    textCapitalization: TextCapitalization.words,
                                  controller: localisation ,
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
      Padding(
      padding: const EdgeInsets.all(6.0),
      child: new TextFormField(
        enabled: _enabledTextfield,

        textAlign: TextAlign.center,
                                    textCapitalization: TextCapitalization.words,
                                    controller: numero ,
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
      Padding(
      padding: const EdgeInsets.all(6.0),
      child: new TextFormField(
        enabled: _enabledTextfield,

        textAlign: TextAlign.center,
                                    textCapitalization: TextCapitalization.words,
                                    controller: mdp ,
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
  
     ],
    ),
 ),

 
             ],
           ),
         )
       ],
      
     ),
         );
  }
}
class CreateButton extends StatelessWidget {
  final IconData icon;
  final bool enable;
  final onpress;
  CreateButton({this.icon,this.enable,this.onpress});
  @override
 
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: enable?
        Colors.green : Colors.red
        ),
        child: IconButton(
          icon: Icon(icon),
          color: Colors.white,
          iconSize: 18,
          onPressed:() {
            if (enable) {
              onpress();
            }
          },
        ),

    );
    
  }}
