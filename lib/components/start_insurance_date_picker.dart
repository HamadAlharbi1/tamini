import 'package:flutter/material.dart';

class StartInsuranceDatePicker extends StatefulWidget {
  const StartInsuranceDatePicker({
    Key? key,
    required this.onDateChanged,
  }) : super(key: key);

  final Function(DateTime) onDateChanged;

  @override
  State<StartInsuranceDatePicker> createState() => _StartInsuranceDatePickerState();
}

class _StartInsuranceDatePickerState extends State<StartInsuranceDatePicker> {
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
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
        // Using primary color from theme
        decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(6)),
        child: InkWell(
          child: const Padding(
            padding: EdgeInsets.all(5),
            child: Icon(Icons.date_range, color: Colors.white),
          ), // Assuming the icon color is white
          onTap: () => _selectDate(context),
        ),
      ),
    );
  }
}
