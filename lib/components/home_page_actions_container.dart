import 'package:flutter/material.dart';

class HomePageActionsContainer extends StatelessWidget {
  final String text;
  final VoidCallback onPressed; // Callback function for onPressed event

  const HomePageActionsContainer({
    Key? key,
    required this.text,
    required this.onPressed, // Pass the callback function as a parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed, // Attach the callback to the onTap event
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 180, 180, 180),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
