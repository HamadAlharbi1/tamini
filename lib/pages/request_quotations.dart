import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/common/enum.dart';
import 'package:tamini_app/common/quotation_service.dart';
import 'package:tamini_app/components/birth_date_picker.dart';
import 'package:tamini_app/components/custom_text_field.dart';
import 'package:tamini_app/components/quotations/quotation_description_panel.dart';
import 'package:tamini_app/components/quotations/quotation_service_cost.dart';
import 'package:tamini_app/components/start_insurance_date_picker.dart';

class RequestQuotations extends StatefulWidget {
  const RequestQuotations({
    super.key,
  });

  @override
  State<RequestQuotations> createState() => _RequestQuotationsState();
}

class _RequestQuotationsState extends State<RequestQuotations> with SingleTickerProviderStateMixin {
  String? uid;
  String? phoneNumber;
  String quotationType = QuotationType.newCarQuotation.name;
  late TabController _tabController;
  @override
  void initState() {
    super.initState();

    User? user = _auth.currentUser;
    uid = user?.uid;
    phoneNumber = user?.phoneNumber;
    birthDateController.text = formatDate(initialDate);
    sellerBirthDateController.text = formatDate(initialDate);
    startInsuranceDate.text = formatDate(initialDate);
    _tabController = TabController(length: 2, vsync: this);
    // Add listener to the TabController
    _tabController.addListener(_handleTabSelection);
    // Set initial value for quotationType
    quotationType = 'NewCarQuotation'; // Assuming 'NewCarQuotation' is the first tab
  }

  void _handleTabSelection() {
    // Update the quotationType based on the tab selected
    setState(() {
      if (_tabController.index == 0) {
        quotationType = QuotationType.newCarQuotation.name;
      } else if (_tabController.index == 1) {
        quotationType = QuotationType.transferQuotation.name;
      }
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  DateTime initialDate = DateTime.now();
  DateTime initialDateForTest = DateTime.now();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController nationalIdNumberController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController startInsuranceDate = TextEditingController();
  TextEditingController sellerNationalIdNumberController = TextEditingController();
  TextEditingController sellerBirthDateController = TextEditingController();
  TextEditingController carSerialNumberController = TextEditingController();
  QuotationService quotationService = QuotationService();

  String formatDate(DateTime date) {
    return "${date.year}/${date.month}/${date.day}"; // Format date as you need
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request_Quotations'.i18n()),
      ),
      body: Center(
          child: ListView(children: [
        const QuotationDescriptionPanel(),
        const QuotationServiceCost(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                  child: Text(
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                'NewCarQuotation'.i18n(),
              )),
              Tab(
                child: Text(
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                  'TransferQuotation'.i18n(),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height > 667
              ? MediaQuery.of(context).size.height - MediaQuery.of(context).size.height / 1.36
              : MediaQuery.of(context).size.height - MediaQuery.of(context).size.height / 1.45,
          child: TabBarView(
            controller: _tabController,
            children: [
              Column(
                // NewCarQuotation
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
                ],
              ),
              Column(
                // TransferQuotation
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: CustomTextField(
                            controller: sellerNationalIdNumberController,
                            labelText: 'seller_Governemnt_ID/Iqama_ID'.i18n(),
                            hintText: 'seller_enter_Governemnt_ID/Iqama_ID'.i18n(),
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: CustomTextField(
                            controller: nationalIdNumberController,
                            labelText: 'buyer_Governemnt_ID/Iqama_ID'.i18n(),
                            hintText: 'buyer_enter_Governemnt_ID/Iqama_ID'.i18n(),
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: CustomTextField(
                            prefixIcon: BirthDatePicker(
                              onDateChanged: (newDate) {
                                setState(() {
                                  initialDate = newDate;
                                  sellerBirthDateController.text = formatDate(initialDate);
                                });
                              },
                            ),
                            controller: sellerBirthDateController,
                            labelText: 'seller_birth_date'.i18n(),
                            hintText: 'seller_enter_birth_date'.i18n(),
                            keyboardType: TextInputType.datetime,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
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
                            labelText: 'buyer_birth_date'.i18n(),
                            hintText: 'buyer_enter_birth_date'.i18n(),
                            keyboardType: TextInputType.datetime,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomTextField(
            prefixIcon: StartInsuranceDatePicker(
              onDateChanged: (newDate) {
                setState(() {
                  initialDate = newDate;
                  startInsuranceDate.text = formatDate(initialDate);
                });
              },
            ),
            controller: startInsuranceDate,
            labelText: 'startInsuranceDate'.i18n(),
            hintText: 'enter_startInsuranceDate'.i18n(),
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
        Column(
          children: [
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(221, 0, 167, 117)),
                ),
                onPressed: () {
                  if (birthDateController.text != formatDate(initialDateForTest) &&
                      nationalIdNumberController.text.isNotEmpty &&
                      startInsuranceDate.text.isNotEmpty &&
                      birthDateController.text.isNotEmpty &&
                      carSerialNumberController.text.isNotEmpty) {
                    if (quotationType == QuotationType.transferQuotation.name) {
                      if (sellerNationalIdNumberController.text.isNotEmpty &&
                          sellerBirthDateController.text != formatDate(initialDateForTest) &&
                          sellerBirthDateController.text.isNotEmpty) {
                        quotationService.requestQuotation(
                            context,
                            quotationType,
                            nationalIdNumberController.text,
                            startInsuranceDate.text,
                            birthDateController.text,
                            sellerNationalIdNumberController.text,
                            sellerBirthDateController.text,
                            carSerialNumberController.text,
                            uid!,
                            phoneNumber!,
                            'request_added'.i18n());
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please_ensure_all_fields_are_filled_out_carefully'.i18n())));
                      }
                    } else {
                      quotationService.requestQuotation(
                          context,
                          quotationType,
                          nationalIdNumberController.text,
                          startInsuranceDate.text,
                          birthDateController.text,
                          sellerNationalIdNumberController.text,
                          sellerBirthDateController.text,
                          carSerialNumberController.text,
                          uid!,
                          phoneNumber!,
                          'request_added'.i18n());
                    }
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
      ])),
    );
  }
}
