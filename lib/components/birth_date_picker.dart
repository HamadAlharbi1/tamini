import 'package:flutter/material.dart';
import 'package:tamini_app/components/custom_button.dart';

class BirthDatePicker extends StatefulWidget {
  const BirthDatePicker({
    super.key,
    required this.onDateChanged,
  });

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
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 27, 120, 136),
            ),
          ),
          child: child!,
        );
      },
    );

    /// if the user selects cancel picked value will be null
    if (picked != null) {
      debugPrint(picked.toString());
      widget.onDateChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomButton(
        buttonText: '',
        isText: false,
        child: const Icon(Icons.date_range),
        onPressed: () => _selectDate(context),
      ),
    );
  }
}
