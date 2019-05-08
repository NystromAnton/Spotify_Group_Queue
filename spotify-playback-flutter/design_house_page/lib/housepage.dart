import 'package:flutter/material.dart';

class HousePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HouseState();
  }
}

class _HouseState extends State<HousePage> {
  bool _explicitAllowed;
  bool _votingEnabled;
  String _selectedGenre;
  int _maxQSize;
  int _songsPerPerson;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
        children: <Widget>[
          Theme(
              data: Theme.of(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Genre",
                          style: Theme.of(context).textTheme.display1),
                      RaisedButton(
                        onPressed: () {},
                        child: Text(
                            "Country", // TILLFÄLLIG LÖSNING, SKA ÄNDRAS DYNAMISKT
                            style: Theme.of(context).textTheme.display1),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Explicit allowed",
                          style: Theme.of(context).textTheme.display1),
                      Switch(
                        activeColor: Theme.of(context).toggleableActiveColor,
                        inactiveTrackColor: Theme.of(context).buttonColor,
                        onChanged: (bool value) {
                          value = !value;
                        },
                        value: false,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Enable voting",
                          style: Theme.of(context).textTheme.display1),
                      Switch(
                        activeColor: Theme.of(context).toggleableActiveColor,
                        inactiveTrackColor: Theme.of(context).buttonColor,
                        onChanged: (bool value) {
                          value = !value;
                        },
                        value: false,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Flexible(
                        child: Text("Songs in queue",
                            style: Theme.of(context).textTheme.display1),
                      ),
                      Flexible(
                        child: TextField(
                          decoration: null,
                          textAlign: TextAlign.center,
                          maxLength: 5,
                          style: Theme.of(context).textTheme.display2,
                          controller: TextEditingController(text: "30"),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Flexible(
                        child: Text("Songs per person",
                            style: Theme.of(context).textTheme.display1),
                      ),
                      Flexible(
                        child: TextField(
                          decoration: null,
                          textAlign: TextAlign.center,
                          maxLength: 5,
                          style: Theme.of(context).textTheme.display2,
                          controller: TextEditingController(text: "5"),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
