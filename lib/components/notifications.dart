import 'package:flutter/material.dart';

class Notifications {
  static void displayError(context, Object e) {
    final snackBar = SnackBar(
      content: Text('Error: $e'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
