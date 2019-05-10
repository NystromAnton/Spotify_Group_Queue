import 'placeholder_widget.dart';
import 'package:flutter/material.dart';

import './housepage.dart';
import './queuepage.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final List<Widget> _children = [];

  int _currentIndex = 0;
  bool _votingEnabled = true;
  bool _explicitAllowed = true;
  String _selectedGenre;
  int _maxQSize = 1000;
  int _songsPerPerson = 100;

  // METHODS
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _setExplicit(bool value) {
    setState(() {
      _explicitAllowed = value;
    });
  }

  bool _getExplicit() => _explicitAllowed;

  void _setVoting(bool value) {
    setState(() {
      _votingEnabled = value;
    });
  }

  bool _getVoting() => _votingEnabled;

  void _setSelectedGenre(String genre) {
    setState(() {
      _selectedGenre = genre;
    });
  }

  String _getSelectedGenre() => _selectedGenre;

  void _setMaxQ(int maxQ) {
    _maxQSize = maxQ;
  }

  int _getMaxQ() => _maxQSize;

  void _setMaxPerPerson(int newMaxPP) {
    _songsPerPerson = newMaxPP;
  }

  int _getMaxPerPerson() => _songsPerPerson;

  void _testPrintState() {
    print("ExplicitAllowed: " + _explicitAllowed.toString());
    print("VotingEnabled: " + _votingEnabled.toString());
    print("SelectedGenre: " + _selectedGenre.toString());
    print("MaxQueueSize: " + _maxQSize.toString());
    print("Songs per person: " + _songsPerPerson.toString());
  }

  @override
  Widget build(BuildContext context) {
    HousePage housePage = HousePage(
        _setExplicit,
        _getExplicit,
        _setVoting,
        _getVoting,
        _setSelectedGenre,
        _getSelectedGenre,
        _setMaxQ,
        _getMaxQ,
        _setMaxPerPerson,
        _getMaxPerPerson);

    PlaceholderWidget searchPage = PlaceholderWidget(Colors.black);

    QueuePage queuePage = QueuePage();

    _children.add(housePage);
    _children.add(searchPage);
    _children.add(queuePage);

    _testPrintState();

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/titelbildensaken.png'),
        backgroundColor: Colors.black,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: Theme(
          data: Theme.of(context),
          child: BottomNavigationBar(
            onTap: _onTabTapped,
            currentIndex:
                _currentIndex, // this will be set when a new tab is tapped
            items: [
              BottomNavigationBarItem(
                icon:
                    new Icon(Icons.home, color: Theme.of(context).buttonColor),
                activeIcon: Icon(Icons.home),
                title: new Text('Home',
                    style: TextStyle(
                        // Change the text color
                        color: _currentIndex == 0
                            ? Colors.white
                            : Theme.of(context).buttonColor)),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.search,
                    color: Theme.of(context).buttonColor),
                activeIcon: Icon(Icons.search),
                title: new Text('Search',
                    style: TextStyle(
                        // Change the text color
                        color: _currentIndex == 1
                            ? Colors.white
                            : Theme.of(context).buttonColor)),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.queue_music,
                      color: Theme.of(context).buttonColor),
                  activeIcon: Icon(Icons.queue_music),
                  title: Text('Queue music',
                      style: TextStyle(
                          // Change the text color
                          color: _currentIndex == 2
                              ? Colors.white
                              : Theme.of(context).buttonColor)))
            ],
            fixedColor: Colors.white,
            iconSize: 40.0,
          )),
      /* floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: Colors.orange,
        child: Icon(Icons.android),
      ),*/
    );
  }
}
