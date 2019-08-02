import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projetsalon/catalogue/model/note.dart';
import 'package:projetsalon/depenses/model/note.dart';
import 'package:projetsalon/depenses/ui/note_screen.dart';
import 'package:projetsalon/depenses/util/database_helper.dart';
import 'package:flutter_html/flutter_html.dart';

class  ListViewDepense extends StatefulWidget {
  @override
  _ListViewDepenseState createState() => new _ListViewDepenseState();
}

class _ListViewDepenseState extends State<ListViewDepense> {
  List<Depense> items = new List( );
  DatabaseHelperDepenses db = new DatabaseHelperDepenses( );

  @override
  void initState() {
    super.initState( );

    db.getAllNotes( ).then( (notes) {
      setState( () {
        notes.forEach( (note) {
          items.add( Depense.fromMap( note ) );
        } );
      } );
    } );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all( ) ,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monsalon' ,
      debugShowCheckedModeBanner: false ,
      theme: ThemeData( fontFamily: 'AlexandriaFLF' , ) ,
      color: Colors.white ,
      home: Scaffold(
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
          title: Text( 'Dépenses' , style: TextStyle(
              color: Colors.black , fontWeight: FontWeight.bold ) , ) ,
          centerTitle: true ,
          backgroundColor: Colors.white ,
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
                                .usage}</th><th>${items[position]
                                .cout}<br>Francs Cfa</th><th>${items[position]
                                .dateajout}</th></tr></table>
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
        /*
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _createNewNote(context),
        ),
        */
      ) ,
    );
  }

  void _deleteNote(BuildContext context , Depense note , int position) async {
    db.deleteNote( note.id ).then( (notes) {
      setState( () {
        items.removeAt( position );
      } );
    } );
  }

  void _navigateToNote(BuildContext context , Depense note) async {
    String result = await Navigator.push(
      context ,
      MaterialPageRoute( builder: (context) => DepensenNotescreen( note ) ) ,
    );

    if (result == 'update') {
      db.getAllNotes( ).then( (notes) {
        setState( () {
          items.clear( );
          notes.forEach( (note) {
            items.add( Depense.fromMap( note ) );
          } );
        } );
      } );
    }
  }

  void _createNewNote(BuildContext context) async {
    String result = await Navigator.push(
      context ,
      MaterialPageRoute( builder: (context) =>
          DepensenNotescreen( Depense( '' , '' , '' , ) ) ) ,
    );

    if (result == 'save') {
      db.getAllNotes( ).then( (notes) {
        setState( () {
          items.clear( );
          notes.forEach( (note) {
            items.add( Depense.fromMap( note ) );
          } );
        } );
      } );
    }
  }

}