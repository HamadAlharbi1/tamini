import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:tamini_app/provider/language_provider.dart';

class LanguageChanger extends StatelessWidget {
  const LanguageChanger({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<LanguageProvider>();
    return IconButton(
      icon: const Icon(Icons.language),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Select_Language'.i18n()),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <String>['en', 'ar'].map((String value) {
                  String displayText = (value == 'en') ? 'English' : 'العربية';
                  return RadioListTile<String>(
                    title: Text(displayText),
                    value: value,
                    groupValue: languageProvider.currentLocale.languageCode,
                    onChanged: (newValue) {
                      Locale newLocale;
                      if (newValue == 'ar') {
                        newLocale = const Locale('ar', 'SA');
                      } else {
                        newLocale = const Locale('en', 'US'); // default to English if something goes wrong
                      }
                      languageProvider.changeLanguage(newLocale);

                      Navigator.of(context).pop(); // Close the dialog
                    },
                  );
                }).toList(),
              ),
            );
          },
        );
      },
    );
  }
}
