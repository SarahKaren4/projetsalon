import 'package:bezier_chart/bezier_chart.dart';
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
import 'package:projetsalon/monCompte/main.dart';
import 'package:projetsalon/prod-materiel/main.dart';
import 'package:projetsalon/recettes/prestation/model/note.dart';
import 'package:projetsalon/recettes/prestation/util/database_helper.dart';
import 'package:projetsalon/recettes/vente/model/note.dart';
import 'package:projetsalon/recettes/vente/util/database_helper.dart';
class VentesParJour extends StatefulWidget {
  String numero;
  VentesParJour({this.numero});
  @override
  _VentesParJourState createState() => new _VentesParJourState();
}

class _VentesParJourState extends State<VentesParJour> {

  double _totalVentes;
  double _totalPrestation;
  double _total ;
double totaux;
String numero;
int ventesJour;
int prestationJour;
int sommeVentes;

var now = DateTime.now();
var dateajout = DateTime.now().year-DateTime.now().month-DateTime.now().day;
 final fromDate = DateTime.now().subtract(Duration(days: 7));
  final toDate = DateTime.now();

  final date1 = DateTime.now().subtract(Duration(days: 1));
  final date2 = DateTime.now().subtract(Duration(days: 2));
  final date3 = DateTime.now().subtract(Duration(days: 3));
  final date4 = DateTime.now().subtract(Duration(days: 4));
  final date5 = DateTime.now().subtract(Duration(days: 5));
  final date6 = DateTime.now().subtract(Duration(days: 6));
  final date7 = DateTime.now().subtract(Duration(days: 4));

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
        sommeVentes = result;
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
                    print('total:${totaux}');
                    print(  DateFormat("dd-MM-yyyy").format(DateTime.now()).toString()
                    );
                    print(sommeVentes);

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
        body:Column(
          
          children: <Widget>[
             Padding(
               padding: const EdgeInsets.all(0.5),
               child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                     Text('Voir la liste',style:TextStyle(fontWeight: FontWeight.bold),),

                  ],
                ),
             ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   Text('Ventes par jour'),

                ],
              ),
            ),
             Divider(height: 1,
  color: Colors.black
  ,),
  Center(
    child: Container(
      color: Colors.red,
     height: MediaQuery.of(context).size.height/2.6,
      width: MediaQuery.of(context).size.width * 0.9,
      child: BezierChart(
        fromDate: fromDate,
        bezierChartScale: BezierChartScale.WEEKLY,
        toDate: toDate,
        selectedDate: toDate,
        series: [
          BezierLine(
            label: "Ventes",
            onMissingValue: (dateTime) {
              if (dateTime.day.isEven) {
                return 10.0;
              }
              return 5.0;
            },
            data: [
              DataPoint<DateTime>(value: 10, xAxis: date1),
              DataPoint<DateTime>(value: 50, xAxis: date2),
              DataPoint<DateTime>(value: 50, xAxis: date3),
              DataPoint<DateTime>(value: 50, xAxis: date4),
            ],
          ),
        ],
        config: BezierChartConfig(
          verticalIndicatorStrokeWidth: 3.0,
          verticalIndicatorColor: Colors.black26,
          showVerticalIndicator: true,
          verticalIndicatorFixedPosition: false,
          backgroundColor: Colors.red,
          footerHeight: 30.0,
        ),
      ),
    ),
  ),
  Divider(height: 1,
  color: Colors.black
  ,)
          ],
        )
      ),
    );
  }



 

 
}
