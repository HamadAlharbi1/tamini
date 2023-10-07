import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final bool isText;
  final Widget? child;
  final double vertical, horizontal, borderRadius;
  const CustomButton({
    super.key,
    this.isText = true,
    this.child,
    this.vertical = 12.0,
    this.horizontal = 0,
    this.borderRadius = 12,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
        child: isText == true
            ? Text(
                buttonText,
              )
            : child,
      ),
    );
  }
}
