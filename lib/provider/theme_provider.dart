import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamini_app/themes/tamini_themes.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _selectedTheme;
  String _selectedThemeName;

  ThemeProvider(this._selectedTheme, this._selectedThemeName) {
    loadTheme();
  }

  ThemeData get getTheme => _selectedTheme;
  String get getThemeName => _selectedThemeName;

  void changeTheme(ThemeData theme, String themeName) {
    _selectedTheme = theme;
    _selectedThemeName = themeName;
    saveTheme(themeName);
    notifyListeners();
  }

  saveTheme(String themeName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeName', themeName);
  }

  loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? themeName = prefs.getString('themeName');

    if (themeName != null) {
      switch (themeName) {
        case 'Slate Blue':
          _selectedTheme = slateBlue;
          break;
        case 'Emerald Dusk':
          _selectedTheme = emeraldDusk;
          break;
        case 'Galactic Night':
          _selectedTheme = galacticNight;
          break;
        case 'Midnight Blue':
          _selectedTheme = midnightBlue;
          break;
        case 'Deep Space':
          _selectedTheme = deepSpace;
          break;
        case 'Twilight Purple':
          _selectedTheme = twilightPurple;
          break;
        default:
          _selectedTheme = slateBlue;
      }
      _selectedThemeName = themeName;
    }
    notifyListeners();
  }
}
