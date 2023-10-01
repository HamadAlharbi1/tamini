import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/pages/registration_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set the directories where the translation JSON files are located
    LocalJsonLocalization.delegate.directories = ['lib/i18n'];

    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        LocalJsonLocalization.delegate,
      ],
      locale: const Locale('ar', 'SA'), // Set the default locale to Arabic
      supportedLocales: const [
        Locale('ar', 'SA'), // Arabic
        Locale('en', 'US'), // English
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        // If the device's language is Arabic and Arabic is supported by the app
        if (deviceLocale?.languageCode == 'ar' && supportedLocales.contains(const Locale('ar', 'SA'))) {
          return const Locale('ar', 'SA'); // Use Arabic
        } else {
          return const Locale('en', 'US'); // Use English otherwise
        }
      },
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: const RegistrationPage(),
    );
  }
}

final ThemeData themeData = ThemeData(
  primarySwatch: createMaterialColor(const Color.fromARGB(255, 36, 87, 102)), // Replace with your color
);
MaterialColor createMaterialColor(Color color) {
  List<int> strengths = <int>[50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int strength in strengths) {
    final double blend = 1.0 - (strength / 900);
    swatch[strength] = Color.fromRGBO(
      r,
      g,
      b,
      blend,
    );
  }
  return MaterialColor(color.value, swatch);
}
