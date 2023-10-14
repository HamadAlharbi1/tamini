import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/components/quotations/quotation_card.dart';
import 'package:tamini_app/components/quotations/quotation_card_item.dart';
import 'package:tamini_app/components/quotations/quotations_model.dart';

class QuotationData extends StatelessWidget {
  const QuotationData({super.key, required this.request});
  final Quotations request;
  @override
  Widget build(BuildContext context) {
    String fixNumber(String number) {
      if (number.startsWith("+966")) {
        return number.replaceFirst("+966", "0");
      }
      return number;
    }

    final requestDate = DateTime.parse(request.requestDate);
    return Column(
      children: [
        Tcard(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              QuotationCardItem(
                itemDescription: "request_id".i18n(),
                itemValue: request.requestId,
              ),
              QuotationCardItem(
                itemDescription: "request_date".i18n(),
                itemValue: ' ${DateFormat('dd/MM/yyyy').format(requestDate)}',
              ),
            ],
          ),
        ),
        const Divider(),
        Tcard(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              QuotationCardItem(
                itemDescription: "request_type".i18n(),
                itemValue: request.requestType.i18n(),
              ),
              QuotationCardItem(
                itemDescription: "request_status".i18n(),
                itemValue: request.status.i18n(),
              ),
            ],
          ),
        ),
        const Divider(),
        Tcard(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              QuotationCardItem(
                itemDescription: "phone_number".i18n(),
                itemValue: fixNumber(request.phoneNumber),
              ),
              QuotationCardItem(
                itemDescription: "national_id_number".i18n(),
                itemValue: request.nationalId.i18n(),
              ),
            ],
          ),
        ),
        const Divider(),
        Tcard(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              QuotationCardItem(
                itemDescription: "birth_date".i18n(),
                itemValue: request.birthDate.i18n(),
              ),
              QuotationCardItem(
                itemDescription: "vehicle_serial_number".i18n(),
                itemValue: request.carSerialNumber.i18n(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
