import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamini_app/themes/tamini_themes.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _selectedTheme;
  bool _isDarkTheme;

  ThemeProvider(this._selectedTheme) : _isDarkTheme = _selectedTheme == slateBlueDark {
    _loadTheme();
  }

  ThemeData getTheme() => _selectedTheme;
  bool get isDarkTheme => _isDarkTheme;

  setTheme(ThemeData theme) async {
    _selectedTheme = theme;
    _isDarkTheme = theme == slateBlueDark;
    _saveTheme();
    notifyListeners();
  }

  _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? themeName = prefs.getString('theme');
    if (themeName == 'dark') {
      _selectedTheme = slateBlueDark;
      _isDarkTheme = true;
    } else {
      _selectedTheme = slateBlueLight;
      _isDarkTheme = false;
    }
    notifyListeners();
  }

  _saveTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', _isDarkTheme ? 'dark' : 'light');
  }
}
