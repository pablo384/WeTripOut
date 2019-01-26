import 'package:flutter/material.dart';
import 'package:we_trip_out/view/home/tripCard.dart';
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
          TripCard(),
          TripCard(),
          TripCard(),
          TripCard(),
          TripCard(),
        ],
      ),
    );
  }
}