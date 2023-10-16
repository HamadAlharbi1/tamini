import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tamini_app/provider/language_provider.dart';

class LanguageDropdown extends StatelessWidget {
  const LanguageDropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<LanguageProvider>();

    return DropdownButton<String>(
      value: languageProvider.currentLocale.languageCode,
      items: <String>['en', 'ar'].map((String value) {
        String displayText = (value == 'en') ? 'English' : 'العربية';
        return DropdownMenuItem<String>(
          value: value,
          child: Text(displayText),
        );
      }).toList(),
      onChanged: (newValue) {
        Locale newLocale;
        if (newValue == 'en') {
          newLocale = const Locale('en', 'US');
        } else if (newValue == 'ar') {
          newLocale = const Locale('ar', 'SA');
        } else {
          newLocale = const Locale('en', 'US'); // default to English if something goes wrong
        }
        languageProvider.changeLanguage(newLocale);
      },
    );
  }
}
