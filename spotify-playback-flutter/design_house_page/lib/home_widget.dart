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
    PlaceholderWidget(Colors.black),
    PlaceholderWidget(Colors.black),
    PlaceholderWidget(Colors.black)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/titelbildensaken.png'),
        backgroundColor: Colors.black,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.search),
            title: new Text('Search'),

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.queue_music),
              title: Text('Queue music')
          )
        ],
        fixedColor: Colors.orange,
        iconSize: 40.0,
      ),
      /* floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: Colors.orange,
        child: Icon(Icons.android),
      ),*/
    );
  }
  void onTabTapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }
}

