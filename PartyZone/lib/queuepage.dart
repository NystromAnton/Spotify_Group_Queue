import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

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
  List<Map<String, dynamic>> songList = [];

  void _changeColor(Color changeColor) {
    setState(() {
      _numberColor = changeColor;
    });
  }

  /// Play an song by spotify track id
  /// TODO: Det här ska bara funka i admin mode/ för värden som spelar upp musik
  void play(String id) async {
    final response =
        await http.put("https://api.spotify.com/v1/me/player/play", headers: {
      "Authorization": "Bearer " + Credentials.authToken,
      "User-Agent": "PartyZone",
      "Accept": "application/json",
      "Content-Type": "application/json"
    }, body: {
      "uris": ["spotify:track:" + id],
    });

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      print("Play success");
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Bad response from query\n Error code: ' +
          response.statusCode.toString());
      // For info about status codes:
      // https://developer.spotify.com/snapshotation/web-api/#response-status-codes
    }
  }

  /// Add an song / playlist / album to the playback queue
  Future<void> queue(String id) async {
    try {
      await SpotifyPlayback.queue(id).then((success) {
        print(success);
      }, onError: (error) {
        print(error);
      });
    } on PlatformException {
      print('Failed to queue.');
    }
  }

  Widget _buildListItem(
      BuildContext context, DocumentSnapshot document, Color _numberColor) {
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
            title: Text(
              document["title"],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            subtitle: Text(
              document['artists'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            trailing: Text(
              document['votes'].toString(),
              style: TextStyle(color: Colors.white, fontSize: 26),
            ),
            onTap: () {
              final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
                  functionName: "addVote"
              );

              callable.call({
                //"hash": Credentials.hash,
                "roomname": Room.instance.roomName,
                "song": document.documentID,
                "submitter": document['submitter'],
                "upvote": true
              });

              _changeColor(Colors.green);
            },
            onLongPress: () {
              final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
                  functionName: "addVote"
              );

              callable.call({
                //"hash": Credentials.hash,
                "roomname": Room.instance.roomName,
                "song": document.documentID,
                "submitter": document['submitter'],
                "upvote": false
              });
              _changeColor(Colors.red);
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('rooms/' + Room.instance.roomName + '/songs')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Loading...');
            songList.clear();
            return ListView.builder(
                itemExtent: 80.0,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  //print(snapshot.data.documents[0].toString());
                  songList.add(snapshot.data.documents[index].data);
                  return _buildListItem(
                      context, snapshot.data.documents[index], _numberColor);
                });
          }),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Map<String, dynamic> topSong = songList[0];

          print("Trying to play song: ");
          topSong.forEach((String k, dynamic v) => print(k + ": " + v.toString()));

          play(topSong["id"]);
        },
        tooltip: 'New Document',
        child: Icon(Icons.add),
      ),
    );
  }
}
