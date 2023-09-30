import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:tamini_app/app.dart';
import 'package:tamini_app/components/locale_language.dart';
import 'package:tamini_app/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FlutterLocalization localization = FlutterLocalization.instance;

  // Load .env file and Firebase configuration
  await dotenv.load();
  var config = await Firebase.initializeApp(options: DefaultFirebaseOptions().currentPlatform);
  if (kDebugMode) {
    print(config);
  }

  // Initialize FlutterLocalization with supported locales
  localization.init(
    mapLocales: [
      const MapLocale(
        'ar',
        AppLocale.ar,
        countryCode: 'SA',
        fontFamily: 'Font AR',
      ),
      const MapLocale(
        'en',
        AppLocale.en,
        countryCode: 'US',
        fontFamily: 'Font EN',
      ),
      // Add other locales as needed
    ],
    initLanguageCode: 'ar', // Set the initial default language
  );

  runApp(MaterialApp(
    supportedLocales: localization.supportedLocales,
    locale: localization.currentLocale,
    localizationsDelegates: localization.localizationsDelegates,
    debugShowCheckedModeBanner: false,
    home: const MyApp(),
  ));
}
