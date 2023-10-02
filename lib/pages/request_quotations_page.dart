import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/components/birth_date_picker.dart';
import 'package:tamini_app/components/custom_button.dart';
import 'package:tamini_app/components/custom_text_field.dart';

class RequestQuotations extends StatefulWidget {
  const RequestQuotations({Key? key}) : super(key: key);

  @override
  State<RequestQuotations> createState() => _RequestQuotationsState();
}

class _RequestQuotationsState extends State<RequestQuotations> {
  DateTime initialDate = DateTime.now();
  TextEditingController idNumberController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController vehicleSerialNumberController = TextEditingController();
  requestQuotation() {
    //enter request quotation logic
  }
  @override
  void initState() {
    super.initState();
    birthDateController.text = formatDate(initialDate); // Set initial value
  }

  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}"; // Format date as you need
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request_Quotations'.i18n()), // Use the i18n() method to get the translated string
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomTextField(
                controller: idNumberController,
                labelText: 'id_number'.i18n(),
                hintText: 'enter_id_number'.i18n(),
                keyboardType: TextInputType.phone,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomTextField(
                prefixIcon: BirthDatePicker(
                  initialDate: initialDate,
                  onDateChanged: (newDate) {
                    setState(() {
                      initialDate = newDate;
                      birthDateController.text = formatDate(initialDate);
                    });
                  },
                ),
                controller: birthDateController,
                labelText: 'birth_date'.i18n(),
                hintText: 'enter_birth_date'.i18n(),
                keyboardType: TextInputType.datetime,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomTextField(
                controller: vehicleSerialNumberController,
                labelText: 'vehicle_serial_number'.i18n(),
                hintText: 'enter_vehicle_serial_number'.i18n(),
                keyboardType: TextInputType.phone,
              ),
            ),
            CustomButton(
              onPressed: () {
                requestQuotation();
              },
              buttonText: 'send'.i18n(),
            ),
          ],
        ),
      ),
    );
  }
}
