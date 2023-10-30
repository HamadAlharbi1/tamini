import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tamini_app/provider/theme_provider.dart';
import 'package:tamini_app/themes/tamini_themes.dart';

class ThemeChanger extends StatelessWidget {
  const ThemeChanger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Switch(
          value: themeProvider.isDarkTheme,
          onChanged: (value) {
            themeProvider.setTheme(value ? slateBlueDark : slateBlueLight);
          },
        ),
        Positioned(
          left: isEnglish
              ? themeProvider.isDarkTheme
                  ? 3
                  : 30
              : themeProvider.isDarkTheme
                  ? 30
                  : 3,
          child: Transform.scale(
            scale: 0.5,
            child: Icon(
              themeProvider.isDarkTheme ? Icons.wb_sunny : Icons.nightlight_round,
              color: themeProvider.isDarkTheme ? Colors.white : const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
      ],
    );
  }
}
