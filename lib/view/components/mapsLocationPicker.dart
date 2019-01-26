import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';
import 'package:we_trip_out/view/components/tripButton.dart';

class MapsLocationPicker extends StatefulWidget {
  final _location;
  MapsLocationPicker({
    Function(Map<String, double> loc) location
  }) : _location = location;
  @override
  State<StatefulWidget> createState() => _MapsLocationPicker();
}

class _MapsLocationPicker extends State<MapsLocationPicker> {
  GoogleMapController mapController;
  final subject = new BehaviorSubject<Map<String, double>>();
  StreamSubscription sub;

  @override
  void initState() {
    super.initState();
    sub = subject
    // .delay(Duration(milliseconds: 500))
    .throttle(new Duration(milliseconds: 1000))
    .listen((val) {
      print('RES: $val');
      mapController.clearMarkers();
      mapController.addMarker(
        MarkerOptions(
          position: LatLng(val['lat'], val['lng'])
        )
      );
    });
  }
  
  @override
  void dispose() {
    super.dispose();
    sub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Text(
            'Seleccione el lugar a viajar:',
            style: Theme.of(context).textTheme.title,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.7,
            child: GoogleMap(
              myLocationEnabled: true,
              trackCameraPosition: true,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                bearing: 270.0,
                target: LatLng(51.5160895, -0.1294527),
                tilt: 30.0,
                zoom: 17.0,
              ),
            ),
          ),
          TripButton(
            texto: 'Guardar',
            onPressed: () {
              widget._location(subject.value);
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
      // mapController.cam
      // mapController.addMarker(MarkerOptions(
      //   position: LatLng(37.4219999, -122.0862462),
      // ));

      mapController.clearMarkers();
      mapController.addListener(() {
        print('escuchando');
        print(mapController.cameraPosition.target.toString());
        // mapController.addMarker(MarkerOptions(
        //   position: LatLng(mapController.cameraPosition.target.latitude, mapController.cameraPosition.target.longitude),
        // ));
        subject.add({
          'lat': mapController.cameraPosition.target.latitude,
          'lng': mapController.cameraPosition.target.longitude
        });
      });
    });
  }
}
