import 'package:flutter/material.dart';
import 'home_widget.dart';
import 'loginpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

void main() => runApp(App());

class App extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hello',
      theme: ThemeData(
          backgroundColor: Colors.black,
          canvasColor: Colors.grey[900], // Nav bar background
          toggleableActiveColor: Colors.green[600],
          buttonColor: Colors.grey[600], // Nav bar buttons

          textTheme: TextTheme(
              display1: TextStyle( // House page text
                fontSize: 20.0,
                color: Colors.grey[500]),
              display2: TextStyle( // Search Text Font
                fontSize: 20.0,
                color: Colors.grey[1000],
              ),
              button: TextStyle(color: Colors.white))),
      home: new LoginPage(),
      routes: {
        "/home": (_) => new Home(),
        "/login": (_) => new LoginPage(),
      }
    );
  }
}
