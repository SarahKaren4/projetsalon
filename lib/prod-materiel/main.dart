import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projetsalon/auths/data/database_helper.dart';
import 'package:projetsalon/auths/models/user.dart';
import 'package:projetsalon/auths/pages/login/login_page.dart';
import 'package:projetsalon/catalogue/ui/listview_note.dart';
import 'package:projetsalon/client-fournisseurs/main.dart';
import 'package:projetsalon/depenses/ui/listview_note.dart';
import 'package:projetsalon/gestion-bilan/main-bilan.dart';
import 'package:projetsalon/prod-materiel/materiel/ui/listview_note.dart';
import 'package:projetsalon/prod-materiel/produit/ui/listview_note.dart';

class MainPersistentTabBar extends StatefulWidget {
 
 
  @override
  _MainPersistentTabBarState createState() => _MainPersistentTabBarState();
}

class _MainPersistentTabBarState extends State<MainPersistentTabBar> {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

    DatabaseHelper db = new DatabaseHelper();
   List<User> items = new List();
 @override
  void initState() {
    super.initState();

    db.getAllUser().then((users) {
      setState(() {
       users.forEach((user) {
          items.add(User.fromMap(user));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
debugShowCheckedModeBanner:false,
      theme: ThemeData(fontFamily: 'AlexandriaFLF',),
color: Colors.black,
      title: 'Monsalon',
          home: DefaultTabController(  
          length: 2,
          child: Scaffold(
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
                 leading: new IconButton(iconSize: 30, color:Colors.black87, icon: new Icon(FontAwesomeIcons.bars, size: 15,),
            onPressed: () => _scaffoldKey.currentState.openDrawer()),
              title:Text('Produits/Materiel',style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),),
              centerTitle: true,
              backgroundColor: Colors.white,
              bottom: TabBar(
                labelColor: Colors.black,
                labelStyle: TextStyle(fontSize: 14),
                tabs: [
                  Tab(icon: Icon(FontAwesomeIcons.productHunt), text: 'Materiels'),
                  Tab(icon: Icon(Icons.directions_transit), text: "Produits"),
                ],
              ),
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
                    accountName: Text('${items[position].username}'),
                    accountEmail: Text('${items[position].username}'),
                    currentAccountPicture: Container(
                      child: CircleAvatar(
                        backgroundColor: Colors.brown.shade800,
                        child: Text('${items[position].username}'.substring(0,1)),
                      ),
                    ),
                  ),
    ),
   new ListTile(
                  title: new Text( "Bilan", style: TextStyle(fontSize:12), ) ,
                  onTap: () {
                    Route route = MaterialPageRoute(builder: (context) =>MainBilan());
                    Navigator.push(context, route);
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
                    print(items[position].username);
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
            body: TabBarView(
              children: [
                ListViewNote(),
                ListViewProduit(),

              ],
            ),
          ),
        ),
    );
  }
}
