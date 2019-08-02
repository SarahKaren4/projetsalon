import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projetsalon/recettes/prestation/model/note.dart';
import 'package:projetsalon/recettes/prestation/util/database_helper.dart';
class PrestationMois1 extends StatefulWidget {
  @override
  _PrestationMois1State createState() => new _PrestationMois1State();
}
class _PrestationMois1State extends State<PrestationMois1> {
  List<Prestation> items = new List();
  List<Prestation> items1 = new List();
  List<Prestation> items2 = new List();
  List<Prestation> items3 = new List();
  List<Prestation> items4 = new List();

  DbHelperPrestation db = new DbHelperPrestation();
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
          items.add(Prestation.fromMap(note));
        });
      });
    });
    db.getAllNotesMoisActueljMoins1().then((notes) {
      setState(() {
        notes.forEach((note) {
          items1.add(Prestation.fromMap(note));
        });
      });
    });

    db.getAllNotesMoisActuelMoins2().then((notes) {
      setState(() {
        notes.forEach((note) {
          items2.add(Prestation.fromMap(note));
        });
      });
    });
    db.getAllNotesMoisActuelMoins3().then((notes) {
      setState(() {
        notes.forEach((note) {
          items3.add(Prestation.fromMap(note));
        });
      });
    });
    db.getAllNotesMoisActuelMoins4().then((notes) {
      setState(() {
        notes.forEach((note) {
          items4.add(Prestation.fromMap(note));
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
                    child: Text('Prestations de ${mois1}'),
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
                       <table border='1'><tr><th>${items1[position].nomprestation}</th><th>${items1[position].cout}<br>Francs Cfa</th><th>${items1[position].nomclient}</th></tr></tr></table>
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
                    child: Text('Prestations de ${mois2}'),
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
                       <table border='1'><tr><th>${items2[position].nomprestation}</th><th>${items2[position].cout}<br>Francs Cfa</th><th>${items2[position].nomclient}</th></tr></tr></table>
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
                    child: Text('Prestations de ${mois3}'),
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
                       <table border='1'><tr><th>${items3[position].nomprestation}</th><th>${items3[position].cout}<br>Francs Cfa</th><th>${items3[position].nomclient}</th></tr></tr></table>
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
                  child: Text('Prestations de ${mois4}'),
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
                     <table border='1'><tr><th>${items4[position].nomprestation}</th><th>${items4[position].cout}<br>Francs Cfa</th><th>${items4[position].nomclient}</th></tr></tr></table>
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

  void _deleteNote(BuildContext context, Prestation note, int position) async {
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

