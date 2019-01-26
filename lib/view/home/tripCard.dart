import 'package:flutter/material.dart';

class TripCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Image.network(
              'https://i.imgur.com/psTAraX.jpg',
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'TITULO DE VIAJE',
              style: Theme.of(context).textTheme.headline,
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('12/21/2019 8:00AM'),
                FlatButton(
                  child: Text('Leer mas'),
                  onPressed: () {},
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
