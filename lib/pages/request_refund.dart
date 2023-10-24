import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/common/pic_image.dart';
import 'package:tamini_app/common/refund_service.dart';
import 'package:tamini_app/components/refunds/company_card.dart';
import 'package:tamini_app/components/refunds/company_model.dart';
import 'package:tamini_app/components/refunds/refund_percent_model.dart';
import 'package:tamini_app/components/refunds/show_file.dart';

class RequestRefund extends StatefulWidget {
  const RequestRefund({Key? key}) : super(key: key);

  @override
  State<RequestRefund> createState() => _RequestRefundState();
}

class _RequestRefundState extends State<RequestRefund> {
  String? uid;
  String? phoneNumber;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UploadImage upload = UploadImage();
  final RefundService refundService = RefundService();
  String message = 'Refund_request_submitted_successfully'.i18n();
  String companyName = '';
  String idCard = '';
  String ibanBankAccount = '';
  String vehicleRegistrationCard = '';
  String insuranceDocument = '';
  int selectedIndex = -1;
  @override
  void initState() {
    super.initState();
    User? user = _auth.currentUser;
    uid = user?.uid;
    phoneNumber = user?.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request_Refund'.i18n()),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const DescriptionPanel(),
          const SizedBox(height: 10),
          const DurationVsPercentPanel(),
          Text('Select_Company'.i18n(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: companies.length,
              itemBuilder: (context, index) {
                return CompanyCard(
                  company: companies[index],
                  isSelected: selectedIndex == index,
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                      companyName = companies[index].description;
                    });
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Text('Upload_Documents'.i18n(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              idCard = await upload.selectAndUploadImage(context, "ID_card", uid!);
              setState(() {});
            },
            child: Text('Upload_ID_card'.i18n()),
          ),
          idCard.isNotEmpty
              ? ShowFile(
                  file: idCard,
                  description: "ID_card".i18n(),
                )
              : Container(),
          ElevatedButton(
            onPressed: () async {
              vehicleRegistrationCard = await upload.selectAndUploadImage(context, "Vehicle_Registration_Card", uid!);
              setState(() {});
            },
            child: Text('Upload_Vehicle_Registration_Card'.i18n()),
          ),
          vehicleRegistrationCard.isNotEmpty
              ? ShowFile(
                  file: vehicleRegistrationCard,
                  description: "Vehicle_Registration_Card".i18n(),
                )
              : Container(),
          ElevatedButton(
            onPressed: () async {
              ibanBankAccount = await upload.selectAndUploadImage(context, "IBAN_bank_account", uid!);
              setState(() {});
            },
            child: Text('Upload_IBAN_Bank_Account'.i18n()),
          ),
          ibanBankAccount.isNotEmpty
              ? ShowFile(
                  file: ibanBankAccount,
                  description: "IBAN_Bank_Account".i18n(),
                )
              : Container(),
          ElevatedButton(
            onPressed: () async {
              insuranceDocument = await upload.selectAndUploadImage(context, "Insurance_Document", uid!);
              setState(() {});
            },
            child: Text('Upload_Insurance_Document'.i18n()),
          ),
          insuranceDocument.isNotEmpty
              ? ShowFile(
                  file: insuranceDocument,
                  description: "Insurance_Document".i18n(),
                )
              : Container(),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 110, 21, 14)),
            ),
            onPressed: () {
              if (idCard.isNotEmpty &&
                  vehicleRegistrationCard.isNotEmpty &&
                  ibanBankAccount.isNotEmpty &&
                  insuranceDocument.isNotEmpty) {
                refundService.requestRefund(
                  context,
                  idCard,
                  ibanBankAccount,
                  vehicleRegistrationCard,
                  insuranceDocument,
                  uid!,
                  phoneNumber!,
                  message,
                  companyName,
                );
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('please_upload_all_documents'.i18n())));
              }
            },
            child: Text('request_for_refund'.i18n()),
          ),
        ],
      ),
    );
  }
}

class DescriptionPanel extends StatefulWidget {
  const DescriptionPanel({Key? key}) : super(key: key);

  @override
  State<DescriptionPanel> createState() => _DescriptionPanelState();
}

class _DescriptionPanelState extends State<DescriptionPanel> {
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
                'When_can_you_get_a_refund_on_your_car_insurance?'.i18n(),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          },
          body: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'refund_description'.i18n(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
                DescriptionAndDoc(
                  descriptionKey: 'selling_the_vehicle'.i18n(),
                  docKey: 'selling_the_vehicle_doc'.i18n(),
                ),
                DescriptionAndDoc(
                  descriptionKey: 'got_new_insurance'.i18n(),
                  docKey: 'got_new_insurance_doc'.i18n(),
                ),
                DescriptionAndDoc(
                  descriptionKey: 'selling_process_canceled'.i18n(),
                  docKey: 'selling_process_canceled_doc'.i18n(),
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

class DescriptionAndDoc extends StatelessWidget {
  final String descriptionKey;
  final String docKey;

  const DescriptionAndDoc({
    Key? key,
    required this.descriptionKey,
    required this.docKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            descriptionKey,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            docKey,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class DurationVsPercentPanel extends StatefulWidget {
  const DurationVsPercentPanel({Key? key}) : super(key: key);

  @override
  State<DurationVsPercentPanel> createState() => _DurationVsPercentPanelState();
}

class _DurationVsPercentPanelState extends State<DurationVsPercentPanel> {
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
                'How_much_is_the_refund_amount?'.i18n(),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          },
          body: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "refund_amount_calculation_mechanism".i18n(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 400,
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: refundPercentList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${refundPercentList[index].days} ',
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    'day'.i18n(),
                                    style: Theme.of(context).textTheme.bodySmall,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              Text(
                                '%${refundPercentList[index].refundPercent}',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'out_of_insurance_amount'.i18n(),
                                style: Theme.of(context).textTheme.bodySmall,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          isExpanded: _isExpanded,
        ),
      ],
    );
  }
}
