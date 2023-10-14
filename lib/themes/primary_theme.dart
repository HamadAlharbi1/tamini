import 'package:flutter/material.dart';

final ThemeData emeraldDusk = ThemeData(
  primaryColor: const Color.fromARGB(255, 37, 78, 78),
  colorScheme: const ColorScheme.light(
    primary: Color.fromARGB(255, 67, 105, 56),
    secondary: Color.fromARGB(255, 63, 61, 55),
  ),
  scaffoldBackgroundColor: Colors.white,
  textTheme: TextTheme(
      titleLarge: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w500, fontSize: 20),
      titleMedium: const TextStyle(
        color: Color.fromARGB(255, 32, 32, 32),
        fontSize: 16,
      ),
      bodyMedium: const TextStyle(
        color: Color.fromARGB(255, 18, 59, 54),
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
  ),
);

final ThemeData slateBlue = ThemeData(
    primaryColor: const Color(0xFF546E7A),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF607D8B),
      secondary: Color(0xFF455A64),
    ),
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: Color(0xFF000000), fontWeight: FontWeight.bold, fontSize: 24),
      titleMedium: TextStyle(color: Color(0xFF757575), fontSize: 18),
      bodyMedium: TextStyle(color: Color(0xFF546E7A), fontSize: 16),
      bodySmall: TextStyle(color: Color(0xFF9E9E9E), fontSize: 14),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFB0BEC5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF546E7A)),
      ),
      labelStyle: TextStyle(color: Color(0xFF9E9E9E)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            foregroundColor: const Color(0xFFFFFFFF),
            backgroundColor: const Color(0xFF546E7A),
            textStyle: const TextStyle(fontSize: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ))));

final ThemeData galacticNight = ThemeData(
  primaryColor: const Color(0xFF2C384A),
  colorScheme: const ColorScheme.light(
    secondary: Color(0xFF7AC7C4),
  ),
  scaffoldBackgroundColor: const Color(0xFFF6F7F8),
  textTheme: const TextTheme(
    titleLarge: TextStyle(color: Color(0xFF2C384A), fontWeight: FontWeight.w500, fontSize: 20),
    titleMedium: TextStyle(color: Color(0xFF2C384A), fontSize: 16),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(color: Color(0xFF2C384A)),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF2C384A)),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF2C384A),
      foregroundColor: const Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  ),
);
