import 'package:flutter/material.dart';
import 'package:projetsalon/client-fournisseurs/fournisseurs/model/note.dart';
import 'package:projetsalon/client-fournisseurs/fournisseurs/util/database_helper.dart';
import 'package:projetsalon/recettes/prestation/model/note.dart';
import 'package:projetsalon/recettes/prestation/ui/listview_note.dart';
import 'package:projetsalon/recettes/prestation/util/database_helper.dart';
import 'package:projetsalon/recettes/vente/util/database_helper.dart';
class Achat extends StatefulWidget {
  final Fournisseurs note;
  Achat(this.note);

  @override
  State<StatefulWidget> createState() => new _AchatState();
}

class _AchatState extends State<Achat> {
List _cities =
  ["Cluj-Napoca", "Bucuresti", "Timisoara", "Brasov", "Constanta"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCity;
String typeproduit='materiel';
  DbHelperPrestation db = new DbHelperPrestation();
  DbHelperVente bdVente = new DbHelperVente();
 DbHelperFournisseurs bdclient = new DbHelperFournisseurs(); 
  TextEditingController _nomprestationController =new TextEditingController();
  TextEditingController _nomclientController= new TextEditingController();
  TextEditingController _coutController=new TextEditingController();
  TextEditingController _numclientController= new TextEditingController();
  TextEditingController _nomController= new TextEditingController();
  TextEditingController _qteController= new TextEditingController();
  TextEditingController _detailsController= new TextEditingController();
  TextEditingController _prixachatController= new TextEditingController();
  TextEditingController _prixventeController= new TextEditingController();
 TextEditingController _nomfournisseurController= new TextEditingController();

bool enabletextfield=false;
 var now = DateTime.now();

  @override
  void initState() {
      _dropDownMenuItems = getDropDownMenuItems();
    _currentCity = _dropDownMenuItems[0].value;
    super.initState();
    _nomfournisseurController = new TextEditingController(text: widget.note.nomfournisseur);
  }
 List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _cities) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(
          value: city,
          child: new Text(city)
      ));
    }
    return items;
  }
  @override
  Widget build(BuildContext context) {
    if(widget.note.id==null) {
     enabletextfield=true;  
    }
    else{
      enabletextfield=false; 
    }
    return MaterialApp(
      theme: ThemeData(fontFamily: 'AlexandriaFLF'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        body: Container(
          margin: EdgeInsets.all(15.0),
          alignment: Alignment.center,
          child:Column(
            children: <Widget>[

                 new Padding(
                    padding: const EdgeInsets.symmetric(horizontal:50, vertical: 5),
                    child: new TextFormField(
                      			keyboardType: TextInputType.text,
                       validator: (val) {
                                if(val.length==0) {
                                  return "Votre numero est requis";
                                }else{
                                  return null;
                                }
                              },
                       textAlign: TextAlign.center,
                              textCapitalization: TextCapitalization.words,
                       controller: _nomController,
                      decoration: new InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                                labelText: "   Nom",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  borderSide: new BorderSide(
                                  ),
                                ),
                                //fillColor: Colors.green
                              ),
                             ),
                  ),
                 new Padding(
                    padding: const EdgeInsets.symmetric(horizontal:50, vertical: 5),
                    child: new TextFormField(
                      			keyboardType: TextInputType.number,
                       validator: (val) {
                                if(val.length==0) {
                                  return "Votre numero est requis";
                                }else{
                                  return null;
                                }
                              },
                       textAlign: TextAlign.center,
                              textCapitalization: TextCapitalization.words,
                  controller: _qteController,
                      decoration: new InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                                labelText: "   Quantite",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  borderSide: new BorderSide(
                                  ),
                                ),
                                //fillColor: Colors.green
                              ),
                             ),
                  ),
                   new Padding(
                    padding: const EdgeInsets.symmetric(horizontal:50, vertical: 5),
                    child: new TextFormField(
                      			keyboardType: TextInputType.text,
                       validator: (val) {
                                if(val.length==0) {
                                  return "Votre numero est requis";
                                }else{
                                  return null;
                                }
                              },
                       textAlign: TextAlign.center,
                              textCapitalization: TextCapitalization.words,
                  controller: _nomfournisseurController,
                      decoration: new InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                                labelText: "   Nom du fournisseur",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  borderSide: new BorderSide(
                                  ),
                                ),
                                //fillColor: Colors.green
                              ),
                             ),
                  ),

                 new Padding(
                    padding: const EdgeInsets.symmetric(horizontal:50, vertical: 5),
                    child: new TextFormField(
                      			keyboardType: TextInputType.text,
                                    controller: _detailsController,

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
                                labelText: "   Details",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  borderSide: new BorderSide(
                                  ),
                                ),
                                //fillColor: Colors.green
                              ),
                             ),
                  ),
                 new Padding(
                    padding: const EdgeInsets.symmetric(horizontal:50, vertical: 5),
                    child: new TextFormField(
                                    controller: _prixachatController,
			keyboardType: TextInputType.number,
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
                                labelText: "   Prix d'achat",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  borderSide: new BorderSide(
                                  ),
                                ),
                                //fillColor: Colors.green
                              ),
                             ),
                  ),
                 new Padding(
                    padding: const EdgeInsets.symmetric(horizontal:50, vertical: 5),
                    child: new TextFormField(
                                    controller: _prixventeController,
			keyboardType: TextInputType.number,

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
                                labelText: "   Prix de vente",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  borderSide: new BorderSide(
                                  ),
                                ),
                                //fillColor: Colors.green
                              ),
                             ),
                  ),
             new Container(
          color: Colors.white,
          child: new Center(
              child:
              new DropdownButton(
                value: _currentCity,
                items: _dropDownMenuItems,
                onChanged: changedDropDownItem,
              )
          )
      ),





              Padding(padding: new EdgeInsets.all(5.0)),
              RaisedButton(
                child: (widget.note.id != null) ? Text('Update') : Text('Add'),
                onPressed: () {
                  if (widget.note.id != null) {
                     var dateajout='${now.day}-${now.month}-${now.year}-${now.hour}-${now.minute}';
                    db.saveNote(Prestation(_nomprestationController.text, _nomclientController.text, _coutController.text, _numclientController.text,'','', dateajout,'0')).then((_) {
                        Navigator.pop(context, 'update');
                    });
                  }
                  else {
                    if (typeproduit=='materiel')
                    {

                    }
                    else {
                        var dateajout='${now.day}-${now.month}-${now.year}-${now.hour}-${now.minute}';
                    db.saveNote(Prestation(_nomprestationController.text, _nomclientController.text, _coutController.text, _numclientController.text,'','', dateajout,'0')).then((_) {
                       Route route = MaterialPageRoute(builder: (context) =>ListViewPrestation());
                      Navigator.push(context, route);
                    });
                    }
                  }

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  void changedDropDownItem(String selectedCity) {
    print("Selected city $selectedCity, we are going to refresh the UI");
    setState(() {
      _currentCity = selectedCity;
    });
}
}