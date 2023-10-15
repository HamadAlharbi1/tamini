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
