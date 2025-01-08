import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    color: Colors.blue,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue,
    textTheme: ButtonTextTheme.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue, // Background color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.blue),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.blueAccent),
    ),
    labelStyle: TextStyle(color: Colors.blue),
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(color: Colors.white), // Headline color
    bodyLarge: TextStyle(color: Colors.black), // Body text color
    bodyMedium: TextStyle(color: Colors.grey[800]), // Secondary text color
    labelLarge: TextStyle(color: Colors.white), // Button text color (Material 3)
  ),
  iconTheme: IconThemeData(color: Colors.blue),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blueGrey,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: AppBarTheme(
    color: Colors.blueGrey,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blueGrey,
    textTheme: ButtonTextTheme.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blueGrey, // Background color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.blueGrey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.lightBlueAccent),
    ),
    labelStyle: TextStyle(color: Colors.blueGrey),
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(color: Colors.white), // Headline color
    bodyLarge: TextStyle(color: Colors.white), // Body text color
    bodyMedium: TextStyle(color: Colors.grey[300]), // Secondary text color
    labelLarge: TextStyle(color: Colors.white), // Button text color (Material 3)
  ),
  iconTheme: IconThemeData(color: Colors.blueGrey),
);
