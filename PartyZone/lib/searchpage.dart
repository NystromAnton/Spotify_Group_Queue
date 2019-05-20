import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:random_string/random_string.dart';

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

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchState();
  }
}

class _SearchState extends State<SearchPage> {
  Future<SearchResult> searchResult;

  Widget _buildListItem(
      BuildContext context, AsyncSnapshot<SearchResult> snapshot, int index) {
    Map<String, dynamic> currentSong =
        snapshot.data.getTracks()["items"][index];
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
          leading: Image.network(currentSong["album"]["images"][2]["url"]),
          title: Text(
            currentSong["name"],
            maxLines: 1,
            overflow: TextOverflow.clip,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          subtitle: Text(
            currentSong["artists"][0]["name"],
            maxLines: 1,
            overflow: TextOverflow.clip,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onTap: () {},
          onLongPress: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: TextField(
            onChanged: (String input) {
              setState(() {
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

                List<Widget> songList = [];
                List tracks = snapshot.data.getTracks()["items"];
                for (int i = 0; i < tracks.length; i++) {
                  songList.add(_buildListItem(context, snapshot, i));
                }
                ;

                return ListView(children: songList);
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
