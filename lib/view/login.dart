import 'package:flutter/material.dart';
import 'package:we_trip_out/view/loginForm.dart';

class Login extends StatefulWidget {
  @override
  State createState() => _LoginState();
}

class _LoginState extends State<Login> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      resizeToAvoidBottomPadding: false,
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.6,
                child: LoginForm(),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/edificio01.png"))
        ),
      ),
    );
  }
}