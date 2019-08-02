import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:projetsalon/auths/data/database_helper.dart';
import 'package:projetsalon/auths/models/user.dart';
import 'package:projetsalon/auths/pages/login/login_page.dart';
import 'package:projetsalon/catalogue/ui/listview_note.dart';
import 'package:projetsalon/client-fournisseurs/main.dart';
import 'package:projetsalon/depenses/ui/listview_note.dart';
import 'package:projetsalon/gestion-bilan/fournisseurs-mensuels/mois.dart';
import 'package:projetsalon/gestion-bilan/prestations-mensuelles/mois.dart';
import 'package:projetsalon/gestion-bilan/ventes-mensuelles/mois.dart';
import 'package:projetsalon/gestion-bilan/ventes-par-mois%20copy%202.dart';
import 'package:projetsalon/monCompte/main.dart';
import 'package:projetsalon/prod-materiel/main.dart';
import 'package:projetsalon/recettes/prestation/model/note.dart';
import 'package:projetsalon/recettes/prestation/util/database_helper.dart';
import 'package:projetsalon/recettes/vente/model/note.dart';
import 'package:projetsalon/recettes/vente/util/database_helper.dart';

import 'depenses-mensuelles/mois.dart';
class MainBilan extends StatefulWidget {
  String numero;
  MainBilan({this.numero});
  @override
  _MainBilanState createState() => new _MainBilanState();
}

class _MainBilanState extends State<MainBilan> {

  double _totalVentes;
  double _totalPrestation;
  double _total ;
double totaux;
String numero;
int ventesJour;
int prestationJour;
int CoutVentes;
int CoutPrestation;
Future _calcTotal() async{
  double totalvente = (await dbVente.calculateTotal())[0]['Total'];
  double totalprestation = (await dbPrestation.calculateTotal())[0]['Total'];
  print('Total vente: $totalvente');
  print('Total prestation: $totalprestation');
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
  List<Vente> ventes = new List();
  DatabaseHelper db = new DatabaseHelper();
  DbHelperVente dbVente = new DbHelperVente();
   DbHelperPrestation dbPrestation = new  DbHelperPrestation();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    dbVente.getAllNotes().then((notes) {
      setState(() {
       notes.forEach((note) {
          ventes.add(Vente.fromMap(note));
        });
      });
    });
  dbVente.getSumOfAll().then((result) {
      print(result);
      setState(() {
        CoutVentes = result;
      });
    });
      dbVente.getSumOfAll().then((result) {
      print(result);
      setState(() {
        CoutPrestation = result;
      });
    });
    dbVente.getCount().then((result) {
      print(result);
      setState(() {
        ventesJour = result;
      });
    });
    dbPrestation.getCount().then((result) {
      print(result);
      setState(() {
        prestationJour = result;
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
          title: Text('Bilan', style: TextStyle(fontFamily: 'AlexandriaFLF', fontWeight: FontWeight.bold, color: Colors.black),),
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
                    //main();
                    print('ventes:${ventesJour.toString()}');
                    print('prestations:${prestationJour.toString()}');
                    print((CoutPrestation+CoutVentes
                    
                    ).toString());
                    print(  DateFormat("dd-MM-yyyy").format(DateTime.now()).toString()
                    );

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
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
    children: <Widget>[
    Expanded(
    child:  GridView.count(
    childAspectRatio: 2,
    primary: false,
    mainAxisSpacing: 10,
    crossAxisSpacing: 8.0,
    crossAxisCount: 2,
    children: <Widget>[





   
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child:   RaisedButton(
    elevation: 1,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
    onPressed: (){  Navigator.of(context).push(       MaterialPageRoute(builder: (context) => ChooseMonthVente()
    ),
    );},
    child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
    Text('Liste des ventes', style: TextStyle(fontFamily: 'AlexandriaFLF', fontWeight: FontWeight.bold), textAlign: TextAlign.center,),                              CircleAvatar(
    backgroundColor: Colors.black,
    radius: 15,
    child: Text('0')
    ),
    ],
    ),
    color: Colors.white,
    ),
    ),
    
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child:   RaisedButton(
    elevation: 1,

    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
    onPressed: (){ _calcTotal();
    print(numero);
    Navigator.of(context).push(       MaterialPageRoute(builder: (context) => ChooseMonthPrestation()
    ),
    );
    },
    child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
    Text('Liste des prestations', style: TextStyle(fontFamily: 'AlexandriaFLF', fontWeight: FontWeight.bold), textAlign: TextAlign.center,),                              CircleAvatar(
    backgroundColor: Colors.black,
    radius: 15,
    child: Text('0'),
    ),
    ],
    ),
    color: Colors.white,
    ),
    ),
     Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child:   RaisedButton(
    elevation: 1,

    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
    onPressed: (){
    _calcTotal();
    Navigator.of(context).push(       MaterialPageRoute(builder: (context) => ChooseMonthFournisseur()),             );},
    child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
    Text('Liste des fournisseurs', style: TextStyle(fontFamily: 'AlexandriaFLF', fontWeight: FontWeight.bold), textAlign: TextAlign.center,),                              CircleAvatar(
    backgroundColor: Colors.black,
    radius: 15,
    child: Text('0'),
    ),
    ],
    ),
    color: Colors.white,
    ),
    ),
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child:   RaisedButton(
    elevation: 1,

    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
    onPressed: (){       Navigator.of(context).push(       MaterialPageRoute(builder: (context) => ChooseMonthDepense()
    ),
    );},
    child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
    Text('Liste des clients', style: TextStyle(fontFamily: 'AlexandriaFLF', fontWeight: FontWeight.bold), textAlign: TextAlign.center,),                              CircleAvatar(
    backgroundColor: Colors.black,
    radius: 15,
    child:Text('0'),
    ),
    ],
    ),
    color: Colors.white,
    ),
    ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child:   RaisedButton(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
          onPressed: (){  Navigator.of(context).push(       MaterialPageRoute(builder: (context) => VentesParMois()
          ),
          );},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Compte de resultats', style: TextStyle(fontFamily: 'AlexandriaFLF', fontWeight: FontWeight.bold), textAlign: TextAlign.center,),                              CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 15,
                  child: Text('0')
              ),
            ],
          ),
          color: Colors.white,
        ),
      ),

    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child:   RaisedButton(
    elevation: 1,

    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
    onPressed: (){       Navigator.of(context).push(       MaterialPageRoute(builder: (context) => ChooseMonthDepense()
    ),
    );},
    child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
    Text('Liste des achats', style: TextStyle(fontFamily: 'AlexandriaFLF', fontWeight: FontWeight.bold), textAlign: TextAlign.center,),                              CircleAvatar(
    backgroundColor: Colors.black,
    radius: 15,
    child:Text('0'),
    ),
    ],
    ),
    color: Colors.white,
    ),
    ),
    ],
    ),
    ),
    ],
    ),
    )
    
      )
    );
  }

Future main() async {
  List notes;
  var db = new DbHelperVente();
  int count = await db.getCount();
  print('Count: $count');
}

 

 
}
