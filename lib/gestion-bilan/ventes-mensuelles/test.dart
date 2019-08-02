import 'package:flutter/material.dart';

void main()
{
  runApp(MaterialApp(
    title:"Androidmonks",
    home: Scaffold(
      body: PageView(
        children: <Widget>[
          Container(
            child: Center(child:Text("Page 1")),
            color: Colors.red,
          ),
          Container(
            child: Center(child:Text("Page 2")),
            color: Colors.blueAccent,
          )
        ],
        pageSnapping: false,
      ),
    ),
  ));
}