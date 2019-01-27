import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class Account extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Account();
}

class _Account extends State<Account> {
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
        .collection('account')
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
    child: Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            Icon(Icons.monetization_on)
          ],
        ),
        Column(
          children: <Widget>[
            Text('${doc.data['name']}'),
            Text('${doc.data['transactions'].length}')
          ],
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    if (_miLista.length == 0) return LinearProgressIndicator();

    return Column(
      children: _miLista,
    );
  }
}
