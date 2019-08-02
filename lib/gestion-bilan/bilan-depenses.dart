import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:projetsalon/auths/data/database_helper.dart';
import 'package:projetsalon/auths/models/user.dart';
import 'package:projetsalon/auths/pages/login/login_page.dart';
import 'package:projetsalon/calendrier/main.dart';
import 'package:projetsalon/catalogue/ui/listview_note.dart';
import 'package:projetsalon/catalogue/ui/note_screen.dart';
import 'package:projetsalon/client-fournisseurs/main.dart';
import 'package:projetsalon/depenses/model/note.dart';
import 'package:projetsalon/depenses/ui/listview_note.dart';
import 'package:projetsalon/depenses/util/database_helper.dart';
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
import 'package:projetsalon/tresorerie/entree/model/note.dart';
import 'package:projetsalon/tresorerie/entree/util/database_helper.dart';
import 'package:projetsalon/tresorerie/main.dart';
class BilanMensuelDepense extends StatefulWidget {
  String numero;
  BilanMensuelDepense({this.numero});
  @override
  _BilanMensuelDepenseState createState() => new _BilanMensuelDepenseState();
}

class _BilanMensuelDepenseState extends State<BilanMensuelDepense> {
  
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
int Somme;
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
Future somme() async{
  int resultat;
  if((sommeDepenseMoisactuel==null) && (sommeEntreeMoisactuel==null))
  {
    resultat=0;
  }
 else if((sommeDepenseMoisactuel!=null) && (sommeEntreeMoisactuel==null))
  {
    resultat=sommeDepenseMoisactuel;
  }
  else if((sommeDepenseMoisactuel==null) && (sommeEntreeMoisactuel!=null))
  {
    resultat=sommeDepenseMoisactuel;
  }
  else if((sommeDepenseMoisactuel!=null) && (sommeEntreeMoisactuel!=null))
  {
    resultat=sommeDepenseMoisactuel +sommeDepenseMoisactuel;
  }
  return resultat;
}
  List<User> items = new List();
    List<Prestation> presta = new List();
        List<Entree> benef = new List();

String mois='';
String mois1='';
String mois2='';
String mois3='';
String mois4='';
String mois5='';
String mois6='';
int sommeDepenseMoisactuel;
int sommeEntreeMoisactuel;

var date1 = '${DateTime.now().month-1}';
  List<Vente> ventes = new List();
  List<Depense> depenses = new List();
  DatabaseHelper db = new DatabaseHelper();
  DatabaseHelperDepenses dbDepense = new DatabaseHelperDepenses();
  DbHelperVente dbVente = new DbHelperVente();
  DatabaseHelperEntree dbEntree = new DatabaseHelperEntree();
   DbHelperPrestation dbPrestation = new  DbHelperPrestation();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
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
     dbDepense.getSumOfAll().then((result) {
      print(result);
      setState(() {
        sommeDepenseMoisactuel = result;
      });
    });
     dbEntree.getSumOfAll().then((result) {
      print(result);
      setState(() {
        sommeEntreeMoisactuel = result;
      });
      
    });
     dbPrestation.getCount().then((result) {
      print(result);
      setState(() {
        prestationJour = result;
      });
    });
     dbEntree.getAllNotesMoisActuel().then((notes) {
      setState(() {
       notes.forEach((note) {
          benef.add(Entree.fromMap(note));
        });
      });
    });
     dbDepense.getAllNotesMoisActuel().then((notes) {
      setState(() {
       notes.forEach((note) {
          depenses.add(Depense.fromMap(note));
        });
      });
    });
      dbVente.getAllNotesMoisActueljMoins1().then((notes) {
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
      somme().then((result) {
      print( result);
      setState(() {
        Somme = result;
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
          title: Text('Bilan de ${mois}', style: TextStyle(fontFamily: 'AlexandriaFLF', fontWeight: FontWeight.bold, color: Colors.black),),
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
        body: 
 Center(
          child: Column(
            children: <Widget>[
              
               Html(
  data: """
  <tr>
    <th><center><strong>Charges</strong></center></th>
  </tr>
  """) ,
              Expanded(
                              child: ListView.builder(
                    itemCount: depenses.length,
                    padding: const EdgeInsets.all(1.0),
                    itemBuilder: (context, position) {
                      return Column(
                        children: <Widget>[
                          InkWell(
                            child: Column(
                              children: <Widget>[
                                Padding(padding: EdgeInsets.all(1.0)),     
                    Html(
  data: """
   <tr>
    <center>
        <th>${depenses[position].usage}</th>
        <th>${depenses[position].cout} FCFA</th>
    </tr>

  """),      
   Divider(
height: 0.01,
color: Colors.black,
  )
                              ],
                            ),
                            onTap: () {},
                          ),
                        ],
                      );
                    }),
              ),
               Html(
  data: """
  <tr>
    <th><center><strong>Chiffre d'affaire</strong></center></th>
  </tr>

  """) ,
  
              Expanded(
                              child: ListView.builder(
                    itemCount: benef.length,
                    padding: const EdgeInsets.all(1.0),
                    itemBuilder: (context, position) {
                      return Column(
                        children: <Widget>[
                          InkWell(

                            child: Column(
                              children: <Widget>[
                                Padding(padding: EdgeInsets.all(1.0)),
                                
                    Html(
  data: """
   <tr>
    <center>
        <td>${benef[position].usage}</td>
        <td>${benef[position].cout} FCFA</td>
    </tr>

  """),
  Divider(
height: 0.1,
color: Colors.black,
  )
                                /*
                                Row(
                                  children: <Widget>[
                                    IconButton(
                                        icon: const Icon(Icons.remove_circle_outline),
                                        onPressed: () => _deleteNote(context, items[position], position)),
                                  ],
                                ),
                                */
                              ],
                            ),
                            onTap: () {},
                          ),

                        ],
                      );
                    }),
              ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Html(
  data: """
  <tr>
    <th><strong>Dépenses</strong> :${sommeDepenseMoisactuel} fcfa</th>
    <th><strong>Entrées</strong> :${sommeEntreeMoisactuel} fcfa</th>
  </tr>
   """),
               ), 
               Padding(
                padding: const EdgeInsets.all(2.0),
                child: sommeDepenseMoisactuel+sommeEntreeMoisactuel!=null?Text('Résultat :${sommeEntreeMoisactuel-sommeDepenseMoisactuel} fcfa',style: TextStyle(fontWeight: FontWeight.bold)):Text('Résultat : 0'),
              ),

            ],
          ),
        ),
        
      ),
    );
  }


  
  
}
