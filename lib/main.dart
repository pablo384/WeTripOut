import 'package:flutter/material.dart';
import 'package:we_trip_out/view/home/bottomNavigator.dart';
import 'package:we_trip_out/view/home/createTrip.dart';
import 'package:we_trip_out/view/login.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:we_trip_out/view/sign_in.dart';

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
          initialRoute: Login.routeName,
          routes: {
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
