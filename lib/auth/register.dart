import 'package:flutter/material.dart';
import 'package:projetsalon/auth/proprio.dart';
import 'package:projetsalon/auth/dbHelper.dart';
class RegisterPage extends StatefulWidget {



  RegisterPage(this.proprio, this._isNew);
  final Proprio proprio;
  final bool _isNew;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();
  final username =  TextEditingController();
  final prenom =  TextEditingController();
  final nomsalon =  TextEditingController();
  final localisation =  TextEditingController();
  final numero =  TextEditingController();
  final mdp =  TextEditingController();
  final lon = 's';
  final lat = 'd';
  final img = 'a';
 var now = DateTime.now();
  String title;
   bool btnSave;
   bool btnEdit;
   bool btnDelete;
   Future addReccord() async{
   var db =  DbHelper();
  String dateajout='${now.day}-${now.month}-${now.year}-${now.hour}-${now.minute}';
  var proprio = Proprio(username.text,prenom.text,nomsalon.text,localisation.text,numero.text, mdp.text,lon, lat,now.toString(), img ); 
  await db.saveProprio(proprio);

  print('Record saved');
   }
     Future updateReccord() async{
     
   }
   void _SaveData() {
     if(widget._isNew) {
      addReccord();
     }
     else {
updateReccord();
     }
   }
  @override
  Widget build(BuildContext context) {
    if (widget._isNew) {
      title = 'Inscripion';
      btnSave = true;
      btnEdit = false;
      btnDelete = false;
    }

    return MaterialApp(
      title: 'Monsalon',
      color:Colors.black,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        //leading: Image.asset("assets/appbar.png"),
          title: Text(title, style: TextStyle(color: Colors.black),),
        ),
        body: ListView(
          children: <Widget>[
        Row(
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
         CreateButton(icon: Icons.save, enable:btnSave, onpress: _SaveData ),
         CreateButton(icon: Icons.edit, enable:btnEdit, onpress: (){}),
         CreateButton(icon: Icons.delete, enable:btnDelete, onpress: (){}),
          ],
        ),
                TextFormField(
                  controller: username,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'nom'
                  ),
                ),
TextFormField(
                  controller: prenom,
                  decoration: InputDecoration(
                    hintText: 'prenom'
                  ),
                ),
               TextFormField(
                  controller: nomsalon,
                  decoration: InputDecoration(
                    hintText: 'Nom du salon'
                  ),
                ),
                TextFormField(
                  controller: localisation,
                  decoration: InputDecoration(
                    hintText: 'localisation'
                  ),
                ), 
               TextFormField(
                  controller: numero,
                  decoration: InputDecoration(
                    hintText: 'numero'
                  ),
                ), 
                TextFormField(
                  controller: mdp,
                  decoration: InputDecoration(
                    hintText: 'Mot de passe'
                  ),
                ),
          ],

        ),
        ),
      );
  }
}




class CreateButton extends StatelessWidget {
  final IconData icon;
  final bool enable;
  final onpress;
  CreateButton({this.icon, this.enable, this.onpress})
  ;
  @override
  Widget build(BuildContext context) {
   return Container(
decoration: BoxDecoration(
  shape: BoxShape.circle, color: enable?
    Colors.black
    : Colors.grey,
),
     child: IconButton(icon: Icon(icon), onPressed: (){
     if (enable) {
       onpress();
     }
     }
     ),
   );
  }
}
