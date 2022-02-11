import 'package:flutter/material.dart';
import 'package:weather_app/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pronóstico',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF20B2AA, {
          50: Color.fromRGBO(184, 163, 149, .1),
          100: Color.fromRGBO(184, 163, 149, .2),
          200: Color.fromRGBO(184, 163, 149, .3),
          300: Color.fromRGBO(184, 163, 149, .4),
          400: Color.fromRGBO(184, 163, 149, .5),
          500: Color.fromRGBO(184, 163, 149, .6),
          600: Color.fromRGBO(184, 163, 149, .7),
          700: Color.fromRGBO(184, 163, 149, .8),
          800: Color.fromRGBO(184, 163, 149, .9),
          900: Color.fromRGBO(184, 163, 149, 1),
        }),
      ),
      home: PageHome(),
    );
  }
}