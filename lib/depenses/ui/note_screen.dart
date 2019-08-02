import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projetsalon/depenses/model/note.dart';
import 'package:projetsalon/depenses/util/database_helper.dart';
class DepensenNotescreen extends StatefulWidget {
  final Depense note;
  DepensenNotescreen(this.note);

  @override
  State<StatefulWidget> createState() => new _DepensenNotescreenState();
}

class _DepensenNotescreenState extends State<DepensenNotescreen> {
  DatabaseHelperDepenses db = new DatabaseHelperDepenses();
  final formKey = new GlobalKey<FormState>();

  TextEditingController _usageController;
  TextEditingController _coutController;
  TextEditingController _dateajoutController;
  @override
  void initState() {
    super.initState();

    _usageController = new TextEditingController(text: widget.note.usage);
    _coutController = new TextEditingController(text: widget.note.cout);
    _dateajoutController = new TextEditingController(text: widget.note.dateajout);


  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

         home: Scaffold(

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
          backgroundColor: Colors.white,
          title: Text('Depenses',style: TextStyle(color: Colors.black),)),

        body: Container(
          margin: EdgeInsets.all(15.0),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
         Center(
           child: new Form(
              key: formKey,
              child: new Column(
              mainAxisSize: MainAxisSize.min,

                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Center(

                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Détails de la dépense', style: TextStyle(fontSize: 20),)
                        ],
                      ),
                    ),
                  ),
                    new Padding(
                    padding: const EdgeInsets.symmetric(horizontal:50, vertical: 5),
                    child: new TextFormField(
                      enabled: false,
                      controller:_usageController ,
                       validator: (val) {
                                if(val.length==0) {
                                  return "Votre numero est requis";
                                }else{
                                  return null;
                                }
                              },
                       textAlign: TextAlign.center,
                              textCapitalization: TextCapitalization.words,
  decoration: new InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                                labelText: "   Usage",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  borderSide: new BorderSide(
                                  ),
                                ),
                      ),
                        ),
                  ),
 new Padding(
                    padding: const EdgeInsets.symmetric(horizontal:50, vertical: 5),
                    child: new TextFormField(
                      enabled: false,
                      controller:_coutController ,
                       validator: (val) {
                                if(val.length==0) {
                                  return "Votre numero est requis";
                                }else{
                                  return null;
                                }
                              },
                       textAlign: TextAlign.center,
                              textCapitalization: TextCapitalization.words,
  decoration: new InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                                labelText: "   Cout",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  borderSide: new BorderSide(
                                  ),
                                ),
                      ),
                        ),
                  ),
                   new Padding(
                    padding: const EdgeInsets.symmetric(horizontal:50, vertical: 5),
                    child: new TextFormField(
                      enabled: false,
                      controller:_dateajoutController ,
                       validator: (val) {
                                if(val.length==0) {
                                  return "Votre numero est requis";
                                }else{
                                  return null;
                                }
                              },
                       textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization.words,
  decoration: new InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                                labelText: "   Date ajout",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  borderSide: new BorderSide(
                                  ),
                                ),
                      ),
                        ),
                  ),

                ],
              ),
            ),
         ),

            ],
          ),
        ),
      ),
    );
  }
}
