import 'package:cloud_firestore/cloud_firestore.dart';
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
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('events').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return ListView(
            children: snapshot.data.documents.map<Widget>((doc) {
              var dt = doc.data;
              return TripCard(id: doc.documentID, title: dt['title'], budget: dt['budget'], since: dt['since'], to: dt['to'],);
            }).toList(),
          );
        },
      ),
    );
  }
}
