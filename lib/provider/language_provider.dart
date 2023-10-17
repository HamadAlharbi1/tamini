import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  Locale _currentLocale = const Locale('ar', 'SA');

  LanguageProvider() {
    loadLocale();
  }

  Locale get currentLocale => _currentLocale;

  void changeLanguage(Locale locale) async {
    if (_currentLocale != locale) {
      _currentLocale = locale;
      await _saveLocale(locale.languageCode, locale.countryCode!);
      notifyListeners();
    }
  }

  _saveLocale(String languageCode, String countryCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', languageCode);
    await prefs.setString('countryCode', countryCode);
  }

  loadLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('languageCode');
    String? countryCode = prefs.getString('countryCode');

    if (languageCode != null) {
      _currentLocale = Locale(languageCode, countryCode ?? '');
    }
    notifyListeners();
  }
}
