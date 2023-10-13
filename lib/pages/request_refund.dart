import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/common/pic_image.dart';
import 'package:tamini_app/common/refund_service.dart';
import 'package:tamini_app/components/refunds/company_card.dart';
import 'package:tamini_app/components/refunds/company_model.dart';
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
  @override
  void initState() {
    super.initState();
    User? user = _auth.currentUser;
    uid = user?.uid;
    phoneNumber = user?.phoneNumber;
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request_Refund'.i18n()),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text('Select_Company'.i18n(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
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
          ElevatedButton(
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
            child: Text('send'.i18n()),
          ),
        ],
      ),
    );
  }
}
