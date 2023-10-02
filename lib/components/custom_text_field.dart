import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  const CustomTextField({
    super.key,
    this.prefixIcon,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.keyboardType,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      autofocus: true,
      obscureText: false,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [widget.prefixIcon!],
                ),
              )
            : null,
        label: Text(widget.labelText),
        hintText: widget.hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(246, 28, 29, 29),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(246, 0, 95, 150),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(246, 0, 95, 150),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(246, 150, 0, 0),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
      ),
      keyboardType: widget.keyboardType,
    );
  }
}
