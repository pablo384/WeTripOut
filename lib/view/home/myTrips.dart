import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyTrip extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyTrip();
  
}
class _MyTrip extends State<MyTrip> {

    final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Widget> _miLista = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<Null> getData() async {
    FirebaseUser usr = await _auth.currentUser();
    Firestore db = Firestore.instance;
    db
        .collection('events')
        .where('owner', isEqualTo: usr.uid)
        .snapshots()
        .take(1)
        .listen((result) {
      result.documents.forEach((doc) {
        setState(() {
          _miLista.add(card(doc));
        });
      });
    });

    return null;
  }

  Widget card(DocumentSnapshot doc) => Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Image.network(
                'https://amp.thisisinsider.com/images/5bfec49248eb12058423acf7-750-562.jpg',
                fit: BoxFit.cover,
                width: 100.0,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('${doc.data['title']}', textAlign: TextAlign.center,),
              Text('${doc.data['type']}', textAlign: TextAlign.center,),
              Text('Presupuesto p/p: RD\$${doc.data['budget']}', textAlign: TextAlign.center,),
            ],
          ),
        ],
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    if (_miLista.length == 0) return LinearProgressIndicator();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: _miLista,
      ),
    );
  }
  
}