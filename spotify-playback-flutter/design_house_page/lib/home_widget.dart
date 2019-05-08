import 'placeholder_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    PlaceholderWidget(Colors.white),
    PlaceholderWidget(Colors.black),
    PlaceholderWidget(Colors.yellow)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/titelbildensaken.png'),
        backgroundColor: Colors.black,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: Theme(
          data: Theme.of(context),
          child: BottomNavigationBar(
            onTap: onTabTapped,
            currentIndex:
                _currentIndex, // this will be set when a new tab is tapped
            items: [
              BottomNavigationBarItem(
                icon:
                    new Icon(Icons.home, color: Theme.of(context).buttonColor),
                activeIcon: Icon(Icons.home),
                title: new Text('Home',
                    style: TextStyle(
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

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
