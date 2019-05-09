import 'package:flutter/material.dart';

class HousePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HouseState();
  }
}

class _HouseState extends State<HousePage> {
  bool explicitAllowed;
  bool votingEnabled;
  String selectedGenre;
  int maxQSize;
  int songsPerPerson;

  _HouseState({this.explicitAllowed = true, this.votingEnabled = true, this.selectedGenre, 
   this.maxQSize = 1000, this.songsPerPerson = 100});

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
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
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
                  Padding(padding: EdgeInsets.only(top: 25.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 25.0),
                      ),
                      Flexible(
                        child: TextField(
                          onChanged: (String input) { // Ändrar Max Köstorlek, defaultar till 1000
                            int parsed = int.parse(input);
                            parsed is int
                                ? maxQSize = parsed
                                : maxQSize = 1000;
                            //print("Max queue size: " + _maxQSize.toString());
                          },
                          decoration: InputDecoration(
                            filled: true,
                            labelText: 'Max songs in queue',
                            fillColor: Theme.of(context).buttonColor,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              borderSide: new BorderSide(),
                            ),
                          ),
                          textAlign: TextAlign.center,
                          maxLength: 5,
                          style: Theme.of(context).textTheme.display1,
                          //controller: TextEditingController(text: "30"),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 25.0),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25.0),
                  ),
                  // MAX SONGS PER PERSON
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 25.0),
                      ),
                      Flexible(
                        child: TextField(
                          onChanged: (String input) { // Ändrar max låtar per person, defaultar till 100
                            int parsed = int.parse(input);
                            parsed is int
                                ? songsPerPerson = parsed
                                : songsPerPerson = 100;
                            //print("Songs per person: " + _songsPerPerson.toString());
                          },
                          decoration: InputDecoration(
                            filled: true,
                            labelText: 'Max songs per person',
                            fillColor: Theme.of(context).buttonColor,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              borderSide: new BorderSide(),
                            ),
                          ),
                          textAlign: TextAlign.center,
                          maxLength: 5,
                          style: Theme.of(context).textTheme.display1,
                          //controller: TextEditingController(text: "30"),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 25.0),
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
