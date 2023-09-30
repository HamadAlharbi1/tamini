import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:tamini_app/components/locale_language.dart';
import 'package:tamini_app/pages/registration_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalization localization = FlutterLocalization.instance;

  @override
  void initState() {
    localization.init(
      mapLocales: [
        const MapLocale('ar', AppLocale.ar),
        const MapLocale('en', AppLocale.en),
      ],
      initLanguageCode: 'ar',
    );
    localization.onTranslatedLanguage = _onTranslatedLanguage;
    super.initState();
  }

// the setState function here is a must to add
  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: localization.supportedLocales,
      localizationsDelegates: localization.localizationsDelegates,
      debugShowCheckedModeBanner: false,
      home: const RegistrationPage(),
    );
  }
}
