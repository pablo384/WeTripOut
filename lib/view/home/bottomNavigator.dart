import 'package:flutter/material.dart';
import 'package:we_trip_out/view/home/home.dart';

class BottomNavigator extends StatefulWidget {
  static const String routeName = '/home';
  @override
  State createState() => _BottomNavigator();
}

class _BottomNavigator extends State<BottomNavigator> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Home(),
    Text('02'),
    Text('03'),
    Text('04     ')
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        // title: Text('My Flutter App', style: TextStyle(color: Colors.white),
        // ),
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
              onPressed: () {},
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
