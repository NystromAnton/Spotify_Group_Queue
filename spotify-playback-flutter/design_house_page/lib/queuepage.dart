import 'package:flutter/material.dart';
//import 'package:flutter_slidable/flutter_slidable.dart';

class QueuePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _QueueState();
  }
}

class _QueueState extends State<QueuePage> {
  /*bool _explicitAllowed;
  bool _votingEnabled;
  String _selectedGenre;
  int _maxQSize;
  int _songsPerPerson; */
  List<String> data = ["låt1", "låt2", "låt3", "låt4", "låt5", "låt6"];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, i) {
          return Text(data[i]);
        });
  }
}

/*children: <Widget>[
         // Theme(
              data: Theme.of(context),
              child: Column(
                  Slidable(
                    delegate: new SlidableDrawerDelegate(),
                    actionExtentRatio: 0.25,
                    child: new Container(
                      color: Colors.white,
                      child: new ListTile(
                        leading: new CircleAvatar(
                          backgroundColor: Colors.indigoAccent,
                          child: new Text('$3'),
                          foregroundColor: Colors.white,
                        ),
                        title: new Text('Tile n°$3'),
                        subtitle: new Text('SlidableDrawerDelegate'),
                      ),
                    ),
                    actions: <Widget>[
                      new IconSlideAction(
                        caption: 'Archive',
                        color: Colors.blue,
                        icon: Icons.archive,
                        onTap: () => _showSnackBar('Archive'),
                      ),
                      new IconSlideAction(
                        caption: 'Share',
                        color: Colors.indigo,
                        icon: Icons.share,
                        onTap: () => _showSnackBar('Share'),
                      ),
                    ],
                    secondaryActions: <Widget>[
                      new IconSlideAction(
                        caption: 'More',
                        color: Colors.black45,
                        icon: Icons.more_horiz,
                        onTap: () => _showSnackBar('More'),
                      ),
                      new IconSlideAction(
                        caption: 'Delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () => _showSnackBar('Delete'),
                      ),
                    ],
                  );

                  ),
          ),
                ],*/
