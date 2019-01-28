import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:we_trip_out/view/tripViewer.dart';

class TripCard extends StatelessWidget {
  final String _id;
  final String _title;
  final int _since;
  final int _to;
  final int _budget;
  TripCard({
    @required String id,
    @required String title,
    @required dynamic since,
    @required dynamic to,
    @required int budget,
  })  : _id = id,
        _title = title,
        _budget = budget,
        _to = to,
        _since = since;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: _id,
              child: Image.network(
                'https://amp.thisisinsider.com/images/5bfec49248eb12058423acf7-750-562.jpg',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              _title,
              style: Theme.of(context).textTheme.headline,
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                    '${new DateFormat("yMd").format(new DateTime.fromMillisecondsSinceEpoch(_since))}'),
                Text('Presupuesto: RD\$$_budget'),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    String url = 'https://pablo384.com/trip/$_id';
                    Share.share('Unete a mi viaje en $url');
                  },
                ),
                FlatButton(
                  child: Text('Leer mas'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TripViewer(
                                id: _id,
                              )),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
