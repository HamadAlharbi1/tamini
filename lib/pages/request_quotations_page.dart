import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/components/birth_date_picker.dart';
import 'package:tamini_app/components/custom_button.dart';
import 'package:tamini_app/components/custom_text_field.dart';
import 'package:uuid/uuid.dart';

class RequestQuotations extends StatefulWidget {
  const RequestQuotations({Key? key}) : super(key: key);

  @override
  State<RequestQuotations> createState() => _RequestQuotationsState();
}

class _RequestQuotationsState extends State<RequestQuotations> {
  dynamic uid;
  dynamic phoneNumber;

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

  Future<void> errorShow(var e) async {
    final snackBar = SnackBar(
      content: Text('error:$e'.i18n()),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  requestQuotation() async {
    final requestId = const Uuid().v4();
    final DateTime requestDate = DateTime.now();
    try {
      await FirebaseFirestore.instance.collection('RequestQuotations').doc(requestId).set({
        'nationalId': nationalIdNumberController.text,
        'birthDate': birthDateController.text,
        'carSerialNumber': carSerialNumberController.text,
        'userId': uid,
        'status': "under_review",
        'phoneNumber': phoneNumber,
        'insuranceAmount': 1.5,
        'requestId': requestId,
        'requestType': "Request_Quotations",
        'requestDate': requestDate.toString(),
      });

      // Call the function to show the snackbar
      await showRequestAddedSnackbar();
    } catch (e) {
      await errorShow(e);
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
