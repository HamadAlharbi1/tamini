import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BirthDatePicker extends StatefulWidget {
  BirthDatePicker({
    super.key,
    required this.initialDate,
    required this.onDateChanged,
  });

  DateTime initialDate;
  final Function(DateTime) onDateChanged;

  @override
  // ignore: library_private_types_in_public_api
  _BirthDatePickerState createState() => _BirthDatePickerState();
}

class _BirthDatePickerState extends State<BirthDatePicker> {
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 27, 120, 136),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != widget.initialDate) {
      setState(() {
        widget.initialDate = picked;
      });

      widget.onDateChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        child: const Icon(Icons.date_range),
        onTap: () => _selectDate(context),
      ),
    );
  }
}
