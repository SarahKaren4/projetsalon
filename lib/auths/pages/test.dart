import 'package:flutter/material.dart';
import 'package:projetsalon/auths/data/database_helper.dart';
import 'package:projetsalon/auths/models/user.dart';
import 'package:projetsalon/auths/pages/test.dart';
class HomePage extends StatefulWidget {

  @override
  State createState() => new DynamicList();
}

class DynamicList extends State<HomePage>{
  List<User> users = new List();
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home"),
      ),
      body: new ListView.builder
        (
          itemCount: users.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return singleRow(users[index]);
          }
        )
    );
  }

  @override
  void initState(){
    super.initState();
    var db = new DatabaseHelper();
    db.getAllUser().then((user){
      users = user;
      print(users);
      setState(() {});
    });
  }

  Widget singleRow(User user)
  {

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
            children: <Widget>[
              Material(
    borderRadius: BorderRadius.circular(10.0),//Set this up for rounding corners.
    shadowColor: Colors.lightBlueAccent.shade100,
    child: MaterialButton(
      elevation: 3,
      minWidth: 80.0,
      height: 80.0,
      onPressed: (){
 
      },//Actions here//},
      color: Colors.white,
      child: Text('Log in', style: TextStyle(color: Colors.black),),
    ),
  ),
      Material(
    borderRadius: BorderRadius.circular(70.0),//Set this up for rounding corners.
    shadowColor: Colors.lightBlueAccent.shade100,
    child: MaterialButton(
      elevation: 3,
      minWidth: 80.0,
      height: 80.0,
      onPressed: (){},//Actions here//},
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Text('Log in', style: TextStyle(color: Colors.black),),
          Icon(Icons.add),
        ],
      ),
    ),
  ),



            ],
          ),
        ),



        
        new Container(
          padding: EdgeInsets.all(5),
          child: Row(
              children:[
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text(user.username,
                    style: TextStyle(
                      color:Colors.indigoAccent[500],
                      )
                    )
                ],
              )),
              IconButton(icon: Icon(
                Icons.delete_sweep,
                color: Colors.red[500],
              ), onPressed: (){
                print(user.id.toString() + ' ' + user.username);
                _delete(user);
              }),

          ])
        ),
      ],
    );
  }
  
  void _delete(User user)
  {
    var db = new DatabaseHelper();
    db.deleteSingleUser(user.id).then((id){
      print('user has been deleted');
      users.remove(user);
      setState(() {});
    });
  }
}
