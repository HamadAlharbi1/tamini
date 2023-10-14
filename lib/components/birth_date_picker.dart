import 'package:flutter/material.dart';
import 'package:tamini_app/components/custom_button.dart';

class BirthDatePicker extends StatefulWidget {
  const BirthDatePicker({
    Key? key,
    required this.onDateChanged,
  }) : super(key: key);

  final Function(DateTime) onDateChanged;

  @override
  State<BirthDatePicker> createState() => _BirthDatePickerState();
}

class _BirthDatePickerState extends State<BirthDatePicker> {
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context), // Use the current theme
          child: child!,
        );
      },
    );

    if (picked != null) {
      widget.onDateChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Theme.of(context).primaryColor, // Using primary color from theme
        child: CustomButton(
          buttonText: '',
          isText: false,
          child: const Icon(Icons.date_range, color: Colors.white), // Assuming the icon color is white
          onPressed: () => _selectDate(context),
        ),
      ),
    );
  }
}
