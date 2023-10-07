import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
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
