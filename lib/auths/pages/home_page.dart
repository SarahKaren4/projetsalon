import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:projetsalon/auths/data/database_helper.dart';
import 'package:projetsalon/auths/models/user.dart';
import 'package:projetsalon/auths/pages/login/login_page.dart';
import 'package:projetsalon/calendrier/main.dart';
import 'package:projetsalon/catalogue/ui/listview_note.dart';
import 'package:projetsalon/client-fournisseurs/main.dart';
import 'package:projetsalon/depenses/ui/listview_note.dart';
import 'package:projetsalon/employe/ui/listview_note.dart';
import 'package:projetsalon/gestion-bilan/bilan-journalier.dart';
import 'package:projetsalon/gestion-bilan/main-bilan.dart';
import 'package:projetsalon/monCompte/main.dart';
import 'package:projetsalon/prod-materiel/main.dart';
import 'package:projetsalon/recettes/main.dart';
import 'package:projetsalon/recettes/prestation/model/note.dart';
import 'package:projetsalon/recettes/prestation/util/database_helper.dart';
import 'package:projetsalon/recettes/vente/model/note.dart';
import 'package:projetsalon/recettes/vente/util/database_helper.dart';
import 'package:projetsalon/tresorerie/main.dart';
class HomePage extends StatefulWidget {
  String numero;
  HomePage({this.numero});
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

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

              leading: new IconButton(iconSize: 30, color:Colors.black87, icon: new Icon(FontAwesomeIcons.bars, size: 15,),
            onPressed: () => _scaffoldKey.currentState.openDrawer()),
          title: Text('Tableau de bord', style: TextStyle(fontFamily: 'AlexandriaFLF', fontWeight: FontWeight.bold, color: Colors.black),),
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
      height: MediaQuery.of(context).size.height>1010?MediaQuery.of(context).size.height/4.5:MediaQuery.of(context).size.height/4,
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
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 4),
                child:   Container(
                  height: MediaQuery.of(context).size.height/5,
                  width: MediaQuery.of(context).size.width/1.5,
                  child: RaisedButton(
                    elevation: 0.0,

                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(1.0))),
                    onPressed: (){
                      _calcTotal();
                      Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => BilanParJour()),             );},
                    child:ListView.builder(
                         itemCount: 1,
                itemBuilder: (context, position) {
                  return Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
 children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                              Text('Bilan de la journee',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text('Chiffre d\'affaires:${CoutPrestation} FCFA',style: TextStyle(fontSize: 9,fontWeight: FontWeight.bold),),
                          ),
                               Text('Nombre de clients:$prestationJour ',style: TextStyle(fontSize: 10),),
                         Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Text('Nombre de ventes:$ventesJour ',style: TextStyle(fontSize: 10),),
                               ),
                          ],
                        )
                          ],
                      ),
                    ),
                  );
                 }
                    )
                    /*
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[

                        Icon(Icons.add),
                          Text('Bilan de la journee'),
                           Text('vente: ${vente.length}'),
                           Text('C.Affaires:${vente.length} '),
                           Text('Nombre de client:${vente.length} '),
                      ],
                    ),
                    */
                    ,
                    color: Colors.white,
                  ),
                ),
              ),
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
                        onPressed: (){
                          _calcTotal();
                           Navigator.of(context).push(       MaterialPageRoute(builder: (context) => MainPersistentTabBar()),             );
                           },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text('Stock', style: TextStyle(fontFamily: 'AlexandriaFLF', fontWeight: FontWeight.bold),),
                            CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 25.0,
                            child: Icon(FontAwesomeIcons.box,size: 18,color: Colors.white,
                              ),
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
                           Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListViewDepense()),);},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text('Dépenses', style: TextStyle(fontFamily: 'AlexandriaFLF', fontWeight: FontWeight.bold),),
                            CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 25.0,
                                child: Icon(FontAwesomeIcons.cartArrowDown,size: 18,color: Colors.white,
                              ),
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
                          Navigator.of(context).push(       MaterialPageRoute(builder: (context) => Recettes()),             );},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text('Recettes', style: TextStyle(fontFamily: 'AlexandriaFLF', fontWeight: FontWeight.bold),),
                         CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 25.0,
                              child: Icon(FontAwesomeIcons.caretSquareUp,size: 18,color: Colors.white,
                              ),
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
                           Navigator.of(context).push(       MaterialPageRoute(builder: (context) => Collaborateurs()),             );},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text('Clients-Frs', style: TextStyle(fontFamily: 'AlexandriaFLF', fontWeight: FontWeight.bold),),
                            CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 25.0,
                                                          child: Icon(Icons.people,size: 18,color: Colors.white,
                              ),
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
                        onPressed: (){  Navigator.of(context).push(       MaterialPageRoute(builder: (context) => ListViewEmployee()
                        ),
                          );},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text('Personnel', style: TextStyle(fontFamily: 'AlexandriaFLF', fontWeight: FontWeight.bold),),
                          CircleAvatar(
                                 backgroundColor: Colors.black,
                              radius: 25.0,
                           child: Icon(FontAwesomeIcons.empire,size: 18,color: Colors.white,
                              ),
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
                         Navigator.of(context).push(       MaterialPageRoute(builder: (context) => ListViewCatalogue()
                        ),
                          );

                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text('Catalogue', style: TextStyle(fontFamily: 'AlexandriaFLF', fontWeight: FontWeight.bold),),
                            CircleAvatar(
                               backgroundColor: Colors.black,
                              radius: 25.0,
                                                          child: Icon(FontAwesomeIcons.images,size: 18,color: Colors.white,
                              ),
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
                        onPressed: (){       Navigator.of(context).push(       MaterialPageRoute(builder: (context) => Tresorerie()
                        ),
                          );},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text('Trésorerie', style: TextStyle(fontFamily: 'AlexandriaFLF', fontWeight: FontWeight.bold),),
                            CircleAvatar(
                               backgroundColor: Colors.black,
                              radius: 25.0,
                            child: Icon(FontAwesomeIcons.moneyBill,size: 18,color: Colors.white,
                              ),
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
                           Navigator.of(context).push(       MaterialPageRoute(builder: (context) =>  HomeScreen()),             );},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text('Agenda', style: TextStyle(fontFamily: 'AlexandriaFLF', fontWeight: FontWeight.bold),),
                            CircleAvatar(
                            backgroundColor: Colors.black,
                              radius: 25.0,
                            child: Icon(FontAwesomeIcons.calendarAlt,size: 18,color: Colors.white,
                              ),
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
          )
      ),
    );
  }

Future main() async {
  List notes;
  var db = new DbHelperVente();
  int count = await db.getCount();
  print('Count: $count');
}

 

 
}
