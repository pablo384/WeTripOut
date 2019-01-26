import 'package:flutter/material.dart';
import 'package:we_trip_out/view/home/home.dart';
class BottomNavigator extends StatefulWidget {
  static const String routeName = '/home';
  @override
  State createState() => _BottomNavigator();
}
class _BottomNavigator extends State<BottomNavigator> {

  int _currentIndex = 0;
  final List<Widget> _children = [Home(),Text('02'),Text('03'),Text('04     ')];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Flutter App', style: TextStyle(color: Colors.white),),
        automaticallyImplyLeading: false,
      ),
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex,
//        fixedColor: Colors.lightBlue,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Inicio'),
              backgroundColor: Colors.lightBlue
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.flight),
            title: Text('Mis viajes'),
              backgroundColor: Colors.lightBlue
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            title: Text('Cuentas'),
              backgroundColor: Colors.lightBlue

          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Perfil'),
              backgroundColor: Colors.lightBlue
          )
        ],
      ),
    );

  }
}