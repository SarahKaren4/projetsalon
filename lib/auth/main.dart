import 'package:flutter/material.dart';
import 'package:projetsalon/auth/ProprioPage.dart';
import 'package:projetsalon/auth/dbHelper.dart';
import 'package:projetsalon/auth/listproprio.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monsalon',
      color: Colors.black,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
var db = new DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text("widget.title", style: TextStyle(color: Colors.black),),
         backgroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.edit , color: Colors.white
        ,),
        onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context )=> new ProprioPage(null, true),
        
        )
        ),
      ),
      body: FutureBuilder(
        future:db.getProprio(),
        builder: (context, snapshot){
          if(snapshot.hasError)print(snapshot.error);
          var data = snapshot.data;
          return snapshot.hasData
              ? new ProprioList(data)
              : Center(child: Text('No data'),);
        },
      )
        );
  }
}