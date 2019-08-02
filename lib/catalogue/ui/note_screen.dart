import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projetsalon/auths/data/database_helper.dart';
import 'package:projetsalon/auths/models/user.dart';
import 'package:projetsalon/auths/pages/login/login_page.dart';
import 'package:projetsalon/catalogue/model/note.dart';
import 'package:projetsalon/catalogue/ui/listview_note.dart';
import 'package:projetsalon/catalogue/util/database_helper.dart';
import 'package:projetsalon/client-fournisseurs/main.dart';
import 'dart:io';
import 'package:async/async.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:convert';

import 'package:projetsalon/depenses/ui/listview_note.dart';
import 'package:projetsalon/prod-materiel/main.dart';

class Catalogue extends StatefulWidget {
 final String numero;
 Catalogue( this.numero);
  @override
  State<StatefulWidget> createState() => new _CatalogueState();
}

class _CatalogueState extends State<Catalogue> {
  TextEditingController _nomprestationController = TextEditingController();
  // ignore: unused_field
  TextEditingController _categorieController = TextEditingController();
    TextEditingController _textFieldController = TextEditingController();

  File _image;
  Future getImageGallery() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
  setState(() {
   _image = imageFile ;
  });
  
  }
  
  Future getImageCamera() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
  setState(() {
   _image = imageFile ;
  });
  
  }
  
  List _cities =
  [ "Enfant", "Femme",];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCity;
   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Catalogue> items = new List();

     DatabaseHelper dbuser = new DatabaseHelper();
   List<User> them = new List();
 String numsalon='';
_displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Ajouter une image'),
            content: 
            Container(
              padding: EdgeInsets.all(10),
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
InkWell(
  child: Column(
    children: <Widget>[
      Icon(FontAwesomeIcons.image),
      Text('Gallerie')
    ],
  ),
  onTap: (){
    getImageGallery();
  },
),
InkWell(
  child: Column(
    children: <Widget>[
      Icon(FontAwesomeIcons.camera),
      Text('Camera')
    ],
  ),
  onTap: (){
    getImageCamera();
  },
),
       ],
              ),
            )
            ,
            actions: <Widget>[
              new FlatButton(
                child: new Text('Annuler'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

 var now = DateTime.now();

  @override
  void initState() {
    super.initState();
_dropDownMenuItems = getDropDownMenuItems();
    _currentCity = _dropDownMenuItems[0].value;
    super.initState();
/*
    _nomprestationController = new TextEditingController(text: widget.note.nom);
    _categorieController = new TextEditingController(text: widget.note.fonction);
     _salaireController = new TextEditingController(text: widget.note.salaire);
    _moispayeController = new TextEditingController(text: widget.note.moispaye);
*/
dbuser.getAllUser().then((users) {
      setState(() {
       users.forEach((user) {
          them.add(User.fromMap(user));
        });
      });
    });
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
    return MaterialApp(
theme:ThemeData(
    fontFamily: 'AlexandriaFLF'
),
      home: Scaffold(
               key: _scaffoldKey,
        appBar: AppBar(title: Text('Ajout image', style: TextStyle(color: Colors.black),),
          centerTitle: true,
          backgroundColor: Colors.white,
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
                  leading: new IconButton(iconSize: 30, color:Colors.black87, icon: new Icon(FontAwesomeIcons.bars, size: 15,),
              onPressed: () => _scaffoldKey.currentState.openDrawer()),

        ),
         drawer:Container(
            width: MediaQuery.of(context).size.width*2/3,
            child: Drawer(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, position) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,

children: <Widget>[
      Container(
        height: MediaQuery.of(context).size.height>1000?MediaQuery.of(context).size.height/3.7:MediaQuery.of(context).size.height/2,
        child: UserAccountsDrawerHeader(
                      decoration: BoxDecoration(color: Colors.white),
                      accountName: Text('${them[position].username}'),
                      accountEmail: Text('${them[position].username}'),
                      currentAccountPicture: Container(
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Text('${them[position].username}'.substring(0,1)),
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
               Column(
                children: <Widget>[
                 Container(
                   height: 120,
                   width: 120,
                   child: InkWell(
                                      child: CircleAvatar(
                                        backgroundColor: Colors.black,
                                        child: Center(child: _image==null
                ? new Text("No image",style: TextStyle(color: Colors.white),)
                : new Image.file(_image,),
                ),
                     ),
                     onTap: (){
                       _displayDialog(context);
                     },
                   ),
                 ),

                ],
          ),

              TextField(
                controller: _nomprestationController,
                decoration: InputDecoration(labelText: 'Nom'),
              ),
              Padding(padding: new EdgeInsets.all(5.0)),
             new Padding(
                  padding: const EdgeInsets.symmetric(horizontal:50, vertical: 5),
                  child:  new DropdownButton(
                value: _currentCity,
                items: _dropDownMenuItems,
                onChanged: changedDropDownItem,
              )
                ),
                Padding(padding: new EdgeInsets.all(5.0)),

              Padding(padding: new EdgeInsets.all(5.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                   RaisedButton(
                    child: Text('Ajouter'),
                            onPressed: () {
upload(_image);
Navigator.of(context).pop();

                            }

                  ),

                ],
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
  Future addImage() async{
    DatabaseHelperCatalogue db = new  DatabaseHelperCatalogue();
    var note = CatalogueOff( _nomprestationController.text, _currentCity,base64Encode(_image.readAsBytesSync()));
    await db.saveNote(note);
    print('Image saved');
  }
  Future upload(File  imageFile) async {
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var url= Uri.parse("http://192.168.8.100/monsalon/catalogue/addImg.php");

    var request = new http.MultipartRequest("POST", url);

    var multipartfile = new http.MultipartFile("image", stream, length, filename: basename(imageFile.path));
    request.fields['nomprestation']=_nomprestationController.text;
    request.fields['categorie']=_currentCity;
    request.fields['numero']=widget.numero;
    request.files.add(multipartfile);
    var response = await request.send();
    if (response.statusCode==200) {
      addImage();
      print("uploaded");
    }
    else {
      print("echec");
    }


  }
}
