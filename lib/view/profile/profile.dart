import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Profile();
}

class _Profile extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  Map<String, dynamic> userInfo = {};
  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<Null> getUser() async {
    var usr = await _auth.currentUser();
    setState(() {
      user = usr;
    });
    await getDataUser();
    return null;
  }

  Future<Null> getDataUser() async {
    Firestore.instance
        .collection('user')
        .where("uid", isEqualTo: "${user.uid}")
        .snapshots()
        .take(1)
        .listen((data) => data.documents.forEach((doc) {
              setState(() {
                userInfo = doc.data;
              });
              print("${doc.data}");
            }));
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.network(userInfo['avatar'] != null ? userInfo['avatar'] : 'https://i.imgur.com/dcdi9zJ.png'),
        Text("Nombre: ${userInfo['name']}"),
        Text('Correo electronico ${userInfo['email']}'),
      ],
    );
  }
}
