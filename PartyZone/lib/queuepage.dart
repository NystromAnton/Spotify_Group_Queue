import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'credentials.dart';
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
  Map<String, dynamic> playingSong = null;
  bool _isPlaying = false;

  void _changeColor(Color changeColor) {
    setState(() {
      _numberColor = changeColor;
    });
  }

  void _setPlaying(bool input) {
    setState(() {
      _isPlaying = input;
    });
  }

  /// Play an song by spotify track id
  /// TODO: Det här ska bara funka i host mode/för värden som spelar upp musik
  void play(Map<String, dynamic> song) async {
    String songId = song["id"];
    print(song["documentID"]);
    final response = await http.put(
      "https://api.spotify.com/v1/me/player/play",
      headers: {
        "Authorization": "Bearer " + Credentials.authToken,
        "User-Agent": "PartyZone",
        "Accept": "application/json",
      },
      body: json.encode({
        "uris": ["spotify:track:" + songId],
        "position_ms": 0
      }),
    );

    if (response.statusCode == 204) {
      playingSong = song;

      final HttpsCallable callable = CloudFunctions.instance
          .getHttpsCallable(functionName: "removeSong");

      callable.call({
        "roomname": Room.instance.roomName,
        "song": song["documentID"],
        "artists": song["artists"],
        "image": song["image"],
        "title": song["title"]
      });
      
      _setPlaying(true);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Bad response from query\n Error code: ' +
          response.statusCode.toString());
      // For info about status codes:
      // https://developer.spotify.com/snapshotation/web-api/#response-status-codes
    }
  }

  /// Add a song / playlist / album to the playback queue
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
        songList.add(document.data);
        songList[songList.length-1]["documentID"] = document.documentID;
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
              final HttpsCallable callable = CloudFunctions.instance
                  .getHttpsCallable(functionName: "addVote");

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
              final HttpsCallable callable = CloudFunctions.instance
                  .getHttpsCallable(functionName: "addVote");

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
      appBar: AppBar(
        backgroundColor: Colors.orange[800],
        actions: <Widget>[
          _isPlaying == true
              ? Theme(
                  data: Theme.of(context),
                  child: Flexible(
                    child: Row(
                      children: <Widget>[
                        Image.network(playingSong["image"]),
                        Expanded(
                          child: Column(children: <Widget>[
                            Text(
                              playingSong["title"],
                              style: TextStyle(fontSize: 18.0),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              playingSong["artists"],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 15.0),
                              textAlign: TextAlign.center,
                            ),
                          ]),
                        ),
                        Container(
                          child: Icon(Icons.play_arrow, color: Colors.white,),
                        )
                      ],
                    ),
                  ))
              : Text("")
        ],
      ),
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
                  
                  return _buildListItem(
                      context, snapshot.data.documents[index], _numberColor);
                });
          }),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Map<String, dynamic> topSong = songList[0];

          print("Trying to play song: ");
          topSong
              .forEach((String k, dynamic v) => print(k + ": " + v.toString()));

          play(topSong);
        },
        tooltip: 'New Document',
        child: Icon(Icons.play_circle_filled),
      ),
    );
  }
}
