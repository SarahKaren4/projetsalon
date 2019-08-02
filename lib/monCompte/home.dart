  import 'package:flutter/material.dart';
class Abonnements extends StatefulWidget {
  @override
  _AbonnementsState createState() => _AbonnementsState();
}

class _AbonnementsState extends State<Abonnements> {
  String uid = '';
  getUid() {}
  @override

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Abonnements', style:TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor:Colors.white,
        ),
        body: Center(
          child: Container(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text('User Id :'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
