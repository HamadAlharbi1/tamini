import 'package:flutter/material.dart';

class HomePageActionsContainer extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData icon;

  const HomePageActionsContainer({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color.fromARGB(255, 76, 59, 153),
        backgroundColor: const Color.fromARGB(255, 11, 255, 214),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 4,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onPressed: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20,
            color: const Color.fromARGB(255, 76, 59, 153),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: Color.fromARGB(255, 76, 59, 153),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
