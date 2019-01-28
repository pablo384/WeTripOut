import 'package:flutter/material.dart';
import 'package:we_trip_out/view/components/dateTimePicker.dart';
import 'package:we_trip_out/view/components/mapsLocationPicker.dart';
import 'package:we_trip_out/view/components/tripButton.dart';
import 'package:flutter/services.dart';
import 'package:google_places_picker/google_places_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class CreateTrip extends StatefulWidget {
  static const String routeName = '/trip/create';
  @override
  State<StatefulWidget> createState() => _CreateTrip();
}

class _CreateTrip extends State<CreateTrip> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _placeName = 'Unknown';
  DateTime _fromDate = DateTime(2020);
  TimeOfDay _fromTime = const TimeOfDay(hour: 7, minute: 28);
  DateTime _toDate = DateTime(2020);
  TimeOfDay _toTime = const TimeOfDay(hour: 7, minute: 28);
  Map<String, double> _location = {};

  int _budget = 0;
  var _rangeDays = 30;
  var _faltan = 0;
  var _faltanMeses = 0;
  var _ahorrar = '0';
  Place _place;
  String _eventTitle = '';
  String _eventDetails = '';

  List<DropdownMenuItem> _listCuentas = [];
  String _selectedAccount;

  @override
  void initState() {
    super.initState();
    _getAccounts();
  }

  Future<Null> _getAccounts() async {
    FirebaseUser usr = await _auth.currentUser();
    Firestore db = Firestore.instance;
    db
        .collection('account')
        .where('owner', isEqualTo: usr.uid)
        .snapshots()
        .take(1)
        .listen((result) {
      result.documents.forEach((doc) {
        // doc.documentID
        print('${doc.documentID}');
        print('${doc.data}');

        setState(() {
          _listCuentas.add(DropdownMenuItem(
            child: Text('${doc.data['name']}'),
            value: doc.documentID,
          ));
          _selectedAccount = _listCuentas[0].value;
        });
      });
    });

    return null;
  }

  _showPlacePicker() async {
    String placeName;
    Place place = await PluginGooglePlacePicker.showPlacePicker();
    placeName = place.name;
    if (!mounted) return;

    setState(() {
      _place = place;
      _placeName = placeName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  _showPlacePicker();
                },
                textColor: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.location_on),
                    Text('¿A donde viajaras?')
                  ],
                ),
                color: Theme.of(context).accentColor,
              ),
              Text('Ubicacion: $_placeName' +
                  (_place != null ? ', ' + _place.address : '')),
              SizedBox(
                height: 8.0,
              ),
              DateTimePicker(
                labelText: 'Desde',
                selectedDate: _fromDate,
                selectedTime: _fromTime,
                selectDate: (DateTime date) {
                  setState(() {
                    _fromDate = date;
                  });
                },
                selectTime: (TimeOfDay time) {
                  setState(() {
                    _fromTime = time;
                  });
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              DateTimePicker(
                labelText: 'Hatas',
                selectedDate: _toDate,
                selectedTime: _toTime,
                selectDate: (DateTime date) {
                  setState(() {
                    _toDate = date;
                  });
                },
                selectTime: (TimeOfDay time) {
                  setState(() {
                    _toTime = time;
                  });
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                  'Faltan $_faltan dias ($_faltanMeses meses), a un plazo de $_rangeDays debes ahorrar $_ahorrar'),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                onFieldSubmitted: (val) {
                  setState(() {
                    _budget = int.parse(val);
                  });
                  calculateDays();
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Favor ingresar Presupuesto del viaje';
                  }
                  setState(() {
                    _budget = int.parse(value);
                  });
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Presupuesto del viaje',
                    labelText: 'Presupuesto del viaje',
                    prefix: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('RD'),
                        Icon(Icons.attach_money),
                      ],
                    ),
                    suffixText: '.00'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Favor ingresar Titulo del viaje';
                  }
                  setState(() {
                    _eventTitle = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Titulo del viaje',
                  labelText: 'Titulo del viaje',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Favor ingresar Detalles del viaje';
                  }
                  setState(() {
                    _eventDetails = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Detalles del viaje',
                  labelText: 'Detalles del viaje',
                ),
              ),
              DropdownButton(
                value: _selectedAccount,
                items: _listCuentas,
                onChanged: (se) => setState(() {
                      _selectedAccount = se;
                    }),
                hint: Text('Cuenta a seleccionar'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TripButton(
                texto: 'Crear mi viaje',
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    // Scaffold.of(context).showSnackBar(
                    //     SnackBar(content: Text('Processing Data')));
                    crearEvento();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> crearEvento() async {
    FirebaseUser user = await _auth.currentUser();
    DateTime inicion = DateTime(_fromDate.year, _fromDate.month, _fromDate.day,
        _fromTime.hour, _fromTime.minute);
    DateTime fin = DateTime(
        _toDate.year, _toDate.month, _toDate.day, _toTime.hour, _toTime.minute);
    var data = {
      'owner': user.uid,
      'type': 'public',
      'account': _selectedAccount,
      'since': inicion.toUtc().millisecondsSinceEpoch,
      'to': fin.toUtc().millisecondsSinceEpoch,
      'budget': _budget,
      'title': _eventTitle,
      'details': _eventDetails,
      'place': {
        'id': _place.id,
        'latitude': _place.latitude,
        'longitude': _place.longitude,
        'name': _place.name,
        'address': _place.address,
      }
    };
    print(data);
    await Firestore.instance.collection('events').document().setData(data);
    Navigator.of(context).pop();

    return null;
  }

  calculateDays() {
    DateTime inicio = DateTime.now();
    DateTime fin = DateTime(
        _toDate.year, _toDate.month, _toDate.day, _toTime.hour, _toTime.minute);
    // var tem = ;
    setState(() {
      _faltan = fin.difference(inicio).inDays;
      _faltanMeses = (_faltan ~/ _rangeDays);
      _ahorrar = (_budget / _faltanMeses).toStringAsFixed(2);
    });
    print('DIFERNCIA:');
    // print(fin.difference(inicio).inDays.toString());
    print('FALTAN:');
    print('$_faltan meses');

    print('PRESUPUESTP: $_budget');
    print('A _ahorrar: $_ahorrar');
  }

  void showMOdal() {
    Navigator.push(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => MapsLocationPicker(
                location: (loc) {
                  setState(() {
                    _location = loc;
                  });
                },
              ),
          fullscreenDialog: true,
        ));
  }
}
