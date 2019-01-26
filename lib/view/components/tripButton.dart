import 'package:flutter/material.dart';

class TripButton extends StatelessWidget {
  final _texto;
  final _onPressed;
  TripButton({
    @required String texto,
    @required Function onPressed,
  })  : _texto = texto,
        _onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.lightBlue,
      shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0))),
      onPressed: _onPressed,
      child: Text(
        _texto,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
