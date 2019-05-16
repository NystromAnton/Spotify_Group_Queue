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
        body: Theme(
            data: Theme.of(context),
            child:
                // Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: <Widget>[
                //       Padding(padding: EdgeInsets.only(left: 15.0)),
                //       TextField(
                //         style: Theme.of(context).textTheme.display2,
                //         decoration: InputDecoration(
                //             icon: Icon(
                //               Icons.search,
                //               color: Theme.of(context).buttonColor,
                //               size: 50.0,
                //             ),
                //             filled: true,
                //             labelText: 'Search',
                //             fillColor: Colors.white,
                //             hasFloatingPlaceholder: false,
                //             contentPadding: EdgeInsets.all(10.0),
                //             border: new OutlineInputBorder(
                //               borderRadius: new BorderRadius.circular(15.0),
                //               borderSide: new BorderSide(),
                //             ) //border

                //             ), //InputDecoration
                //       ) //TextField

                //           ,
                //       Padding(
                //         padding: EdgeInsets.only(right: 15.0),
                //       )
                //     ] // children: <Widget> #3
                //     ), //Row
                GridView.count(
              crossAxisCount: 2,
              children: List.generate(4, (index) {
                return Center(child: Text(
                  'Testing',
                  style: Theme.of(context).textTheme.display1,
                ));
              }),
            )) //Theme
        ); //Scaffold
  } //Widget Build
} //_SearchPage
