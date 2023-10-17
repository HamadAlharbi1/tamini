import 'package:flutter/material.dart';

class HomePageActionsContainer extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const HomePageActionsContainer({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16),
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
