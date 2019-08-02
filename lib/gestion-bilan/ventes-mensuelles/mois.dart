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
import 'package:projetsalon/gestion-bilan/main-bilan.dart';
import 'package:projetsalon/gestion-bilan/ventes-mensuelles/listview_note.dart';
import 'package:projetsalon/gestion-bilan/ventes-mensuelles/listview_note3.dart';
import 'package:projetsalon/monCompte/main.dart';
import 'package:projetsalon/prod-materiel/main.dart';
import 'package:projetsalon/recettes/prestation/model/note.dart';
import 'package:projetsalon/recettes/prestation/util/database_helper.dart';
import 'package:projetsalon/recettes/vente/model/note.dart';
import 'package:projetsalon/recettes/vente/util/database_helper.dart';
import 'listview_note1.dart';
import 'listview_note2.dart';
import 'listview_note4.dart';
import 'listview_note5.dart';
class ChooseMonthVente extends StatefulWidget {
  String numero;
  ChooseMonthVente({this.numero});
  @override
  _ChooseMonthVenteState createState() => new _ChooseMonthVenteState();
}

class _ChooseMonthVenteState extends State<ChooseMonthVente> {
  String now ='';

  Future<String> Mois(now) async {
String result='';
switch(now) {
  case '1':{
            result='Janvier';
  }
  break;
    case '2':{
            result='Fevrier';
  }
  break; 
   case '3':{
            result='Mars';
  }
  break; 
   case '4':{
            result='Avril';
  }
  break; 
   case '5':{
            result='Mai';
  }
  break; 
   case '6':{
            result='Juin';
  }
  break; 
  
   case '7':{
            result='Juillet';
  }
  break; 
   case '8':{
            result='Aout';
  }
  break;  case '9':{
            result='Septembre';
  }
  break;  case '10':{
            result='Octobre';
  }
  break;  case '11':{
            result='Novembre';
  }
  break;  case '12':{
            result='Déçembre';
  }
  break;
}
//    var result = await dbClient.rawInsert(
//        'INSERT INTO $tableNote ($ColumnNom, $ColumnQte) VALUES (\'${note.title}\', \'${note.description}\')');
    print(result);
    return result;
  }
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
String mois='';
String mois1='';
String mois2='';
String mois3='';
String mois4='';
String mois5='';
String mois6='';
var date1 = '${DateTime.now().month-1}';
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
   Mois('${DateTime.now().month}'.toString()).then((result) {
      print(result);
      setState(() {
        mois = result;
      });
    });
       Mois('${DateTime.now().month-1}'.toString()).then((result) {
      print(result);
      setState(() {
        mois1 = result;
      });
    });
    Mois('${DateTime.now().month-2}'.toString()).then((result) {
      print(result);
      setState(() {
        mois2 = result;
      });
    });
     Mois('${DateTime.now().month-3}'.toString()).then((result) {
      print(result);
      setState(() {
        mois3 = result;
      });
    });
     Mois('${DateTime.now().month-4}'.toString()).then((result) {
      print(result);
      setState(() {
        mois4 = result;
      });
    });
     Mois('${DateTime.now().month-5}'.toString()).then((result) {
      print(result);
      setState(() {
        mois5 = result;
      });
    });
    Mois('${DateTime.now().month-6}'.toString()).then((result) {
      print(result);
      setState(() {
        mois6 = result;
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
          title: Text('Ventes', style: TextStyle(fontFamily: 'AlexandriaFLF', fontWeight: FontWeight.bold, color: Colors.black),),
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
                    print((CoutPrestation+CoutVentes).toString());
                    print(  DateFormat("dd-MM-yyyy").format(DateTime.now()).toString()
                    );
                    print(mois);

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
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(

            children: <Widget>[

                Card(
                                            child: ListTile(
                          title: Text(
                            mois,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                          
                          leading: Column(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.all(10.0)),
                             
                            ],
                          ),
                          onTap: () {
                            Route route = MaterialPageRoute(builder: (context) => VenteMoisActuel());
                    Navigator.push(context, route);
                            
                           },
                        ),
                      ),
                       Card(
                                            child: ListTile(
                          title: Text(
                            mois1,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                          
                          leading: Column(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.all(10.0)),
                             
                            ],
                          ),
                          onTap: () {
                            Route route = MaterialPageRoute(builder: (context) => VenteMois1());
                            Navigator.push(context, route);
                          },
                        ),
                      ), Card(
                                            child: ListTile(
                          title: Text(
                            mois2,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                          
                          leading: Column(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.all(10.0)),
                             
                            ],
                          ),
                          onTap: () {
                            Route route = MaterialPageRoute(builder: (context) => VenteMois2());
                            Navigator.push(context, route);
                          },
                        ),
                      ), Card(
                                            child: ListTile(
                          title: Text(
                            mois3,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                          
                          leading: Column(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.all(10.0)),
                             
                            ],
                          ),
                          onTap: () {
                            Route route = MaterialPageRoute(builder: (context) => VenteMois3());
                            Navigator.push(context, route);
                          },
                        ),
                      ), Card(
                                            child: ListTile(
                          title: Text(
                            mois4,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                          
                          leading: Column(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.all(10.0)),
                             
                            ],
                          ),
                          onTap: () {
                            Route route = MaterialPageRoute(builder: (context) => VenteMois4());
                            Navigator.push(context, route);
                          },
                        ),
                      ), Card(
                                            child: ListTile(
                          title: Text(
                            mois5,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                          
                          leading: Column(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.all(10.0)),
                             
                            ],
                          ),
                          onTap: () {

                            Route route = MaterialPageRoute(builder: (context) => VenteMois5());
                            Navigator.push(context, route);
                          },
                        ),
                      ),
            ],
          ),
        )
         
      ),
    );
  }


 

 
}
