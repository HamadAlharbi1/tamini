import 'package:flutter/material.dart';

final ThemeData primaryTheme = ThemeData(
    primaryColor: const Color.fromARGB(255, 54, 76, 87),
    colorScheme: const ColorScheme.light(
      primary: Color.fromARGB(255, 67, 105, 56),
      secondary: Color.fromARGB(255, 63, 61, 55),
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
        titleLarge: TextStyle(color: Colors.blueGrey[900], fontWeight: FontWeight.w500, fontSize: 20),
        titleMedium: TextStyle(
          color: Colors.blueGrey[600],
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: Colors.blueGrey[900],
          fontSize: 14,
        ),
        bodySmall: TextStyle(
          color: Colors.blueGrey[600],
          fontSize: 12,
        )),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueGrey[200]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueGrey[400]!),
      ),
      labelStyle: TextStyle(color: Colors.blueGrey[600]),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 71, 82, 81),
            textStyle: const TextStyle(fontSize: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)))));
