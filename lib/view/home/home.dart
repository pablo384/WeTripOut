import 'package:flutter/material.dart';
class Home extends StatefulWidget {

  @override
  State createState() => _Home();
}
class _Home extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ListView(
        children: <Widget>[
          Card(
            child: Column(
              children: <Widget>[
                Image.network('https://i.imgur.com/psTAraX.jpg'),
                Text('TITULO DE VIAJE'),
                Text('12/21/2019 8:00AM'),
              ],
            ),
          )
        ],
      ),
    );
  }
}