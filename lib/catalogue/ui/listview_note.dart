import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projetsalon/auths/data/database_helper.dart';
import 'package:projetsalon/auths/models/user.dart';
import 'package:projetsalon/auths/pages/login/login_page.dart';
import 'package:projetsalon/catalogue/model/note.dart';
import 'package:projetsalon/catalogue/ui/note_screen.dart';
import 'package:projetsalon/catalogue/util/database_helper.dart';
import 'package:projetsalon/client-fournisseurs/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:projetsalon/gestion-bilan/main-bilan.dart';
class ListViewCatalogue extends StatefulWidget {
  @override
  _ListViewCatalogueState createState() => new _ListViewCatalogueState();
}
class _ListViewCatalogueState extends State<ListViewCatalogue> {
      final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
 String numero;
 Uint8List image;

      DatabaseHelper dbuser = new DatabaseHelper();
        DatabaseHelperCatalogue db = new  DatabaseHelperCatalogue();
      DatabaseHelperCatalogue dbimageae = new DatabaseHelperCatalogue();
   List<User> them = new List();
    List<CatalogueOff> items = new List();
  
  @override
  void initState() {
    super.initState();
dbuser.getAllUser().then((users) {
      setState(() {
       users.forEach((user) {
          them.add(User.fromMap(user));
        });
      });
    });
  db.getAllNotes().then((notes) {
      setState(() {
       notes.forEach((note) {
          them.add(User.fromMap(note));
        });
      });
    });
    db.getAllNotes().then((notes) {
      setState(() {
        notes.forEach((note) {
          items.add(CatalogueOff.fromMap(note));
          
        });
      });
    });
     
  }
  Future getImage() async{
    DatabaseHelperCatalogue db = new  DatabaseHelperCatalogue();
     db.getAllNotes().then((notes) {
    
    });
    print('Image saved');
  }
 Future<List> getDataProd() async {
    final response = await http.post("http://192.168.8.100/monsalon/catalogue/displayimage.php", body : {
      "numero" :numero,
    });
    return  json.decode(response.body);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'AlexandriaFLF'),
      title: 'Monsalon',
      color: Colors.black,
      home: Scaffold(
       key: _scaffoldKey,
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
          title: Text('Catalogue',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.white,
                leading: new IconButton(iconSize: 30, color:Colors.black87, icon: new Icon(FontAwesomeIcons.bars, size: 15,),
            onPressed: () => _scaffoldKey.currentState.openDrawer()),
        ),
          drawer:Container(
          width: MediaQuery.of(context).size.width*2/3,
          child: Drawer(
            child: ListView.builder(
              itemCount: them.length,
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
                        backgroundColor: Colors.brown.shade800,
                        child: Text('${them[position].username}'.substring(0,1)),
                      ),
                    ),
                  ),
    ),
   new ListTile(
                  title: new Text( "Bilan", style: TextStyle(fontSize:12), ) ,
                  onTap: () {
                    Route route = MaterialPageRoute(builder: (context) =>MainBilan());
                    Navigator.push(context, route);
                    print(numero);
                  } ,
                ) ,
                  new Divider(
                  height: 0.1,
                  color: Colors.black,
                ),
                new ListTile(
                  title: new Text( "Clients fournisseurs", style: TextStyle(fontSize:12), ) ,
                  onTap: (){
                    Route route = MaterialPageRoute(builder: (context) =>LoginPage());
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

                    Route route = MaterialPageRoute(builder: (context) =>LoginPage());
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
    MaterialPageRoute(builder: (context) => Collaborateurs()),             );              } ,
                ) ,
                  new Divider(
                  height: 0.1,
                  color: Colors.black,
                ),
                new ListTile(
                  title: new Text( "Catalogue", style: TextStyle(fontSize:12), ) ,
                    onTap: () {
                      Route route = MaterialPageRoute(builder: (context) =>LoginPage());
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
                    Navigator.pushReplacement(context, route);
                  }
                ) ,
],
        );
              }
             ),

          ),
        ) ,

      body: Builder(
 builder: (BuildContext context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Femmes'),
                ),
                Expanded(
                  flex: 5,
                  child: new FutureBuilder<List>(
        future: getDataProd(),
        builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error);
       return snapshot.hasData
           ?new ItemList(list: snapshot.data,)
           :ListView.builder(
             itemExtent: 100,
             scrollDirection: Axis.horizontal,
             itemCount: items.length,
             itemBuilder: (context, position){
               numero = them[position].numero;
               image = Base64Decoder().convert(items[position].image);
               return Container(
                 child: GestureDetector(
                   onTap: ()=>Navigator.of(context).pop(),
                   child: Card(
                     child:Image.memory(image)
                   ),
                 ),
               );
             },
           );

          },
      ),
                ),
                Text('Enfants'),
                        Expanded(
                  flex: 5,
                  child: new FutureBuilder<List>(
        future: getDataProd(),
        builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error);
       return snapshot.hasData
           ?new ItemList1(list: snapshot.data,)
           :ListView.builder(
         itemExtent: 100,
         scrollDirection: Axis.horizontal,
         itemCount: items.length,
         itemBuilder: (context, position){
           numero = them[position].numero;
           image = Base64Decoder().convert(items[position].image);
           return Container(
             child: GestureDetector(
               onTap: ()=>Navigator.of(context).pop(),
               child: Card(
                   child:Image.memory(image)
               ),
             ),
           );
         },
       );

          },
      ), ),
                Text('Hommes'),
   Expanded(
   flex: 5,
   child: new FutureBuilder<List>(
   future: getDataProd(),
   builder: (context, snapshot){
   if(snapshot.hasError) print(snapshot.error);
   return snapshot.hasData
   ?new ItemList(list: snapshot.data,)
       :ListView.builder(
   itemExtent: 100,
   scrollDirection: Axis.horizontal,
   itemCount: items.length,
   itemBuilder: (context, position){
   numero = them[position].numero;
   image = Base64Decoder().convert(items[position].image);
   return Container(
   child: GestureDetector(
   onTap: ()=>Navigator.of(context).pop(),
   child: Card(
   child:Image.memory(image)
   ),
   ),
   );
   },
   );

   },
   ),
   ),
                Expanded(
                  flex:1,
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, position){
                      numero = them[position].numero;
                      return Column(
                        children: <Widget>[
                        ],
                      );
                    },
                  ),
                )
                /*
                Expanded(
                    flex: 5,
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, position){
                         image = Base64Decoder().convert(items[position].image);
                         Image.memory(image);
                      },
                    )
                ),
                */
              ],
            );
        }
         ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.add),
          onPressed: () {
             Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Catalogue(numero)),
    );
          },
        ),
      ),
    );
  }



  void _navigateToNote(BuildContext context, User note) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Catalogue(numero)),
    );

    if (result == 'update') {
      dbuser.getAllUser().then((notes) {
        setState(() {
          them.clear();
          notes.forEach((note) {
            them.add(User.fromMap(note));
          });
        });
      });
    }
  }

  void _createNewNote(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Catalogue(numero)),
    );

    if (result == 'save') {
      dbuser.getAllUser().then((notes) {
        setState(() {
          them.clear();
          notes.forEach((note) {
            them.add(User.fromMap(note));
          });
        });
      });
    }
  }
}

