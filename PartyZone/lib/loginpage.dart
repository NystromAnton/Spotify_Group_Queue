import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:random_string/random_string.dart';
import 'package:spotify_playback/spotify_playback.dart';

import 'room.dart';
import 'credentials.dart';

void logIntoRoom(String usrInput, BuildContext context) async {
  var document =
      Firestore.instance.collection("rooms").document(usrInput).get();

  await document.then((doc) {
    Room.instance.setRoom(usrInput, doc);
    Navigator.pushReplacementNamed(context, "/home");
  });
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<LoginPage> {
  final roomEntry = TextEditingController();
  bool _connectedToSpotify = false;

  @override
  void initState() {
    super.initState();
    initConnector();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    roomEntry.dispose();
    super.dispose();
  }

  /// Initialize the spotify playback sdk, by calling spotifyConnect
  Future<void> initConnector() async {
    try {
      await SpotifyPlayback.spotifyConnect(
              clientId: Credentials.clientId,
              redirectUrl: Credentials.redirectUrl)
          .then((connected) {
        if (!mounted) return;
        // If the method call is successful, update the state to reflect this change
        setState(() {
          _connectedToSpotify = connected;
        });
      }, onError: (error) {
        // If the method call trows an error, print the error to see what went wrong
        print(error);
      });
    } on PlatformException {
      print('Failed to connect.');
    }
  }

  Future<void> getAuthToken() async {
    try {
      SpotifyPlayback.getAuthToken(
              clientId: Credentials.clientId,
              redirectUrl: Credentials.redirectUrl)
          .then((authToken) {
        Credentials.authToken = authToken;
        print(authToken);
        final HttpsCallable callable = CloudFunctions.instance
            .getHttpsCallable(functionName: 'addUser');

        callable.call({
          "token": authToken,
        });
      });
    } on PlatformException {
      print('Failed to play.');
    }
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
              maxLength: Room.instance.roomNameLength,
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
                if (roomEntry.text.length != Room.instance.roomNameLength) {
                  print(
                      "login_page: Error tip on room login not yet implemented"); // ERROR text
                } else {
                  if (Credentials.authToken == null) getAuthToken();
                  logIntoRoom(roomEntry.text, context);
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
                Room.instance.roomName = randomAlphaNumeric(6);

                final HttpsCallable callable = CloudFunctions.instance
                    .getHttpsCallable(functionName: 'addRoom');

                callable.call({
                  "roomname": Room.instance.roomName,
                });

                if (Credentials.authToken == null) getAuthToken();

                Navigator.pushReplacementNamed(context, "/home");
              },
            )
          ],
        ),
      ),
    );
  }
}
