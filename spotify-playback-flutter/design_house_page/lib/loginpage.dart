import 'package:flutter/material.dart';
import 'home_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

//TEST 2
/*
class _LoginState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          children: <Widget>[
            SizedBox(height: 120.0),
            Column(
              children: <Widget>[
                Image.asset('assets/titelbildensaken.png'),
                SizedBox(height: 20.0),
                Text('Text för login typ'),
              ],
            ),
            SizedBox(height: 55.0),
            TextField(
                decoration: InputDecoration(
                  labelText: 'Enter Room code',
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
              onPressed: () {
                print("jahara");
                _PushApp();
              },
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
    );
  }
}

class _PushApp extends State<LoginPage> {

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
              display2: TextStyle(
                fontSize: 24.0,
                color: Colors.grey[300],
              ),
              button: TextStyle(color: Colors.white))),
      home: Home(),
    );
  }
}
*/

//TEST 1

class _LoginState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          children: <Widget>[
            SizedBox(height: 120.0),
            Column(
              children: <Widget>[
                Image.asset('assets/titelbildensaken.png'),
                SizedBox(height: 20.0),
                Text('Text för login typ'),
              ],
            ),
            SizedBox(height: 55.0),
            TextField(
                decoration: InputDecoration(
                  labelText: 'Enter Room code',
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
              onPressed: () {
                _pushApp();
              },
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
    );
  }

  void _pushApp() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            //appBar: AppBar(
              //title: Image.asset('assets/titelbildensaken.png'),
              //backgroundColor: Colors.black,
            //),
            body: Home(),
          );
        },
      ),
    );
  }
}