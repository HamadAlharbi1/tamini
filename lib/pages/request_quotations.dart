import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/components/birth_date_picker.dart';
import 'package:tamini_app/components/custom_button.dart';
import 'package:tamini_app/components/custom_text_field.dart';
import 'package:tamini_app/components/notifications.dart';

class RequestQuotations extends StatefulWidget {
  const RequestQuotations({Key? key}) : super(key: key);

  @override
  State<RequestQuotations> createState() => _RequestQuotationsState();
}

class _RequestQuotationsState extends State<RequestQuotations> {
  String? uid;
  String? phoneNumber;

  @override
  void initState() {
    super.initState();
    User? user = _auth.currentUser;
    uid = user?.uid;
    phoneNumber = user?.phoneNumber;
    birthDateController.text = formatDate(initialDate);
  }

  DateTime initialDate = DateTime.now();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController nationalIdNumberController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController carSerialNumberController = TextEditingController();
  Future<void> showRequestAddedSnackbar() async {
    final snackBar = SnackBar(
      content: Text('request_added'.i18n()),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  requestQuotation() async {
    final DateTime requestDate = DateTime.now();
    try {
      DocumentSnapshot metadata = await FirebaseFirestore.instance.collection('metadata').doc('requestId').get();
      Map<String, dynamic>? data = metadata.data() as Map<String, dynamic>?;
      int currentRequestId;
      if (data != null && data.containsKey('currentRequestId')) {
        currentRequestId = data['currentRequestId'];
      } else {
        currentRequestId = 1000;
      }
      int newRequestId = currentRequestId + 1;

      await FirebaseFirestore.instance.collection('metadata').doc('requestId').set({
        'currentRequestId': newRequestId,
      });

      // Use the new requestId for the new request
      await FirebaseFirestore.instance.collection('quotations').doc(newRequestId.toString()).set({
        'nationalId': nationalIdNumberController.text,
        'birthDate': birthDateController.text,
        'carSerialNumber': carSerialNumberController.text,
        'userId': uid,
        'status': "under_review",
        'phoneNumber': phoneNumber,
        'insuranceAmount': 0.00,
        'requestId': newRequestId.toString(),
        'requestType': 'quotation',
        'requestDate': requestDate.toString(),
      });

      // Call the function to show the snackbar

      await showRequestAddedSnackbar();
    } catch (e) {
      // ignore: use_build_context_synchronously
      Notifications.displayError(context, e);
    }
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
                controller: nationalIdNumberController,
                labelText: 'national_id_number'.i18n(),
                hintText: 'enter_national_id_number'.i18n(),
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
                controller: carSerialNumberController,
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
