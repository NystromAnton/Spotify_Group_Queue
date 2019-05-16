import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'room.dart';

//import 'package:spotify_playback/spotify_playback.dart';
//import 'credentials.dart';
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

    /*return ListView(
      children: const <Widget>[
        Card(
          color: Colors.white10,
          child: ListTile(
            leading: FlutterLogo(size: 56.0), //TODO Hämta låtens albumbild hit
            title: Text("Låtnamn",
                    style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(document['id'],
              style: TextStyle(color: Colors.white),
            ),
            trailing: Text("Hej",
              style: TextStyle(color: Colors.white),
            ),
            //trailing: Icon(Icons.accessibility_new),
            ),
        ),
      ],
    );*/

    return ListTileTheme(
          //style:
          iconColor: Colors.blue,
          child: ListTile(
            leading: FlutterLogo(size: 56.0), //TODO Hämta låtens albumbild hit
            title: Text("Låtnamn",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            subtitle: Text(document['id'],
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            trailing: Text(document['votes'].toString(),
              style: TextStyle(color: Colors.white, fontSize: 26),
            ),
            selected: true,
            //trailing: Icon(Icons.accessibility_new),
        ),
    );

          /* ListTile(
            leading: FlutterLogo(size: 56.0), //TODO Hämta låtens albumbild hit
            title: Text("Låtnamn",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            subtitle: Text(document['id'],
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            trailing: Text(document['votes'].toString(),
              style: TextStyle(color: Colors.white, fontSize: 26),
            ),
            //trailing: Icon(Icons.accessibility_new),
      );*/

     /* return ListTile(
        title: Row(
          children: [
            Expanded(

              child: Text(
                  document['id'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  )
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              padding: const EdgeInsets.all(10.0),
              child: Text(
                  document['votes'].toString(),
                  style: TextStyle(
                      color: _numberColor,
                      fontSize: 32
                  )
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
          _changeColor(Colors.green);
        },
        onLongPress: () {
          Firestore.instance.runTransaction((transaction) async {
            DocumentSnapshot freshSnap =
            await transaction.get(document.reference);
            await transaction.update(freshSnap.reference, {
              'votes': freshSnap['votes'] - 1,
            });
          });
          _changeColor(Colors.red);
        },
      );*/

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
            //Firestore.instance.collection('rooms/ZzqG0nrtavCSfv2uxB53/songs').document()
            //  .setData({'id' : "E-Type - Like a Child", 'votes' : 0});
            //debugPrint("hej");

            final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
                functionName: "addSong"
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
    }
}
