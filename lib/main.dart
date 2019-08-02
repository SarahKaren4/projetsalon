import 'package:flutter/material.dart';
import 'package:projetsalon/auths/main.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(Splashscreen());

class Splashscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      debugShowCheckedModeBanner:false,
      home: SplashScreen(
          seconds: 5,
          navigateAfterSeconds: new MyApp(),
         backgroundColor: Colors.white,
          title: Text('Gerez votre salon comme jamais'),
          image: new Image.asset('assets/image.png'),
          styleTextUnderTheLoader: new TextStyle(),
          photoSize: 90.0,
      ),
    );
  }
}

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}