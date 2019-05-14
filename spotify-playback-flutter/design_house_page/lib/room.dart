import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

class Room {
  String roomName;
  int roomNameLength = 6;

  bool _votingEnabled = true;
  bool _explicitAllowed = true;
  String _selectedGenre;
  int _maxQSize = 1000;
  int _songsPerPerson = 100;


  static final Room instance = Room();

  void setRoom(String roomName, DocumentSnapshot document) {
    Map<String,dynamic> data = document.data;
    
    this.roomName = roomName;

    _votingEnabled = data["voting"];
    _explicitAllowed = data["explicit"];
    _selectedGenre = data["genre"];
    _maxQSize = data["maxQueueSize"];
    _songsPerPerson = data["songsPerPerson"];

    _testPrintState();
  }

  void _testPrintState() {
    print("ExplicitAllowed: " + _explicitAllowed.toString());
    print("VotingEnabled: " + _votingEnabled.toString());
    print("SelectedGenre: " + _selectedGenre.toString());
    print("MaxQueueSize: " + _maxQSize.toString());
    print("Songs per person: " + _songsPerPerson.toString());
  }
}

