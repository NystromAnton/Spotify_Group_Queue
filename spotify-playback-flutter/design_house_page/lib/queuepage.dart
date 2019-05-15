import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'room.dart';

//import 'package:spotify_playback/spotify_playback.dart';
//import 'credentials.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';


class QueuePage extends StatelessWidget {
  const QueuePage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PartyZone',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        backgroundColor: Colors.white,
        canvasColor: Colors.black, // Nav bar background
        toggleableActiveColor: Colors.green[600],
        buttonColor: Colors.grey[600], // Nav bar buttons
      ),
      home: const MyHomePage(title: 'PartyZone'),
    );
  }
}


class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: Text(
              document['id'],
              style: TextStyle(
                color: Colors.white,
                fontSize: 24
              )//Theme.of(context).textTheme.headline,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            padding: const EdgeInsets.all(10.0),
            child: Text(
              document['votes'].toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32
              )//Theme.of(context).textTheme.display1,
            ),
          ),
        ],
      ),
      onTap: () {
        Firestore.instance.runTransaction((transaction) async {
          DocumentSnapshot freshSnap =
          await transaction.get(document.reference);
          await transaction.update(freshSnap.reference, {
            'votes': freshSnap['votes'] + 1,
          });
        });
      },
      onLongPress: () {
        Firestore.instance.runTransaction((transaction) async {
          DocumentSnapshot freshSnap =
          await transaction.get(document.reference);
          await transaction.update(freshSnap.reference, {
            'votes': freshSnap['votes'] - 1,
          });
        });
      },
    );
  }

    /*onLongPress: () {
    final HttpsCallable callable  = CloudFunctions.instance.getHttpsCallable(
    functionName: "addRoom"
    );

    callable.call({
    "roomname": "hallon",
    "id": "Basshunter - GPS",
    "votes": 42 });
    };*/

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(title),
    ),
    body: StreamBuilder(
        stream: Firestore.instance.collection('rooms/' + Room.instance.roomName + '/songs')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text('Loading...');
          return ListView.builder(
            itemExtent: 80.0,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) =>
                _buildListItem(context, snapshot.data.documents[index]),
          );
        }),
    floatingActionButton: new FloatingActionButton(
      onPressed: () {
        //Firestore.instance.collection('rooms/ZzqG0nrtavCSfv2uxB53/songs').document()
        //  .setData({'id' : "E-Type - Like a Child", 'votes' : 0});
        //debugPrint("hej");

        final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
            functionName: "addRoom"
        );

        callable.call({
          "roomname": Room.instance.roomName,
          "id": "Basshunter - GPS",
          "votes": 42});
      },
      tooltip: 'New Document',
      child: Icon(Icons.add),
    ),
  );
}}