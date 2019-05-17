import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/services.dart';
import 'package:spotify_playback/spotify_playback.dart';

import 'credentials.dart';

void updateRoomSettings(Map<String, dynamic> data) async {
  final HttpsCallable callable =
      CloudFunctions.instance.getHttpsCallable(functionName: 'editRoom');
  callable.call(data);
}

class Room {
  String roomName;
  int roomNameLength = 6;

  bool _votingEnabled = true;
  bool _explicitAllowed = true;
  String _selectedGenre = "none";
  int _maxQSize = 1000;
  int _songsPerPerson = 100;

  static final Room instance = Room();

  void setRoom(String roomName, DocumentSnapshot document) {
    Map<String, dynamic> data = document.data;

    this.roomName = roomName;

    _votingEnabled = data["voting"];
    _explicitAllowed = data["explicit"];
    _selectedGenre = data["genre"];
    _maxQSize = data["maxQueueSize"];
    _songsPerPerson = data["songsPerPerson"];

    _testPrintState();
  }

  void saveHouseSettings(
      bool voting, bool explicit, String genre, int maxQ, int songPP) {
    _votingEnabled = voting;
    _explicitAllowed = explicit;
    _selectedGenre = genre;
    _maxQSize = maxQ;
    _songsPerPerson = songPP;

    Map<String, dynamic> settings = {
      "roomname": roomName,
      "explicit": explicit,
      "voting": voting,
      "genre": genre,
      "maxQueueSize": maxQ,
      "songsPerPerson": songPP
    };

    /// Play an song by spotify track/album/playlist id
    Future<void> play(String id) async {
      try {
        await SpotifyPlayback.play(id).then((success) {
          print(success);
        }, onError: (error) {
          print(error);
        });
      } on PlatformException {
        print('Failed to play.');
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

    updateRoomSettings(settings);

    _testPrintState();
  }

  bool getExplicit() => _explicitAllowed;

  bool getVoting() => _votingEnabled;

  String getSelectedGenre() => _selectedGenre;

  int getMaxQ() => _maxQSize;

  int getMaxPerPerson() => _songsPerPerson;

  void _testPrintState() {
    print("ExplicitAllowed: " + _explicitAllowed.toString());
    print("VotingEnabled: " + _votingEnabled.toString());
    print("SelectedGenre: " + _selectedGenre.toString());
    print("MaxQueueSize: " + _maxQSize.toString());
    print("Songs per person: " + _songsPerPerson.toString());
  }
}
