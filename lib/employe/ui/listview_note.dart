import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projetsalon/auths/data/database_helper.dart';
import 'package:projetsalon/auths/models/user.dart';
import 'package:projetsalon/auths/pages/login/login_page.dart';
import 'package:projetsalon/catalogue/ui/listview_note.dart';
import 'package:projetsalon/client-fournisseurs/main.dart';
import 'package:projetsalon/depenses/ui/listview_note.dart';
import 'package:projetsalon/employe/model/note.dart';
import 'package:projetsalon/employe/ui/note_screen.dart';
import 'package:projetsalon/employe/util/database_helper.dart';
import 'package:projetsalon/gestion-bilan/main-bilan.dart';
import 'package:projetsalon/prod-materiel/main.dart';

class ListViewEmployee extends StatefulWidget {
  @override
  _ListViewEmployeeState createState() => new _ListViewEmployeeState();
}

class _ListViewEmployeeState extends State<ListViewEmployee> {
  List<Employee> items = new List();
  DatabaseHelperEmployee db = new DatabaseHelperEmployee();
  //List<Salaire> them = new List();
  //DatabaseHelperSalaire dbSalaire = new DatabaseHelperSalaire();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  DatabaseHelper dbUser = new DatabaseHelper();
  List<User> then = new List();
  @override
  void initState() {
    super.initState();
    dbUser.getAllUser().then((users) {
      setState(() {
        users.forEach((user) {
          then.add(User.fromMap(user));
        });
      });
    });
    db.getAllNotes().then((notes) {
      setState(() {
        notes.forEach((note) {
          items.add(Employee.fromMap(note));
        });
      });
    });
    /*
    dbSalaire.getAllNotes().then((notes) {
      setState(() {
        notes.forEach((note) {
          them.add(Salaire.fromMap(note));
        });
      });
    });
    */
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
          title: Text('Employés', style: TextStyle(color: Colors.black),),
          centerTitle: true,
          backgroundColor: Colors.white,
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
                          accountName: Text('${then[position].username}'),
                          accountEmail: Text('${then[position].username}'),
                          currentAccountPicture: Container(
                            child: CircleAvatar(
                              backgroundColor: Colors.brown.shade800,
                              child: Text('${then[position].username}'.substring(0,1)),
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
                          print(then[position].username);
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
        body: Center(
          child: ListView.builder(
              itemCount: items.length ,
              padding: const EdgeInsets.all( 15.0 ) ,
              itemBuilder: (context , position) {
                return Column(
                  children: <Widget>[

                    Divider( height: 2.0 , color: Colors.black , ) ,
                    /*

                      */
                    InkWell(

                      child: Column(
                        children: <Widget>[
                          Padding( padding: EdgeInsets.all( 10.0 ) ) ,
                          /*
                            CircleAvatar(
                              backgroundColor: Colors.blueAccent,
                              radius: 15.0,
                              child: Text(
                                '${items[position].id}',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            */
                          /*
                            IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () => _deleteNote(context, items[position], position)),
                                */
                          Html(
                            data: """
                   <table border='1'><tr><th>${items[position]
                                .nomemploye}</th><th>${items[position]
                                .salaire}<br>Francs Cfa</th><th>${items[position]
                                .fonction}</th></tr></table>
  """ ,

                          ) ,
                        ] ,
                      ) ,

                      onTap: () =>
                          _navigateToNote( context , items[position] ) ,
                    ) ,

                  ] ,
                );
              } ) ,
        ) ,

        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.add),
          onPressed: () => _createNewNote(context),
        ),
      ),
    );
  }

  void _deleteNote(BuildContext context, Employee note, int position) async {
    db.deleteNote(note.id).then((notes) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToNote(BuildContext context, Employee note) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(note)),
    );

    if (result == 'update') {
      db.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Employee.fromMap(note));
          });
        });
      });
    }
  }

  void _createNewNote(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(Employee('', '','','',''))),
    );

    if (result == 'save') {
      db.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Employee.fromMap(note));
          });
        });
      });
    }
  }
}
