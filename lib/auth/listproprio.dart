import 'package:flutter/material.dart';
import 'package:projetsalon/auth/ProprioPage.dart';
import 'package:projetsalon/auth/proprio.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monsalon',
      color: Colors.black,

    );
  }
}

class ProprioList extends StatefulWidget {
  final List<Proprio> propriodata;
  ProprioList(this.propriodata, {Key key});


  @override
  _ProprioListState createState() => _ProprioListState();
}
class _ProprioListState extends State<ProprioList> {


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
gridDelegate: SliverGridDelegateWithFixedCrossAxisCount
  (crossAxisCount:MediaQuery.of(context).orientation == Orientation.portrait
? 2 :3),
      itemCount: widget.propriodata.length == null? 0: widget.propriodata.length ,
      itemBuilder: (BuildContext context, int i ){
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>new ProprioPage(widget.propriodata[i], false))
      );
    },
child: Card(
  child:   Column(
  
    children: <Widget>[
  
  Container(
  
    padding: EdgeInsets.all(8.0),
  
    width: double.infinity,
  
    child: Text(widget.propriodata[i].id_boutique.toString())
  
    ),
  
  Text(widget.propriodata[i].nom)
  
    ],
  
  ),
),
  );
      }
      ,
    );
  }
}
