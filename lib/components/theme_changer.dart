import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:tamini_app/provider/theme_provider.dart';
import 'package:tamini_app/themes/tamini_themes.dart';

class ThemeChanger extends StatefulWidget {
  const ThemeChanger({Key? key}) : super(key: key);

  @override
  State<ThemeChanger> createState() => _ThemeChangerState();
}

class _ThemeChangerState extends State<ThemeChanger> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return PopupMenuButton<String>(
      icon: const Icon(Icons.color_lens),
      onSelected: (String themeName) {
        switch (themeName) {
          case 'Slate Blue':
            themeProvider.changeTheme(slateBlue, 'Slate Blue');
            break;
          case 'Emerald Dusk':
            themeProvider.changeTheme(emeraldDusk, 'Emerald Dusk');
            break;
          case 'Galactic Night':
            themeProvider.changeTheme(galacticNight, 'Galactic Night');
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem(
          value: 'Slate Blue',
          child: Text('Slate Blue'.i18n()),
        ),
        PopupMenuItem(
          value: 'Emerald Dusk',
          child: Text('Emerald Dusk'.i18n()),
        ),
        PopupMenuItem(
          value: 'Galactic Night',
          child: Text('Galactic Night'.i18n()),
        ),
      ],
    );
  }
}
