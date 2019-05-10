import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchState();
  } //State<StatefulWidget>
} //SearchPage

class _SearchState extends State<SearchPage> {

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
                    children: <Widget>[Padding(padding: EdgeInsets.only(left:15.0)),Flexible(
                          child: TextField(
                              style: Theme.of(context).textTheme.display1,
                              decoration: InputDecoration( //TODO: Fixa så att förstoringsglaset är en icon.
                                      icon: Icon(Icons.search, color: Theme.of(context).buttonColor, size: 50.0,),
                                      filled: true,
                                      labelText: '🔍Search',
                                      fillColor: Colors.white,
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: new OutlineInputBorder(
                                          borderRadius: new BorderRadius.circular(15.0),
                                          borderSide: new BorderSide(),

                                      )//border

                                ),//InputDecoration
                                ) //TextField
                        )//Flexible
                    ]// children: <Widget> #3
                  ),//Row
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
              ),//Row#2
                ], //Children: <Widget> #2
              ) // Column
          )//Theme
        ], //children: <Widget>
      ), // Body: ListView
    ); //Scaffold
  } //Widget Build
} //_SearchPage
