import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("Search App"),
        backgroundColor: Colors.grey.withAlpha(100),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                //Byt bakgrund på sökfältet som poppar upp när man klickar!!
                showSearch(context: context, delegate: DataSearch());
              })
        ],
      ),
      body:
        Container(
          child:
          GridView.count(crossAxisCount: 2,
          children:
              List.generate(4, (index) {
                return Center(child: Text(
                  'Sina spellistor här',
                  style: TextStyle(color: Colors.white),
                ));
              })
          ),
        )



    ); //Scaffold
  } //Widget Build
}

class DataSearch extends SearchDelegate<String> {
  //actions for app bar
  final songs = [
    "Rihanna",
    "Beyonce",
    "Who let the dogs out",
    "All single ladies",
    "Cyklar ni så springer jag",
    "Höga klackar",
    "Min diamant",
  ];
  final recentSongs = [
    "Rihanna",
    "Beyonce",
    "Who let the dogs out",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on the left of app bar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some results based on the selections
    //ÄNDRA DETTA TILL NÅGOT RIMLIGT, typ en lista av json objekt som representerar låtar.
    return Center(
      child:Container(
      height:100.0,
      width: 100.0,
      child: Card(
      color: Colors.red,
      shape: StadiumBorder(),
      child: Center(
        child:  Text(query),
      ),
    ),
    ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    final suggestionList = query.isEmpty
        ? recentSongs
        : songs.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
            leading: Icon(
              Icons.music_note,
              color: Colors.white,
            ),
            title: RichText(
                text: TextSpan(
                    text: suggestionList[index].substring(0, query.length),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    children: [
                  TextSpan(
                      text: suggestionList[index].substring(query.length),
                      style: TextStyle(color: Colors.white))
                ])),
          ),
      itemCount: suggestionList.length,
    );
  }
}

//  backgroundColor: Theme.of(context).backgroundColor,
// body: Theme(
// data: Theme.of(context),
//  child:
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
//  GridView.count(
// crossAxisCount: 2,
// children: List.generate(4, (index) {
//  return Center(child: Text(
//  'Testing',
//  style: Theme.of(context).textTheme.display1,
// ));
// }),
// )) //Theme
//_SearchPage
