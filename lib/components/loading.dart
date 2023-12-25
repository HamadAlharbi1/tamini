import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:tamini_app/provider/language_provider.dart';

class Loading extends StatelessWidget {
  final String filename;
  const Loading({super.key, required this.filename});

  @override
  Widget build(BuildContext context) {
    Provider.of<LanguageProvider>(context); // this is added since the language could changes on profile_page
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [const CircularProgressIndicator(), const SizedBox(width: 16), Text('${'Loading'.i18n()}$filename')],
    );
  }
}
