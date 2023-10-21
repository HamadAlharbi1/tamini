import 'package:flutter/material.dart';

final ThemeData slateBlueLight = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF3E5062), // Dark Slate Blue
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF5A7184), // Light Slate Blue
    secondary: Color(0xFF2C3E50), // Dark Blue
  ),
  scaffoldBackgroundColor: const Color.fromARGB(255, 249, 251, 252), // Clouds
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color(0xFF2C3E50), fontWeight: FontWeight.bold, fontSize: 24), // Dark Blue
    headlineSmall: TextStyle(color: Color(0xFF5A7184), fontSize: 20), // Light Slate Blue
    bodyLarge: TextStyle(color: Color(0xFF3E5062), fontSize: 16), // Dark Slate Blue
    bodyMedium: TextStyle(color: Color(0xFF7F8C8D), fontSize: 14), // Asbestos
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFBDC3C7)), // Silver
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF3E5062)), // Dark Slate Blue
    ),
    labelStyle: TextStyle(color: Color(0xFF7F8C8D)), // Asbestos
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: const Color(0xFFECF0F1), // Clouds
      backgroundColor: const Color(0xFF3E5062), // Dark Slate Blue
      textStyle: const TextStyle(fontSize: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  ),
  dividerTheme: const DividerThemeData(
    color: Color(0xFFBDC3C7), // Silver

    thickness: 2,
  ),
);

final ThemeData slateBlueDark = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color.fromARGB(255, 57, 81, 105), // Dark Blue
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF3E5062), // Dark Slate Blue
    secondary: Color(0xFF5A7184), // Light Slate Blue
    onPrimary: Color(0xFFECF0F1), // Clouds
    onSecondary: Color.fromARGB(255, 38, 41, 44), // Silver
  ),
  scaffoldBackgroundColor: const Color.fromARGB(255, 21, 32, 41), // Dark Blue
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Colors.white60, fontWeight: FontWeight.bold, fontSize: 24),
    headlineSmall: TextStyle(color: Color.fromARGB(179, 219, 219, 219), fontSize: 20),
    bodyLarge: TextStyle(color: Colors.white54, fontSize: 16),
    bodyMedium: TextStyle(color: Colors.white60, fontSize: 14),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF7F8C8D)), // Asbestos
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFECF0F1)), // Clouds
    ),
    labelStyle: TextStyle(color: Colors.white60),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: const Color.fromARGB(255, 236, 240, 241), // Clouds
      backgroundColor: const Color.fromARGB(212, 65, 74, 83), // Dark Slate Blue
      textStyle: const TextStyle(fontSize: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  ),
  dividerTheme: const DividerThemeData(
    color: Color(0xFF7F8C8D), // Asbestos

    thickness: 2,
  ),
);
