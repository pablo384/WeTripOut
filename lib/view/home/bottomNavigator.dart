import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:we_trip_out/view/account/account.dart';
import 'package:we_trip_out/view/home/createTrip.dart';
import 'package:we_trip_out/view/home/home.dart';
import 'package:we_trip_out/view/home/myTrips.dart';
import 'package:we_trip_out/view/login.dart';
import 'package:we_trip_out/view/profile/profile.dart';

class BottomNavigator extends StatefulWidget {
  static const String routeName = '/home';
  @override
  State createState() => _BottomNavigator();
}

class _BottomNavigator extends State<BottomNavigator> {
  int _currentIndex = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<Widget> _children = [
    Home(),
    MyTrip(),
    Account(),
    Profile()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void logut() async {
    await _auth.signOut();
    Navigator.of(context).pushNamed(Login.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: logut,)
        ],
        automaticallyImplyLeading: false,
      ),
      body: _children[_currentIndex],
      floatingActionButton: _currentIndex == 1
          ? RaisedButton(
              color: Theme.of(context).accentColor,
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Nuevo viaje',
                style: TextStyle(color: Colors.white),
              ),
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0))),
              onPressed: () => Navigator.of(context).pushNamed(CreateTrip.routeName),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex,
        items: [
          new BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Inicio'),
              backgroundColor: Colors.lightBlue),
          new BottomNavigationBarItem(
              icon: Icon(Icons.flight),
              title: Text('Mis viajes'),
              backgroundColor: Colors.lightBlue),
          new BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on),
              title: Text('Cuentas'),
              backgroundColor: Colors.lightBlue),
          new BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Perfil'),
              backgroundColor: Colors.lightBlue)
        ],
      ),
    );
  }
}
