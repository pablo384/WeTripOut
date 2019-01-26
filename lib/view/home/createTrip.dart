import 'package:flutter/material.dart';
import 'package:we_trip_out/view/components/dateTimePicker.dart';
import 'package:we_trip_out/view/components/mapsLocationPicker.dart';
import 'package:we_trip_out/view/components/tripButton.dart';
import 'package:flutter/services.dart';
import 'package:google_places_picker/google_places_picker.dart';

class CreateTrip extends StatefulWidget {
  static const String routeName = '/trip/create';
  @override
  State<StatefulWidget> createState() => _CreateTrip();
}

class _CreateTrip extends State<CreateTrip> {
  final _formKey = GlobalKey<FormState>();
  String _placeName = 'Unknown';
  DateTime _fromDate = DateTime.now();
  TimeOfDay _fromTime = const TimeOfDay(hour: 7, minute: 28);
  DateTime _toDate = DateTime.now();
  TimeOfDay _toTime = const TimeOfDay(hour: 7, minute: 28);
  Map<String, double> _location = {};

  _showPlacePicker() async {
    String placeName;
    // Platform messages may fail, so we use a try/catch PlatformException.
    var place = await PluginGooglePlacePicker.showPlacePicker();
    placeName = place.name;


    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted)
      return;

    setState(() {
      _placeName = placeName;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Container(
        // decoration: BoxDecoration(
        //     color: Colors.white,
        //     image: DecorationImage(
        //         image: AssetImage("assets/edificios01.png"),
        //         fit: BoxFit.contain,
        //         alignment: Alignment.bottomCenter)),
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
              Text('Ubicacion: $_placeName'),
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
              TextFormField(
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Favor ingresar Titulo del viaje';
                  }
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
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Detalles del viaje',
                  labelText: 'Detalles del viaje',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TripButton(
                texto: 'Crear mi viaje',
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void showMOdal() {
    Navigator.push(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => MapsLocationPicker(location: (loc) {
            setState(() {
              _location = loc;
            });
          },),
          fullscreenDialog: true,
        ));
  }
}
