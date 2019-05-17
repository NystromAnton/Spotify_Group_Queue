import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'credentials.dart';

Future<Post> searchSong(String input) async {
  if (Credentials.authToken == null) throw Exception("No authentication");
  final response = await http.get(
    'https://api.spotify.com/v1/search?q=nickelback&type=album,track',
    headers: {HttpHeaders.authorizationHeader: Credentials.authToken},
  );

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    var resJson = Post.fromJson(json.decode(response.body));
    print(resJson);
    return resJson;
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Bad response from search query');
  }
}

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchState();
  }
}

class _SearchState extends State<SearchPage> {
  Future<Post> searchResult = searchSong("nickelback");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextField(
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
          actions: <Widget>[
            RaisedButton(
              child: Text("Search"),
              onPressed: () {
                setState(() {
                  searchResult = searchSong("nickelback");
                });
              },
            )
          ],
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Theme(
          data: Theme.of(context),
          child: FutureBuilder<Post>(
            future: searchResult,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text("Searched", style: Theme.of(context).textTheme.display1,); 
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}", style: Theme.of(context).textTheme.display1);
              }
              return CircularProgressIndicator();
            },
          ),
        ));
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  getBody() {
    return this.body;
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
