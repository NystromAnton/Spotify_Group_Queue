import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_functions/cloud_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'room.dart';
import 'credentials.dart';

Future<SearchResult> searchSong(String input) async {
  if (Credentials.authToken == null) throw Exception("No authentication");

  final response = await http.get(
    'https://api.spotify.com/v1/search?q=' +
        encodeForSearch(input) +
        '&type=track',
    headers: {
      'User-Agent': 'PartyZone',
      'Authorization': 'Bearer ' + Credentials.authToken,
      'Content-Type': 'application/json'
    },
  );

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    return SearchResult.fromJson(json.decode(response.body));
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Bad response from query\n Error code: ' +
        response.statusCode.toString());
    // For info about status codes:
    // https://developer.spotify.com/snapshotation/web-api/#response-status-codes
  }
}

// Encodes a search query with strange characters
String encodeForSearch(String input) {
  String output = "";
  for (int i = 0; i < input.length; i++) {
    input[i] == " " ? output += '%20' : output += input[i];
  }
  return output;
}

String appendArtistNames(List<dynamic> artists) {
  String result = "";
  for (int i = 0; i < artists.length; i++) {
    result += artists[i]["name"];
    if (i < artists.length - 1) result += ", ";
  }
  return result;
}

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchState();
  }
}

class _SearchState extends State<SearchPage> {
  Future<SearchResult> searchResult;
  List<Map<String, dynamic>> songList = [];

  Widget _buildListItem(
      BuildContext context, AsyncSnapshot<SearchResult> snapshot, int index) {
    Map<String, dynamic> currentSong =
        snapshot.data.getTracks()["items"][index];

    songList.add({
      "id": currentSong["id"],
      "image": currentSong["album"]["images"][2]["url"],
      "artists": appendArtistNames(currentSong["artists"]),
      "title": currentSong["name"],
      "tapped": false,
    });
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
          leading: Image.network(songList[index]["image"]),
          title: Text(
            currentSong["name"],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          subtitle: Text(
            songList[index]["artists"],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          trailing: Text(songList[index]["tapped"] == true ? "Added" : "",
              style: TextStyle(color: Colors.green, fontSize: 20)),
          onTap: () {
            setState(() {
              Map<String, dynamic> song = songList[index];
              song["tapped"] = true;

              final HttpsCallable callable = CloudFunctions.instance
                  .getHttpsCallable(functionName: "addSong");
              var submitter = Credentials.hash;
              callable.call({
                "roomname": Room.instance.roomName,
                "artists": song["artists"],
                "image": song["image"],
                "id": song["id"],
                "title": song["title"],
                "submitter": submitter,//TODO: Hårdkodat.
                "votes": 0,
              });
            });
          },
          onLongPress: () {},
        ),
      ),
    );
  }

  void clearSearch() {
    songList.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: TextField(
            onChanged: (String input) {
              setState(() {
                clearSearch();
                searchResult = searchSong(input);
              });
            },
            style: Theme.of(context).textTheme.display2,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.search,
                  color: Theme.of(context).buttonColor,
                  size: 50.0,
                ),
                filled: true,
                labelText: 'Search',
                fillColor: Colors.white,
                hasFloatingPlaceholder: false,
                contentPadding: EdgeInsets.all(10.0),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(15.0),
                  borderSide: new BorderSide(),
                )),
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Theme(
          data: Theme.of(context),
          child: FutureBuilder<SearchResult>(
            future: searchResult,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data.toString());

                List<Widget> songItemList = [];
                List tracks = snapshot.data.getTracks()["items"];
                for (int i = 0; i < tracks.length; i++) {
                  songItemList.add(_buildListItem(context, snapshot, i));
                }

                return ListView(children: songItemList);
              } else if (snapshot.hasError) {
                return Text("Found no matches",
                    style: Theme.of(context).textTheme.display1);
              }
              return Center(
                child: Text(
                  "Search for a song!",
                  style: Theme.of(context).textTheme.display1,
                ),
              );
            },
          ),
        ));
  }
}

class SearchResult {
  final Map<String, dynamic> tracks;
  final Map<String, dynamic> error;

  SearchResult({this.tracks, this.error});

  getTracks() {
    return this.tracks;
  }

  getError() {
    return this.error;
  }

  String toString() {
    String result = "{\n";
    tracks.forEach((String key, dynamic value) {
      result += key + ": " + value.toString() + '\n';
    });
    return result += '}';
  }

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      tracks: json['tracks'],
      error: json['error'],
    );
  }
}
