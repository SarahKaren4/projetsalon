import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:projetsalon/prod-materiel/produit/model/note.dart';
import 'package:projetsalon/prod-materiel/produit/ui/note_screen.dart';
import 'package:projetsalon/prod-materiel/produit/util/database_helper.dart';
import 'package:flutter_html/flutter_html.dart';
class ListViewProduit extends StatefulWidget {
  @override
  _ListViewProduitState createState() => new _ListViewProduitState();
}
class _ListViewProduitState extends State<ListViewProduit> {
  List<Produit> items = new List();
  DbHelperProd db = new DbHelperProd();
  String phpmsg = '';
  @override
  void initState() {
    super.initState();
    db.getAllNotes().then((notes) {
      setState(() {
        notes.forEach((note) {
          items.add(Produit.fromMap(note));
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'AlexandriaFLF',),
      debugShowCheckedModeBanner: false,
      title: 'Monsalon',
      color: Colors.white,
      home: Scaffold(
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(5.0),
              itemBuilder: (context, position) {

                return Column(
                  children: <Widget>[
                    Divider(height: 1.0),

                                           InkWell(

                        child: Column(
                          children: <Widget>[
                            Html(
                              data: """
                   <table ><tr><th>${items[position].nom}</th><th>${items[position].prixachat}<br>Francs Cfa</th><th>${items[position].statut}</th></tr></table>
  """, ),
Row(
                children: <Widget>[
                  IconButton(
                      icon: const Icon(Icons.remove_circle_outline, size: 13,),
                      onPressed: () => _deleteNote(context, items[position], position)),
                  items[position].statut=='0'? IconButton(
                      icon: const Icon(Icons.update,size: 13),
                      onPressed: () => sendData(context, items[position], position)): Text('') ,

                ],
                ),


                          ],
                        ),
                        onTap: () => _navigateToNote(context, items[position]),
                      ),

                  ],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.add),
          onPressed: () {
            _createNewNote(context);
          },
        ),
      ),
    );
  }

  void _deleteNote(BuildContext context, Produit note, int position) async {
    db.deleteNote(note.id).then((notes) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToNote(BuildContext context, Produit note) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(note)),
    );

    if (result == 'update') {
      db.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Produit.fromMap(note));
          });
        });
      });
    }
  }
 Future sendData(BuildContext context, Produit note, int position) async{
    final response = await http.post("http://192.168.8.101/monsalon/produits.php", body:{
    'nom':items[position].nom,
    'qte':items[position].nom,
    'details':items[position].nom,
    'prixachat':items[position].nom,
    'prixvente':items[position].nom,
    'nomfournisseur':items[position].nomfournisseur,
    'dateajoutprod':items[position].nom,
      'statut':'1'
    });
   //---- Info -------
    setState(() {
        var datauser = json.decode(response.body);
        if (datauser.length != 0){
          print(datauser.length);
          print(datauser);
          print('echec');
        }
        else if (datauser.length == 0){
    print(datauser.length);
    db.updateNote(Produit.fromMap({
      'id': items[position].id,
      'nom': items[position].nom,
      'qte': items[position].qte,
      'details':items[position].details,
      'prixachat': items[position].prixachat,
      'prixvente': items[position].prixvente,
      'nomfournisseur':items[position].nomfournisseur,
      'dateajoutprod' :items[position].dateajoutprod,
      'statut' : '1',
    })).then((_) {
      print('succes');
      Route route = MaterialPageRoute(builder: (context) =>ListViewProduit());
      Navigator.push(context, route);
    });
        }
      });

  }
  void _createNewNote(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(Produit('', '','','','','','',''))),
    );
    if (result == 'save') {
      db.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Produit.fromMap(note));
          });
        });
      });
    }
  }
}
