import 'package:flutter/material.dart';

Future<void> showSnackbar(context, String message) async {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Future<void> displayError(context, Object e) {
  final snackBar = SnackBar(
    content: Text('Error: $e'),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  return Future.value();
}

String fixNumber(String number) {
  if (number.startsWith("+966")) {
    return number.replaceFirst("+966", "0");
  }
  return number;
}

String maskPhoneNumber(context, String number) {
  final isEnglish = Localizations.localeOf(context).languageCode == 'en';
  String countryCode = number.substring(1, 5);
  countryCode == "9665" ? countryCode = "05" : countryCode = countryCode;
  String lastDigits = number.substring(number.length - 3);
  String maskedDigits = '*****';
  // The arrangement of the values is determined by the language. In English, the number starts from left to right, while in Arabic, it starts from right to left.
  String result = isEnglish ? countryCode + maskedDigits + lastDigits : lastDigits + maskedDigits + countryCode;
  // Combine all parts
  return result;
}