class ItemList extends StatelessWidget {
 final List list;
 final Uint8List image;
 // ignore: non_constant_identifier_names
 // ignore: non_constant_identifier_names
 ItemList({this.list, this.image});
  @override
  Widget build(BuildContext context) {

    return SizedBox(
          child: new ListView.builder(
            itemExtent: 100,
          scrollDirection: Axis.horizontal,
          itemCount: list==null ? 0 : list.length,
          itemBuilder: (context, i ){
            return Container(
              child: GestureDetector(
                onTap: ()=>Navigator.of(context).pop(),
                child: Card(
                //  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 100),
       // child: new Image.network("http://192.168.8.101/monsalon/catalogue/uploads/${list[i]['image']}",)
       child: CachedNetworkImage(
        imageUrl: "http://192.168.8.100/monsalon/catalogue/uploads/${list[i]['image']}",
        placeholder: (context, url) => new CircularProgressIndicator(),
        errorWidget: (context, url, error) => new Icon(Icons.error),
     ),
                  /*
                  child: new ListTile(
                    title: new Text(" ${list[i]['categorie'] }"),
                    leading: Container(
                      height: 60,
                        width: 55,
                        child: new Image.network("http://192.168.8.101/monsalon/catalogue/uploads/${list[i]['image']}"  )
                        ),
                    subtitle: new Text("Categorie : ${list[i]['categorie']}"
                    ),

                  ),
                  */
                ),
              ),
            );
          }),
    );

  }
}

class ItemList1 extends StatelessWidget {
 final List list;
 // ignore: non_constant_identifier_names
 // ignore: non_constant_identifier_names
 ItemList1({this.list});
  @override
  Widget build(BuildContext context) {

    return SizedBox(
          child: new ListView.builder(
            itemExtent: 100,
          scrollDirection: Axis.horizontal,
          itemCount: list==null ? 0 : list.length,
          itemBuilder: (context, i ){
            return Container(
              child: GestureDetector(
                onTap: ()=>Navigator.of(context).pop(),
                child: Card(
                //  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 100),
       // child: new Image.network("http://192.168.8.101/monsalon/catalogue/uploads/${list[i]['image']}",)
// work with precacheImage


      child:  CachedNetworkImage(
        imageUrl: "http://192.168.8.100/monsalon/catalogue/uploads/${list[i]['image']}",
        placeholder: (context, url) => new CircularProgressIndicator(),
        errorWidget: (context, url, error) => new Icon(Icons.error),
     ),


                  /*
                  child: new ListTile(
                    title: new Text(" ${list[i]['categorie'] }"),
                    leading: Container(
                      height: 60,
                        width: 55,
                        child: new Image.network("http://192.168.8.101/monsalon/catalogue/uploads/${list[i]['image']}"  )
                        ),
                    subtitle: new Text("Categorie : ${list[i]['categorie']}"
                    ),

                  ),
                  */
                ),
              ),
            );
          }),
    );

  }
}

class ItemList2 extends StatelessWidget {
 final List list;
final  Uint8List image;

 // ignore: non_constant_identifier_names
 // ignore: non_constant_identifier_names
 ItemList2({this.list, this.image});
  @override
  Widget build(BuildContext context) {

    return SizedBox(
          child: new ListView.builder(
            itemExtent: 100,
          scrollDirection: Axis.horizontal,
          itemCount: list==null ? 0 : list.length,
          itemBuilder: (context, i ){
            return Container(
              child: GestureDetector(
                onTap: ()=>Navigator.of(context).pop(),
                child: Card(
                //  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 100),
       // child: new Image.network("http://192.168.8.101/monsalon/catalogue/uploads/${list[i]['image']}",)
       child: CachedNetworkImage(
        imageUrl: "http://192.168.8.100/monsalon/catalogue/uploads/${list[i]['image']}",
        placeholder: (context, url) => new CircularProgressIndicator(),
        errorWidget: (context, url, error) => new Image.memory(image),
     ),
                ),
              ),
            );
          }),
    );

  }
}
