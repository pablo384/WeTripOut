import 'package:flutter/material.dart';
import 'package:we_trip_out/view/home/bottomNavigator.dart';
import 'package:we_trip_out/view/home/createTrip.dart';
import 'package:we_trip_out/view/login.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:we_trip_out/view/sign_in.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => new ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.redAccent,
            brightness: brightness,
          ),
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          title: 'We Trip Out',
          theme: theme,
          initialRoute: MySplash.routeName,
          routes: {
            MySplash.routeName: (context) => MySplash(),
            Login.routeName: (context) => Login(),
            SigIn.routeName: (context) => SigIn(),
            BottomNavigator.routeName: (context) => BottomNavigator(),
            CreateTrip.routeName: (context) => CreateTrip(),
          },
        );
      },
    );
  }
}

class MySplash extends StatefulWidget {
  static const String routeName = '/';
  @override
  _MySplashState createState() => new _MySplashState();
}

class _MySplashState extends State<MySplash> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Widget next() {
    return _auth.currentUser() != null ? BottomNavigator() : Login();
  }
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 14,
      navigateAfterSeconds: next(),
      title: new Text('Welcome In SplashScreen',
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0
      ),),
      image: new Image.network('https://i.imgur.com/TyCSG9A.png'),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: ()=>print("Flutter Egypt"),
      loaderColor: Colors.red
    );
  }
}