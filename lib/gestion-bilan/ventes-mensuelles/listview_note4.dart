import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projetsalon/recettes/vente/model/note.dart';
import 'package:projetsalon/recettes/vente/util/database_helper.dart';
class VenteMois4 extends StatefulWidget {
  @override
  _VenteMois4State createState() => new _VenteMois4State();
}
class _VenteMois4State extends State<VenteMois4> {
  List<Vente> items = new List();
  List<Vente> items1 = new List();
  List<Vente> items2 = new List();
  List<Vente> items3 = new List();
  List<Vente> items4 = new List();

  DbHelperVente db = new DbHelperVente();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String mois='';
  String mois1='';
  String mois2='';
  String mois3='';
  String mois4='';
  String mois5='';
  String mois6='';
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

    db.getAllNotesMoisActuel().then((notes) {
      setState(() {
        notes.forEach((note) {
          items.add(Vente.fromMap(note));
        });
      });
    });
    db.getAllNotesMoisActueljMoins1().then((notes) {
      setState(() {
        notes.forEach((note) {
          items1.add(Vente.fromMap(note));
        });
      });
    });

    db.getAllNotesMoisActuelMoins2().then((notes) {
      setState(() {
        notes.forEach((note) {
          items2.add(Vente.fromMap(note));
        });
      });
    });
    db.getAllNotesMoisActuelMoins3().then((notes) {
      setState(() {
        notes.forEach((note) {
          items3.add(Vente.fromMap(note));
        });
      });
    });
    db.getAllNotesMoisActuelMoins4().then((notes) {
      setState(() {
        notes.forEach((note) {
          items4.add(Vente.fromMap(note));
        });
      });
    });

    db.getAllNotes().then((notes) {
      setState(() {
        notes.forEach((note) {
          items.add(Vente.fromMap(note));
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Monsalon',

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
        body:
        PageView(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Ventes de $mois'),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: items.length,
                        padding: const EdgeInsets.all(15.0),
                        itemBuilder: (context, position) {

                          return
                            items.length == null?Text('Aucun enregistrement'):
                            Column(
                              children: <Widget>[

                                Divider(height: 5.0),

                                InkWell(

                                  child: Column(
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.all(1.0)),
                                      Html(
                                        data: """
                       <table border='1'><tr><th>${items[position].nom}</th><th>${items[position].prixvente}<br>Francs Cfa</th><th>${items[position].qte}</th></tr></tr></table>
  """, ),

                                    ],
                                  ),
                                  onTap: () {},
                                ),

                              ],
                            );
                        }),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Ventes de ${mois1}'),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: items1.length,
                        padding: const EdgeInsets.all(15.0),
                        itemBuilder: (context, position) {

                          return
                            items1.length == null?Text('Aucun enregistrement'):
                            Column(
                              children: <Widget>[

                                Divider(height: 5.0),

                                InkWell(

                                  child: Column(
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.all(1.0)),
                                      Html(
                                        data: """
                       <table border='1'><tr><th>${items1[position].nom}</th><th>${items1[position].prixvente}<br>Francs Cfa</th><th>${items1[position].qte}</th></tr></tr></table>
  """, ),

                                    ],
                                  ),
                                  onTap: () {},
                                ),

                              ],
                            );
                        }),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Ventes de ${mois2}'),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: items2.length,
                        padding: const EdgeInsets.all(15.0),
                        itemBuilder: (context, position) {

                          return
                            items2.length == null?Text('Aucun enregistrement'):
                            Column(
                              children: <Widget>[

                                Divider(height: 5.0),

                                InkWell(

                                  child: Column(
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.all(1.0)),
                                      Html(
                                        data: """
                       <table border='1'><tr><th>${items2[position].nom}</th><th>${items2[position].prixvente}<br>Francs Cfa</th><th>${items2[position].qte}</th></tr></tr></table>
  """, ),

                                    ],
                                  ),
                                  onTap: () {},
                                ),

                              ],
                            );
                        }),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Ventes de ${mois3}'),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: items3.length,
                        padding: const EdgeInsets.all(15.0),
                        itemBuilder: (context, position) {

                          return
                            items3.length == null?Text('Aucun enregistrement'):
                            Column(
                              children: <Widget>[

                                Divider(height: 5.0),

                                InkWell(

                                  child: Column(
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.all(1.0)),
                                      Html(
                                        data: """
                       <table border='1'><tr><th>${items3[position].nom}</th><th>${items3[position].prixvente}<br>Francs Cfa</th><th>${items3[position].qte}</th></tr></tr></table>
  """, ),

                                    ],
                                  ),
                                  onTap: () {},
                                ),

                              ],
                            );
                        }),
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Ventes de ${mois4}'),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: items4.length,
                      padding: const EdgeInsets.all(15.0),
                      itemBuilder: (context, position) {

                        return
                          items4.length == null?Text('Aucun enregistrement'):
                          Column(
                            children: <Widget>[

                              Divider(height: 5.0),

                              InkWell(

                                child: Column(
                                  children: <Widget>[
                                    Padding(padding: EdgeInsets.all(1.0)),
                                    Html(
                                      data: """
                     <table border='1'><tr><th>${items4[position].nom}</th><th>${items4[position].prixvente}<br>Francs Cfa</th><th>${items4[position].qte}</th></tr></tr></table>
  """, ),

                                  ],
                                ),
                                onTap: () {},
                              ),

                            ],
                          );
                      }),
                ),
              ],
            ),
            Container(
              child: Center(child:Text("Page 2")),
              color: Colors.blueAccent,
            )
          ],
          pageSnapping: false,
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

}

