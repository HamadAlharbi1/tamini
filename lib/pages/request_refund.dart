import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/common/pic_image.dart';
import 'package:tamini_app/common/refund_service.dart';
import 'package:tamini_app/common/util.dart';
import 'package:tamini_app/components/loading.dart';
import 'package:tamini_app/components/refunds/company_card.dart';
import 'package:tamini_app/components/refunds/company_model.dart';
import 'package:tamini_app/components/refunds/duration_vs_percent_panel.dart';
import 'package:tamini_app/components/refunds/refund_description_panel.dart';
import 'package:tamini_app/components/refunds/refund_service_cost.dart';
import 'package:tamini_app/components/refunds/show_file.dart';

class RequestRefund extends StatefulWidget {
  const RequestRefund({Key? key}) : super(key: key);

  @override
  State<RequestRefund> createState() => _RequestRefundState();
}

class _RequestRefundState extends State<RequestRefund> {
  String? uid;
  bool uploadingIDcard = false;
  bool uploadingRegistrationCard = false;
  bool uploadingIBAN = false;
  bool uploadingInsuranceDocument = false;
  String? phoneNumber;
  bool isFileChanged = false;
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
          const RefundDescriptionPanel(), // refund service description
          const SizedBox(height: 10),

          /// the [ DurationVsPercentPanel ] widget shows Calculating a refund amount based on the percentage of total duration elapsed.
          /// For example, if the total duration is 1 month the refund could be 75% of the total amount.
          const DurationVsPercentPanel(),
          const SizedBox(height: 10),
          const RefundServiceCost(),
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

          idCard.isNotEmpty
              ? ShowFile(
                  onPressedCallback: () async {
                    idCard = await upload.selectAndUploadImage(context, "ID_card", uid!, (uploading) {
                      setState(() {
                        uploadingIDcard = uploading;
                      });
                    });
                    setState(() {});
                  },
                  file: idCard,
                  fileName: "ID_card".i18n(),
                )
              : uploadingIDcard
                  ? Loading(
                      filename: 'Upload_ID_card'.i18n(),
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        idCard = await upload.selectAndUploadImage(context, "ID_card", uid!, (uploading) {
                          setState(() {
                            uploadingIDcard = uploading;
                          });
                        });
                        setState(() {});
                      },
                      child: Text('Upload_ID_card'.i18n()),
                    ),
          vehicleRegistrationCard.isNotEmpty
              ? ShowFile(
                  onPressedCallback: () async {
                    vehicleRegistrationCard =
                        await upload.selectAndUploadImage(context, "Vehicle_Registration_Card", uid!, (uploading) {
                      setState(() {
                        uploadingRegistrationCard = uploading;
                      });
                    });
                    setState(() {});
                  },
                  file: vehicleRegistrationCard,
                  fileName: "Vehicle_Registration_Card".i18n(),
                )
              : uploadingRegistrationCard
                  ? Loading(
                      filename: 'Upload_Vehicle_Registration_Card'.i18n(),
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        vehicleRegistrationCard =
                            await upload.selectAndUploadImage(context, "Vehicle_Registration_Card", uid!, (uploading) {
                          setState(() {
                            uploadingRegistrationCard = uploading;
                          });
                        });
                        setState(() {});
                      },
                      child: Text('Upload_Vehicle_Registration_Card'.i18n()),
                    ),
          ibanBankAccount.isNotEmpty
              ? ShowFile(
                  onPressedCallback: () async {
                    ibanBankAccount =
                        await upload.selectAndUploadImage(context, "IBAN_bank_account", uid!, (uploading) {
                      setState(() {
                        uploadingIBAN = uploading;
                      });
                    });
                    setState(() {});
                  },
                  file: ibanBankAccount,
                  fileName: "IBAN_Bank_Account".i18n(),
                )
              : uploadingIBAN
                  ? Loading(
                      filename: 'Upload_IBAN_Bank_Account'.i18n(),
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        ibanBankAccount =
                            await upload.selectAndUploadImage(context, "IBAN_bank_account", uid!, (uploading) {
                          setState(() {
                            uploadingIBAN = uploading;
                          });
                        });
                        setState(() {});
                      },
                      child: Text('Upload_IBAN_Bank_Account'.i18n()),
                    ),

          insuranceDocument.isNotEmpty
              ? ShowFile(
                  onPressedCallback: () async {
                    insuranceDocument =
                        await upload.selectAndUploadImage(context, "Insurance_Document", uid!, (uploading) {
                      setState(() {
                        uploadingInsuranceDocument = uploading;
                      });
                    });
                    setState(() {});
                  },
                  file: insuranceDocument,
                  fileName: "Insurance_Document".i18n(),
                )
              : uploadingInsuranceDocument
                  ? Loading(
                      filename: 'Upload_Insurance_Document'.i18n(),
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        insuranceDocument =
                            await upload.selectAndUploadImage(context, "Insurance_Document", uid!, (uploading) {
                          setState(() {
                            uploadingInsuranceDocument = uploading;
                          });
                        });
                        setState(() {});
                      },
                      child: Text('Upload_Insurance_Document'.i18n()),
                    ),

          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(221, 0, 167, 117)),
            ),
            onPressed: () {
              if (idCard.isNotEmpty &&
                  vehicleRegistrationCard.isNotEmpty &&
                  ibanBankAccount.isNotEmpty &&
                  insuranceDocument.isNotEmpty) {
                if (companyName.isEmpty) {
                  displayError(context, "company_Name_should_not_empty".i18n());
                } else {
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
                }
              } else {
                displayError(context, "please_upload_all_documents".i18n());
              }
            },
            child: Text('request_for_refund'.i18n()),
          ),
        ],
      ),
    );
  }
}
