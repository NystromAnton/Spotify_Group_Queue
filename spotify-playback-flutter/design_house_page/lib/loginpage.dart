import 'package:flutter/material.dart';
import 'home_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:random_string/random_string.dart';
import 'globals.dart' as globals;

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<LoginPage> {
  final roomEntry = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    roomEntry.dispose();
    super.dispose();
  }

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
              ),
              controller: roomEntry,
              maxLength: globals.roomNameLength,
            ),
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
                if (roomEntry.text.length != globals.roomNameLength) {
                  print(
                      "login_page: Error tip on room login not yet implemented"); // ERROR text
                } else {
                  final HttpsCallable callable = CloudFunctions.instance
                      .getHttpsCallable(functionName: 'roomExists');

                  callable.call({"roomname": roomEntry.text});

                  Navigator.pushReplacementNamed(context, "/home");
                }
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
              onPressed: () {
                globals.roomName = randomAlphaNumeric(6);

                final HttpsCallable callable = CloudFunctions.instance
                    .getHttpsCallable(functionName: 'addRoom');

                callable.call({
                  "roomname": globals.roomName,
                  "id": "UsedId" // TODO
                  // TODO "Rules"
                });

                Navigator.pushReplacementNamed(context, "/home");
              },
            )
          ],
        ),
      ),
    );
  }
}
