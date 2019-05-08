import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black87,
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            children: <Widget>[
              SizedBox(height: 120.0),
              Column(
                children: <Widget>[
                  Image.asset('assets/logga.png'),
                  SizedBox(height: 20.0),
                  Text('Text för login typ'),
                ],
              ),
              SizedBox(height: 55.0),
              TextField(
                  decoration: InputDecoration(
                labelText: 'Room code',
                filled: true,
                fillColor: Colors.grey,
              )),
              SizedBox(height: 16.0),
              RaisedButton(
                padding: EdgeInsets.all(13.0),
                textColor: Colors.white,
                color: Colors.orange,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Text(
                  'Join Room',
                  style: TextStyle(fontSize: 22.0),
                ),
                onPressed: () {},
              ),
              SizedBox(
                height: 40.0,
                //child: const Card(child: Text('Hello World!')),
              ),
              Center(
                child: Text(
                  'or',
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                ),
              ),
              SizedBox(height: 60.0),
              RaisedButton(
                padding: EdgeInsets.all(13.0),
                textColor: Colors.white,
                color: Colors.green,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                child: Text(
                  'Create Room',
                  style: TextStyle(fontSize: 22.0),
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
