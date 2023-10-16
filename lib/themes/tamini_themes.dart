import 'package:flutter/material.dart';

final ThemeData emeraldDusk = ThemeData(
  brightness: Brightness.light,
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
      textStyle: const TextStyle(fontSize: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
  ),
);

final ThemeData slateBlue = ThemeData(
  brightness: Brightness.light,
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
      textStyle: const TextStyle(fontSize: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  ),
);

final ThemeData galacticNight = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF2C384A),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF2C384A),
    secondary: Color(0xFF7AC7C4),
  ),
  scaffoldBackgroundColor: const Color(0xFFF6F7F8),
  textTheme: const TextTheme(
    titleLarge: TextStyle(color: Color(0xFF2C384A), fontWeight: FontWeight.w500, fontSize: 20),
    titleMedium: TextStyle(color: Color(0xFF2C384A), fontSize: 16),
    bodyMedium: TextStyle(color: Color(0xFF2C384A), fontSize: 14),
    bodySmall: TextStyle(color: Color(0xFF7AC7C4), fontSize: 12),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF2C384A)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF2C384A)),
    ),
    labelStyle: TextStyle(color: Color(0xFF2C384A)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF2C384A),
      foregroundColor: const Color(0xFFFFFFFF),
      textStyle: const TextStyle(fontSize: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  ),
);

final ThemeData midnightBlue = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF003366),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF0066CC),
    secondary: Color(0xFF3399FF),
  ),
  scaffoldBackgroundColor: const Color(0xFF000033),
  textTheme: const TextTheme(
    titleLarge: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w500, fontSize: 20),
    titleMedium: TextStyle(color: Color(0xFFCCCCCC), fontSize: 16),
    bodyMedium: TextStyle(color: Color(0xFF0066CC), fontSize: 14),
    bodySmall: TextStyle(color: Color(0xFF3399FF), fontSize: 12),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF3399FF)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF3399FF)),
    ),
    labelStyle: TextStyle(color: Color(0xFFCCCCCC)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF0066CC),
      foregroundColor: const Color(0xFFFFFFFF),
      textStyle: const TextStyle(fontSize: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  ),
);

final ThemeData deepSpace = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF000033),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF330099),
    secondary: Color(0xFF6600CC),
  ),
  scaffoldBackgroundColor: const Color(0xFF000000),
  textTheme: const TextTheme(
    titleLarge: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w500, fontSize: 20),
    titleMedium: TextStyle(color: Color(0xFFCCCCCC), fontSize: 16),
    bodyMedium: TextStyle(color: Color(0xFF330099), fontSize: 14),
    bodySmall: TextStyle(color: Color(0xFF6600CC), fontSize: 12),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF6600CC)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF6600CC)),
    ),
    labelStyle: TextStyle(color: Color(0xFFCCCCCC)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF330099),
      foregroundColor: const Color(0xFFFFFFFF),
      textStyle: const TextStyle(fontSize: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  ),
);

final ThemeData twilightPurple = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF330033),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF660066),
    secondary: Color(0xFFCC00CC),
  ),
  scaffoldBackgroundColor: const Color(0xFF000000),
  textTheme: const TextTheme(
    titleLarge: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w500, fontSize: 20),
    titleMedium: TextStyle(color: Color(0xFFCCCCCC), fontSize: 16),
    bodyMedium: TextStyle(color: Color(0xFF660066), fontSize: 14),
    bodySmall: TextStyle(color: Color(0xFFCC00CC), fontSize: 12),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFCC00CC)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFCC00CC)),
    ),
    labelStyle: TextStyle(color: Color(0xFFCCCCCC)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF660066),
      foregroundColor: const Color(0xFFFFFFFF),
      textStyle: const TextStyle(fontSize: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  ),
);
