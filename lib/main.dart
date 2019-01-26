import 'package:flutter/material.dart';
import 'package:we_trip_out/view/home/bottomNavigator.dart';
import 'package:we_trip_out/view/login.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:we_trip_out/view/sign_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => new ThemeData(
            primarySwatch: Colors.lightBlue,
            accentColor: Colors.redAccent,
            brightness: brightness,
            // textTheme: TextTheme(button: TextStyle(color: Colors.white))
          ),
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          title: 'We Trip Out',
          theme: theme,
          initialRoute: Login.routeName,
          routes: {
            Login.routeName: (context) => Login(),
            SigIn.routeName: (context) => SigIn(),
            BottomNavigator.routeName: (context) => BottomNavigator(),
          },
        );
      },
    );
  }
}
