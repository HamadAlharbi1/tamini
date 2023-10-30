import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/common/quotation_service.dart';
import 'package:tamini_app/components/birth_date_picker.dart';
import 'package:tamini_app/components/constants.dart';
import 'package:tamini_app/components/custom_text_field.dart';

class RequestQuotations extends StatefulWidget {
  const RequestQuotations({
    super.key,
  });

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
  QuotationService quotationService = QuotationService();

  String formatDate(DateTime date) {
    return "${date.year}/${date.month}/${date.day}"; // Format date as you need
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request_Quotations'.i18n()), // Use the i18n() method to get the translated string
      ),
      body: Center(
        child: ListView(
          children: [
            const QuotationDescriptionPanel(),
            const QuotationServiceCost(),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomTextField(
                    controller: nationalIdNumberController,
                    labelText: 'Governemnt_ID/Iqama_ID'.i18n(),
                    hintText: 'enter_Governemnt_ID/Iqama_ID'.i18n(),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomTextField(
                    prefixIcon: BirthDatePicker(
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
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 110, 21, 14)),
                    ),
                    onPressed: () {
                      if (birthDateController.text != formatDate(initialDate) &&
                          nationalIdNumberController.text.isNotEmpty &&
                          birthDateController.text.isNotEmpty &&
                          carSerialNumberController.text.isNotEmpty) {
                        quotationService.requestQuotation(
                            context,
                            nationalIdNumberController.text,
                            birthDateController.text,
                            carSerialNumberController.text,
                            uid!,
                            phoneNumber!,
                            'request_added'.i18n());
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please_ensure_all_fields_are_filled_out_carefully'.i18n())));
                      }
                    },
                    child: Text(
                      'request_for_quotation'.i18n(),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class QuotationDescriptionPanel extends StatefulWidget {
  const QuotationDescriptionPanel({Key? key}) : super(key: key);

  @override
  State<QuotationDescriptionPanel> createState() => _QuotationDescriptionPanelState();
}

class _QuotationDescriptionPanelState extends State<QuotationDescriptionPanel> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      children: [
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(
                'why_should_i_ask_for_quotation?'.i18n(),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          },
          body: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'request_quotation_description'.i18n(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          isExpanded: _isExpanded,
        ),
      ],
    );
  }
}

class QuotationServiceCost extends StatefulWidget {
  const QuotationServiceCost({Key? key}) : super(key: key);

  @override
  State<QuotationServiceCost> createState() => _QuotationServiceCostState();
}

class _QuotationServiceCostState extends State<QuotationServiceCost> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      children: [
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(
                'Cost_of_quotation_service?'.i18n(),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          },
          body: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${Constants.quotationCost} ${"S.R".i18n()}",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          isExpanded: _isExpanded,
        ),
      ],
    );
  }
}
