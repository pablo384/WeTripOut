import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TripViewer extends StatefulWidget {
  static const String routeName = '/viewer';
  final String _id;
  TripViewer({String id}) : _id = id;
  @override
  State<StatefulWidget> createState() => _TripViewer();
}

class _TripViewer extends State<TripViewer> {
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('events')
              .document(widget._id)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return LinearProgressIndicator();

            var dt = snapshot.data.data;
            // snapshot.
            return ListView(
              children: <Widget>[
                Hero(
                  tag: widget._id,
                  child: Image.network(
                    'https://amp.thisisinsider.com/images/5bfec49248eb12058423acf7-750-562.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  dt['title'],
                  style: Theme.of(context).textTheme.headline,
                  textAlign: TextAlign.center,
                ),
                Text(dt['details']),
                Text(
                    'Fecha de viaje: ${new DateFormat("yMd").format(new DateTime.fromMillisecondsSinceEpoch(dt['since']))}'),
                Text('Direccion:'),
                Text(dt['place']['name']),
                Text(dt['place']['address']),
              ],
            );
          }),
    );
  }
}
