import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/components/custom_button.dart';
import 'package:tamini_app/components/custom_text_field.dart';
import 'package:tamini_app/components/quotation_card_item.dart';
import 'package:tamini_app/components/quotations_model.dart';

class UpdateQuotationCard extends StatelessWidget {
  const UpdateQuotationCard({
    Key? key,
    required this.request,
  }) : super(key: key);

  final Quotations request;

  String fixNumber(String number) {
    if (number.startsWith("+966")) {
      return number.replaceFirst("+966", "0");
    }
    return number;
  }

  @override
  Widget build(BuildContext context) {
    final requestDate = DateTime.parse(request.requestDate);

    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration:
          BoxDecoration(color: const Color.fromARGB(255, 221, 221, 221), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuotationCardItem(
            itemDescription: "${"request_date".i18n()}:",
            itemValue: ' ${DateFormat('dd/MM/yyyy').format(requestDate)}',
          ),
          QuotationCardItem(
            itemDescription: "request_type".i18n(),
            itemValue: request.requestType.i18n(),
          ),
          QuotationCardItem(
            itemDescription: "request_status".i18n(),
            itemValue: request.status.i18n(),
          ),
          QuotationCardItem(
            itemDescription: "phone_number".i18n(),
            itemValue: fixNumber(request.phoneNumber),
          ),
          QuotationCardItem(
            itemDescription: "national_id_number".i18n(),
            itemValue: request.nationalId.i18n(),
          ),
          QuotationCardItem(
            itemDescription: "birth_date".i18n(),
            itemValue: request.birthDate.i18n(),
          ),
          QuotationCardItem(
            itemDescription: "vehicle_serial_number".i18n(),
            itemValue: request.carSerialNumber.i18n(),
          ),
          UpdateQuotationCardItem(
            requestId: request.requestId,
            itemDescription: "${"insurance_amount".i18n()}:",
            itemValue: request.insuranceAmount.toString(),
          ),
        ],
      ),
    );
  }
}

class UpdateQuotationCardItem extends StatefulWidget {
  const UpdateQuotationCardItem({
    super.key,
    required this.itemDescription,
    required this.itemValue,
    required this.requestId,
  });
  final String requestId;
  final String itemValue;
  final String itemDescription;

  @override
  State<UpdateQuotationCardItem> createState() => _UpdateQuotationCardItemState();
}

class _UpdateQuotationCardItemState extends State<UpdateQuotationCardItem> {
  @override
  void initState() {
    super.initState();
    itemValueController.text = widget.itemValue;
  }

  update(context) async {
    try {
      await FirebaseFirestore.instance.collection('quotations').doc(widget.requestId).update(
        {"insuranceAmount": double.parse(itemValueController.text), 'status': "sent_awaiting_approval".i18n()},
      );
      await showRequestUpdatedSnackbar();
    } catch (e) {
      errorShow(e);
    }
  }

  Future<void> showRequestUpdatedSnackbar() async {
    final snackBar = SnackBar(
      content: Text('request_updated'.i18n()),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> errorShow(dynamic e) async {
    final snackBar = SnackBar(
      content: Text('error:$e'.i18n()),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  TextEditingController itemValueController = TextEditingController();
  bool isEdit = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.itemDescription,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        isEdit
            ? CustomButton(
                borderRadius: 4,
                vertical: 8,
                buttonText: '',
                isText: false,
                child: const Icon(
                  Icons.done,
                  size: 30,
                ),
                onPressed: () async {
                  await update(context);
                  setState(() {
                    isEdit = !isEdit;
                  });
                },
              )
            : CustomButton(
                borderRadius: 4,
                vertical: 8,
                buttonText: '',
                isText: false,
                child: const Icon(
                  Icons.edit,
                ),
                onPressed: () {
                  setState(() {
                    isEdit = !isEdit;
                  });
                },
              ),
        isEdit
            ? SizedBox(
                width: 90,
                child: CustomTextField(
                  controller: itemValueController,
                  labelText: '',
                  hintText: '',
                  keyboardType: TextInputType.number,
                ),
              )
            : Text(
                widget.itemValue,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ],
    );
  }
}
