import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:projetsalon/auths/data/database_helper.dart';
import 'package:projetsalon/auths/models/user.dart';
import 'package:projetsalon/auths/pages/login/login_page.dart';
import 'package:projetsalon/catalogue/ui/listview_note.dart';
import 'package:projetsalon/client-fournisseurs/main.dart';
import 'package:projetsalon/depenses/ui/listview_note.dart';
import 'package:projetsalon/gestion-bilan/main-bilan.dart';
import 'package:projetsalon/monCompte/main.dart';
import 'package:projetsalon/prod-materiel/main.dart';
import 'package:projetsalon/recettes/prestation/model/note.dart';
import 'package:projetsalon/recettes/prestation/util/database_helper.dart';
import 'package:projetsalon/recettes/vente/model/note.dart';
import 'package:projetsalon/recettes/vente/util/database_helper.dart';
class ListViewPrestationJour extends StatefulWidget {
  @override
  _ListViewPrestationJourState createState() => new _ListViewPrestationJourState();
}

class _ListViewPrestationJourState extends State<ListViewPrestationJour> {
  List<Prestation> items = new List();
  List<User> userst = new List();

  DbHelperPrestation db = new DbHelperPrestation();
  DatabaseHelper dbUser = new DatabaseHelper();

  String now = DateFormat("dd-MM-yyyy").format(DateTime.now()).toString();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String nb='';
  @override
  void initState() {
    super.initState();
    dbUser.getAllUser().then((users) {
      setState(() {
        users.forEach((user) {
          userst.add(User.fromMap(user));
        });
      });
    });
    db.getAllNotes().then((notes) {
      setState(() {
        notes.forEach((note) {
          items.add(Prestation.fromMap(note));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'AlexandriaFLF'),
      debugShowCheckedModeBanner: false,
      title: 'Monsalon',
      home: Scaffold(
        appBar: AppBar(
          leading: new IconButton(iconSize: 30, color:Colors.black87, icon: new Icon(FontAwesomeIcons.bars, size: 15,),
              onPressed: () => _scaffoldKey.currentState.openDrawer()),

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
          title: Text( 'Prestations' , style: TextStyle(
              color: Colors.black , fontWeight: FontWeight.bold ) , ) ,
          centerTitle: true ,
          backgroundColor: Colors.white ,
        ) ,
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
                        height: MediaQuery.of(context).size.height>1000?MediaQuery.of(context).size.height/4.5:MediaQuery.of(context).size.height/4,
                        child: UserAccountsDrawerHeader(
                          decoration: BoxDecoration(color: Colors.white),
                          accountName: Text('${userst[position].username}'),
                          accountEmail: Text('${userst[position].username}'),
                          currentAccountPicture: Container(
                            child: CircleAvatar(
                              backgroundColor: Colors.brown.shade800,
                              child: Text('${userst[position].username.substring(0,1)}'),
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
                          print(userst[position].username);
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

                          Route route = MaterialPageRoute(builder: (context) =>Compte(User(userst[position].username,'',userst[position].nomsalon,userst[position].localisation,userst[position].numero,'','','')));
                          Navigator.push(context, route);} ,
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
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text ('Prestations du $now', style: TextStyle(fontWeight: FontWeight.w900, ),),
            ),
            Html(
              data: """
                       <table border='1'><tr><th>Prestation</th><th>Client</th><th>Cout</th></tr></tr></table>
  """, ),
            Expanded(
              child: ListView.builder(
                  itemCount: items.length,
                  padding: const EdgeInsets.all(15.0),
                  itemBuilder: (context, position) {


                    return Column(

                      children: <Widget>[
                        Divider(height: 5.0),
                        InkWell(
                          child: Column(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.all(1.0)),
                              Html(
                                data: """
                       <table border='1'><tr><th>${items[position].nomprestation}</th><th>${items[position].nomclient}</th><th>${items[position].cout}<br>Francs Cfa</th></tr></tr></table>
  """, ),

                            ],
                          ),
                         // onTap: () => _navigateToNote(context, items[position]),
                        ),

                      ],
                    );
                  }),
            ),
          ],
        ),

      ),
    );
  }

  void _deleteNote(BuildContext context, Vente note, int position) async {
    db.deleteNote(note.id).then((notes) {
      setState(() {
        items.removeAt(position);
      });
    });
  }
/*
  void _navigateToNote(BuildContext context, Vente note) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(note)),
    );

    if (result == 'update') {
      db.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Vente.fromMap(note));
          });
        });
      });
    }
  }
  */
/*
  void _createNewNote(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(Vente('', '','','','',''))),
    );

    if (result == 'save') {
      db.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Vente.fromMap(note));
          });
        });
      });
    }
  }
  */
}
