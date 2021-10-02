import 'package:flutter/material.dart';
import 'evoli.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Evoli app',
      // theme: ThemeData(
      //   scaffoldBackgroundColor: Color.fromRGBO(36, 61, 112, 1),
      //   fontFamily: 'Poppins',
      //   primaryColor: Colors.white,
      //   floatingActionButtonTheme: FloatingActionButtonThemeData(
      //     elevation: 0,
      //     foregroundColor: Colors.white,
      //   ),
      //   accentColor: Colors.redAccent,
      //   textTheme: TextTheme(
      //     headline1: TextStyle(fontSize: 22.0, color: Colors.redAccent),
      //     headline2: TextStyle(
      //       fontSize: 24.0,
      //       fontWeight: FontWeight.w700,
      //       color: Colors.redAccent,
      //     ),
      //     bodyText1: TextStyle(
      //       fontSize: 14.0,
      //       fontWeight: FontWeight.w400,
      //       color: Colors.blueAccent,
      //     ),
      //   ),
      // ),
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(36, 61, 112, 1),
      ),
      home: EvoliHome(),
    ),
  );
}
