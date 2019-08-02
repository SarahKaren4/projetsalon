import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projetsalon/auths/data/database_helper.dart';
import 'package:projetsalon/auths/models/user.dart';
import 'package:projetsalon/auths/pages/login/login_page.dart';
import 'package:projetsalon/catalogue/ui/listview_note.dart';
import 'package:projetsalon/client-fournisseurs/main.dart';
import 'package:projetsalon/depenses/ui/listview_note.dart';
import 'package:projetsalon/gestion-bilan/main-bilan.dart';
import 'package:projetsalon/gestion-bilan/ventes-par-jour.dart';
import 'package:projetsalon/monCompte/main.dart';
import 'package:projetsalon/prod-materiel/main.dart';
import 'package:projetsalon/recettes/prestation/model/note.dart';
import 'package:projetsalon/recettes/prestation/ui/listview_note_jour.dart';
import 'package:projetsalon/recettes/prestation/util/database_helper.dart';
import 'package:projetsalon/recettes/vente/model/note.dart';
import 'package:projetsalon/recettes/vente/ui/listview_note_jour.dart';
import 'package:projetsalon/recettes/vente/util/database_helper.dart';
class BilanParJour extends StatefulWidget {
  String numero;
  BilanParJour({this.numero});
  @override
  _BilanParJourState createState() => new _BilanParJourState();
}

class _BilanParJourState extends State<BilanParJour> {

  double _totalVentes;
  double _totalPrestation;
  double _total ;
  String numero;
  Future _calcTotal() async{
    double totalvente = (await dbVente.calculateTotal())[0]['Total'];
    double totalprestation = (await dbPrestation.calculateTotal())[0]['Total'];
    print('Total vente: $totalvente');
    //print('Total prestation: $totalprestation');
    setState(() =>
    _totalVentes = totalvente
    );

    setState(() =>
    _totalPrestation = totalprestation
    );

    setState(() =>
    _total = totalprestation + totalvente
    );

  }

  List<User> items = new List();
  List<Prestation> presta = new List();
  int nbVente;
  int ventesJour;
  int PrestaJour;
  List<Vente> ventes = new List();
  DatabaseHelper db = new DatabaseHelper();
  DbHelperVente dbVente = new DbHelperVente();
  DbHelperPrestation dbPrestation = new  DbHelperPrestation();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    dbVente.getCountNow().then((result) {
      print(result);
      setState(() {
        ventesJour = result;
      });
    });
    dbPrestation.getCountNow().then((result) {
      print(result);
      setState(() {
        PrestaJour = result;
      });
    });
    dbVente.getAllNotes().then((notes) {
      setState(() {
        notes.forEach((note) {
          ventes.add(Vente.fromMap(note));
          nbVente = ventes.length;
        });

      });
    });
    dbVente.calculateTotal().then((notes) {
      setState(() {
        notes.forEach((note) {
          ventes.add(Vente.fromMap(note));
        });
      });
    });
    dbPrestation.getAllNotes().then((notes) {
      setState(() {
        notes.forEach((note) {
          presta.add(Prestation.fromMap(note));
        });
      });
    });
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
      theme: ThemeData(fontFamily: 'AlexandriaFLF'),
      debugShowCheckedModeBanner: false,
      title: 'Monsalon',
      color: Colors.black,
      home: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            leading: new IconButton(iconSize: 30, color:Colors.black87, icon: new Icon(FontAwesomeIcons.bars, size: 15,),
                onPressed: () => _scaffoldKey.currentState.openDrawer()),
            title: Text('Bilan journalier', style: TextStyle(fontFamily: 'AlexandriaFLF', fontWeight: FontWeight.bold, color: Colors.black),),
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
                          height: MediaQuery.of(context).size.height>1000?MediaQuery.of(context).size.height/4.5:MediaQuery.of(context).size.height/4,
                          child: UserAccountsDrawerHeader(
                            decoration: BoxDecoration(color: Colors.white),
                            accountName: Text('${items[position].username}'),
                            accountEmail: Text('${items[position].username}'),
                            currentAccountPicture: Container(
                              child: CircleAvatar(
                                backgroundColor: Colors.brown.shade800,
                                child: Text('${items[position].username.substring(0,1)}'),
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

                            Route route = MaterialPageRoute(builder: (context) =>Compte(User(items[position].username,'',items[position].nomsalon,items[position].localisation,items[position].numero,'','','')));
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
          body:
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: <Widget>[

                Expanded(
                  child:  GridView.count(
                    childAspectRatio: 2,
                    primary: false,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2.0,
                    crossAxisCount: 1,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                        child:   Container(
                          child: RaisedButton(

                            elevation: 5,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                            onPressed: (){
                              _calcTotal();
                              Navigator.of(context).push(       MaterialPageRoute(builder: (context) => MainPersistentTabBar()),             );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text(
                                    _total.toString(), style: TextStyle(fontFamily: 'AlexandriaFLF', fontWeight: FontWeight.bold),),

                                  Column(
                                    children: <Widget>[
                                      Text('Chiffre d\'affaires', style: TextStyle(fontFamily: 'AlexandriaFLF', fontWeight: FontWeight.bold),),
                                      CircleAvatar(
                                        backgroundColor: Colors.black,
                                        radius: 25.0,
                                        child: Icon(FontAwesomeIcons.box,size: 18,color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                            color: Colors.white,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                Expanded(
                  child:  GridView.count(
                    childAspectRatio: 2,
                    primary: false,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2.0,
                    crossAxisCount: 2,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                        child:   Container(
                          child: RaisedButton(

                            elevation: 5,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                            onPressed: (){
                              _calcTotal();
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListViewVenteJour()),             );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text('Ventes', style: TextStyle(fontFamily: 'AlexandriaFLF', fontWeight: FontWeight.bold),),
                                CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 25.0,
                                  child: Text(ventesJour.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),)
                                ),

                              ],
                            ),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                        child:   Container(
                          child: RaisedButton(

                            elevation: 5,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                            onPressed: (){
                              _calcTotal();
                              Navigator.of(context).push(       MaterialPageRoute(builder: (context) => ListViewPrestationJour()),             );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text('Prestations', style: TextStyle(fontFamily: 'AlexandriaFLF', fontWeight: FontWeight.bold),),
                                CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 25.0,
                                    child: Text(PrestaJour.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),)

                                ),
                              ],
                            ),
                            color: Colors.white,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            ),
          )
      ),
    );
  }






}
