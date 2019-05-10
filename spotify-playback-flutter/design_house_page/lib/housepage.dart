import 'package:flutter/material.dart';

class HousePage extends StatelessWidget {
  final Function setExplicitAllowed;
  final Function getExplicitAllowed;
  final Function setVotingEnabled;
  final Function getVotingEnabled;
  final Function setSelectedGenre;
  final Function getSelectedGenre;
  final Function setMaxQSize;
  final Function getMaxQSize;
  final Function setSongsPerPerson;
  final Function getSongsPerPerson;

  HousePage(
      this.setExplicitAllowed,
      this.getExplicitAllowed,
      this.setVotingEnabled,
      this.getVotingEnabled,
      this.setSelectedGenre,
      this.getSelectedGenre,
      this.setMaxQSize,
      this.getMaxQSize,
      this.setSongsPerPerson,
      this.getSongsPerPerson);

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
                  // SELECT GENRE
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
                  // TOGGLE EXPLICIT
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Explicit allowed",
                          style: Theme.of(context).textTheme.display1),
                      Switch(
                        activeColor: Theme.of(context).toggleableActiveColor,
                        inactiveTrackColor: Theme.of(context).buttonColor,
                        onChanged: (bool value) {
                          setExplicitAllowed(value);
                        },
                        value: getExplicitAllowed(),
                      ),
                    ],
                  ),
                  // TOGGLE VOTING
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Enable voting",
                          style: Theme.of(context).textTheme.display1),
                      Switch(
                        activeColor: Theme.of(context).toggleableActiveColor,
                        inactiveTrackColor: Theme.of(context).buttonColor,
                        onChanged: (bool value) {
                          setVotingEnabled(value);
                        },
                        value: getVotingEnabled(),
                      ),
                    ],
                  ),
                  // MAX SONGS IN QUEUE
                  Padding(padding: EdgeInsets.only(top: 25.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 25.0),
                      ),
                      Flexible(
                        child: TextField(
                          onChanged: (String input) {
                            // Ändrar Max Köstorlek, defaultar till 1000
                            int parsed = int.parse(input);
                            parsed is int
                                ? setMaxQSize(parsed)
                                : setMaxQSize(1000);
                          },
                          decoration: InputDecoration(
                            filled: true,
                            labelText: 'Max songs in queue (' +
                                getMaxQSize().toString() +
                                ')',
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
                          onChanged: (String input) {
                            // Ändrar max låtar per person, defaultar till 100
                            int parsed = int.parse(input);

                            parsed is int
                                ? setSongsPerPerson(parsed)
                                : setSongsPerPerson(100);

                            //print("Songs per person: " + _songsPerPerson.toString());
                          },
                          decoration: InputDecoration(
                            filled: true,
                            labelText: 'Max songs per person (' +
                                getSongsPerPerson().toString() +
                                ')',
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
