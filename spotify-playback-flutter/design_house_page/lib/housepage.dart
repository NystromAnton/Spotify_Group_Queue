import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HousePage extends StatelessWidget {

  // Se TODO Skrolla längst ned

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
        body: ListView(children: <Widget>[
          Theme(
              data: Theme.of(context),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      RaisedButton(
                        //padding: EdgeInsets.all(13.0),
                        textColor: Colors.white,
                        color: Colors.orange,
                        onPressed: () {
                          //Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, "/login");
                        },
                        child: Text(
                          'Log out',
                            style: TextStyle(fontSize: 18.0),
                         ),
                       ),
                    ],
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
                        //title: const Text("Explicit allowed"),
                        //dragStartBehavior: DragStartBehavior.start,
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
                            parsed is int // Ett basic försök till error handling, osäker på om det är tillräckligt
                                ? setMaxQSize(parsed)
                                : setMaxQSize(1000);
                          },
                          decoration: InputDecoration(
                            filled: true,
                            labelText: 'Max songs in queue (' +
                                getMaxQSize().toString() +
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
                          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
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
                                ? setSongsPerPerson(parsed)
                                : setSongsPerPerson(100);
                          },
                          decoration: InputDecoration(
                            filled: true,
                            labelText: 'Max songs per person (' +
                                getSongsPerPerson().toString() +
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
                          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 25.0),
                      ),
                    ],
                  ),
                  /* Save knapp för att användaren ska känna att options parametrar
                  blivit sparade. 
                  TODO: Implementera att parametrarna sparas i ett Form ist för direkt
                  när man skriver (onChange) som det är nu, så när man trycker på save
                  refreshas sidan och ens parametrar är sparade. 
                  EXTENDED TODO: Save knappen triggar ett servercall som notifierar
                  backend/rummedlemmar om de nya reglerna*/
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        textColor: Colors.white,
                        color: Colors.green,
                        child: Text("Save"),
                        onPressed: () {
                          
                        },
                      )
                    ],
                  )
                ],
              ))
        ]));
  }
}
