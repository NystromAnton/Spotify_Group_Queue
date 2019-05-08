import 'package:flutter/material.dart';
import 'home_widget.dart';
import 'main.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hello',
      theme: ThemeData(
          backgroundColor: Colors.black,
          canvasColor: Colors.grey[900],
          buttonColor: Colors.grey[600],
          textTheme: TextTheme(button: TextStyle(color: Colors.white))),
      home: Home(),
    );
  }
}
