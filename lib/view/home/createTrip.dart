import 'package:flutter/material.dart';

class CreateTrip extends StatefulWidget {
  static const String routeName = '/trip/create';
  @override
  State<StatefulWidget> createState() => _CreateTrip();
  
}
class _CreateTrip extends State<CreateTrip> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Text('NUEVO VIAJE'),
    );
  }
  
}