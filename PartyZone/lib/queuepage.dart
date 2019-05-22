import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'Credentials.dart';
import 'room.dart';
import 'package:spotify_playback/spotify_playback.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';


class QueuePage extends StatefulWidget {
  @override
  _QueueState createState() => new _QueueState();
}

class _QueueState extends State<QueuePage> {
  Color _numberColor = Colors.white;

  void _changeColor(Color changeColor) {
      setState(() {
        _numberColor = changeColor;
      });
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document, Color _numberColor) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 2.5, color: Colors.black),
          left: BorderSide(width: 2.5, color: Colors.black),
          right: BorderSide(width: 2.5, color: Colors.black),
          bottom: BorderSide(width: 2.5, color: Colors.black),
        ),
      ),
      child: Container(
        color: Colors.white10,
        child: ListTile(
           leading: Image.network(document["image"]),
            title: Text(document["title"],
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            subtitle: Text(document['artists'],
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            trailing: Text(document['votes'].toString(),
              style: TextStyle(color: Colors.white, fontSize: 26),
            ),
            onTap: () {
              /*Firestore.instance.runTransaction((transaction) async {
                DocumentSnapshot freshSnap =
                await transaction.get(document.reference);
                await transaction.update(freshSnap.reference, {
                  'votes': freshSnap['votes'] + 1,
                });
              });*/

/*
              Firestore.instance.runTransaction((transaction) async {
                DocumentSnapshot freshSnap = await transaction.get(document.reference);
              });
              */

              final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
                  functionName: "addVote"
              );
              
              callable.call({
                "hash": Credentials.hash,
                "roomname": Room.instance.roomName,
                "song": document.documentID,
                "submitter": "tester",//TODO: hårdkodat och äckligt
                "upvote": true
              });

              _changeColor(Colors.green);
            },
            onLongPress: () {
              /*Firestore.instance.runTransaction((transaction) async {
                DocumentSnapshot freshSnap =
                await transaction.get(document.reference);
                await transaction.update(freshSnap.reference, {
                  'votes': freshSnap['votes'] - 1,
                });
              });*/
              Firestore.instance.runTransaction((transaction) async {
                DocumentSnapshot freshSnap =
                await transaction.get(document.reference);
                //debugPrint(freshSnap.documentID);
                final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
                    functionName: "addVote"
                );

                callable.call({
                  "hash": Credentials.hash,
                  "roomname": Room.instance.roomName,
                  "song": "3kXsQiAIKxfQezqLkdqT",//TODO: Hårdkodat
                  "submitter": "f8a2058f7bd0e92ec6ad4e69bf3a1a3cf7d8c51d4765bc14573f46bbdf0de2024213730eaa5a927a03278b6fa10bf12ead6895ba5b1bc3081447165a809f56a0",//TODO: hårdkodat och äckligt
                  "upvote": true
                });
              });
              _changeColor(Colors.red);
            },
          ),
        ),
      );
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: StreamBuilder(
            stream: Firestore.instance.collection('rooms/' + Room.instance.roomName + '/songs')
                .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text('Loading...');
                return ListView.builder(
                  itemExtent: 80.0,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) =>
                      _buildListItem(context, snapshot.data.documents[index], _numberColor),
                );
              }),
        floatingActionButton: new FloatingActionButton(
          onPressed: () {
              final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
                  functionName: "addSong"
              );

              callable.call({
                "roomname": Room.instance.roomName,
                "id": "spotify:track:0l7hq0EGBOki5E6uCWrzwk",
                "submitter": "placeholder",
                "votes": 0});
            },
            tooltip: 'New Document',
            child: Icon(Icons.add),
          ),
        );
      }
  }