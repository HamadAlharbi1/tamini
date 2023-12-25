import 'package:flutter/material.dart';

final ThemeData slateBlueLight = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF646ECB),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF646ECB),
  ),
  scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color(0xFF646ECB), fontWeight: FontWeight.bold, fontSize: 24),
    bodyLarge: TextStyle(color: Color(0xFF646ECB), fontSize: 16),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF646ECB)),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF646ECB),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  ),
);

final ThemeData slateBlueDark = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF646ECB),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF646ECB),
    onPrimary: Colors.white,
  ),
  scaffoldBackgroundColor: const Color.fromARGB(255, 38, 50, 56),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 24),
    bodyLarge: TextStyle(color: Colors.white70, fontSize: 16),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xFF646ECB),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  ),
);
