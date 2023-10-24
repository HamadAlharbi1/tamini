import 'package:flutter/material.dart';

final ThemeData slateBlueLight = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF455A64), // Blue Grey

  colorScheme: const ColorScheme.light(
    primary: Color(0xFFCFD8DC), // Blue Grey
    secondary: Color(0xFF455A64), // Dark Blue Grey
  ),
  scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255), // White
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color(0xFF455A64), fontWeight: FontWeight.bold, fontSize: 24), // Dark Blue Grey
    headlineSmall: TextStyle(color: Color.fromARGB(255, 44, 44, 44), fontSize: 20), // Blue Grey
    bodyLarge: TextStyle(color: Color(0xFF455A64), fontSize: 16), // Dark Blue Grey
    bodyMedium: TextStyle(color: Color(0xFF757575), fontSize: 14), // Grey
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFBDBDBD)), // Light Grey
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF455A64)), // Dark Blue Grey
    ),
    labelStyle: TextStyle(color: Color(0xFF757575)), // Grey
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: const Color(0xFFFFFFFF), // White
      backgroundColor: const Color(0xFF455A64), // Dark Blue Grey
      textStyle: const TextStyle(fontSize: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  ),
  dividerTheme: const DividerThemeData(
    color: Color(0xFFBDBDBD), // Light Grey
    thickness: 2,
  ),
);

final ThemeData slateBlueDark = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color.fromARGB(255, 96, 125, 139), // Blue Grey
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF607D8B), // Blue Grey
    secondary: Color(0xFFCFD8DC), // Light Blue Grey
    onPrimary: Color(0xFFECEFF1), // Near White
    onSecondary: Color(0xFF455A64), // Dark Blue Grey
  ),
  scaffoldBackgroundColor: const Color.fromARGB(255, 38, 50, 56), // Black Blue Grey
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 24),
    headlineSmall: TextStyle(color: Color.fromARGB(255, 207, 216, 220), fontSize: 20), // Blue Grey
    bodyLarge: TextStyle(color: Colors.white70, fontSize: 16),
    bodyMedium: TextStyle(color: Color.fromARGB(255, 180, 212, 226), fontSize: 14),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF757575)), // Grey
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFECEFF1)), // Near White
    ),
    labelStyle: TextStyle(color: Colors.white70),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: const Color.fromARGB(255, 238, 239, 241), // Near White
      backgroundColor: const Color.fromARGB(255, 96, 125, 139), // Blue Grey
      textStyle: const TextStyle(fontSize: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  ),
  dividerTheme: const DividerThemeData(
    color: Color(0xFF757575), // Grey
    thickness: 2,
  ),
);
