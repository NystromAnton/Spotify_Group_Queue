import 'package:flutter/material.dart';
import 'room.dart';
import 'package:flutter/services.dart';

class HousePage extends StatelessWidget {

  bool voting;
  bool explicit;
  String genre;
  int maxQ;
  int songPP;

  HousePage() {
    voting = Room.instance.getVoting();
    explicit = Room.instance.getExplicit();
    genre = Room.instance.getSelectedGenre();
    maxQ = Room.instance.getMaxQ();
    songPP = Room.instance.getMaxPerPerson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: ListView(children: <Widget>[
          Theme(
              data: Theme.of(context),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      RaisedButton(
                        //padding: EdgeInsets.only(left: 80.0),
                        textColor: Colors.white,
                        color: Colors.orange,
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, "/login");
                        },
                        child: Text(
                          'Exit room',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                      Text(
                        "My karma",
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ],
                  ),
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
                            Room.instance.getSelectedGenre() != null
                                ? Room.instance.getSelectedGenre()
                                : "Error",
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
                        //title: const Text("Explicit allowed"),
                        //dragStartBehavior: DragStartBehavior.start,
                        activeColor: Theme.of(context).toggleableActiveColor,
                        inactiveTrackColor: Theme.of(context).buttonColor,
                        onChanged: (bool value) {
                          explicit = value;
                        },
                        value: Room.instance.getExplicit(),
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
                          voting = value;
                        },
                        value: Room.instance.getVoting(),
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
                            parsed is int // Ett basic försök till error handling, osäker på om det är tillräckligt
                                ? maxQ = parsed
                                : maxQ = 1000;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            labelText: 'Max songs in queue (' +
                                Room.instance.getMaxQ().toString() +
                                ')',
                            hasFloatingPlaceholder: false,
                            fillColor: Theme.of(context).buttonColor,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              borderSide: new BorderSide(),
                            ),
                          ),
                          textAlign: TextAlign.center,
                          maxLength: 5,
                          style: Theme.of(context).textTheme.display1,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
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
                            parsed is int // Ett basic försök till error handling, osäker på om det är tillräckligt
                                ? songPP = parsed
                                : songPP = 100;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            labelText: 'Max songs per person (' +
                                Room.instance.getMaxPerPerson().toString() +
                                ')',
                            hasFloatingPlaceholder: false,
                            fillColor: Theme.of(context).buttonColor,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              borderSide: new BorderSide(),
                            ),
                          ),
                          textAlign: TextAlign.center,
                          maxLength: 5,
                          style: Theme.of(context).textTheme.display1,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 25.0),
                      ),
                    ],
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        textColor: Colors.white,
                        color: Colors.green,
                        child: Text("Save"),
                        onPressed: () {
                          Room.instance.saveHouseSettings(
                              voting, explicit, genre, maxQ, songPP);
                        },
                      )
                    ],
                  )
                ],
              ))
        ]));
  }
}
