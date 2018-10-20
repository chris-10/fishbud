import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Container(
    child: new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Icon(
          Icons.dashboard,
          size: 150.0,
          color: Colors.black12
        ),
        new Text('Dashboard tab content')
      ]
    ),
  );
}