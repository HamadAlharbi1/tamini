import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

Future<void> showSnackbar(context, String message) async {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Future<void> displayError(BuildContext context, Object e) {
  Flushbar(
    message: 'Error: $e',
    flushbarPosition: FlushbarPosition.TOP, // this line makes it appear at the top
    duration: const Duration(seconds: 3),
  ).show(context);

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

launchWhatsAppString() async {
  DocumentSnapshot doc = await FirebaseFirestore.instance.collection('metadata').doc('whatsappService').get();
  String contactNumber = doc['contactNumber'];
  String? phone = contactNumber;
  WhatsAppUnilink link = WhatsAppUnilink(
    phoneNumber: phone,
    text: "",
  );
  // Convert the WhatsAppUnilink instance to a string.
  // Use either Dart's string interpolation or the toString() method.
  // The "launchUrlString" method is part of "url_launcher_string".
  await launchUrlString('$link');
}
