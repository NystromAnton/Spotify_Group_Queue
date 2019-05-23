import 'package:flutter/material.dart';

import './loginpage.dart';
import './housepage.dart';
import './queuepage.dart';
import './searchpage.dart';
import './room.dart';
import './spotify-test.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final List<Widget> _children = [];

  int _currentIndex = 0;

  // METHODS
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    HousePage housePage = HousePage();

    SearchPage searchPage = SearchPage();

    QueuePage queuePage = QueuePage();

    

    _children.add(housePage);
    _children.add(searchPage);
    _children.add(queuePage);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/titelbildensaken.png'),
        actions: <Widget>[
          Center(
            child: Text(
              "Room " + Room.instance.roomName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                //padding: EdgeInsets.only(left: 25.0),
              ),
            ),
          ),
        ],
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
                  icon: new Icon(Icons.queue_music,
                      color: Theme.of(context).buttonColor),
                  activeIcon: Icon(Icons.queue_music),
                  title: Text('Queue',
                      style: TextStyle(
                          // Change the text color
                          color: _currentIndex == 2
                              ? Colors.white
                              : Theme.of(context).buttonColor))),
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
