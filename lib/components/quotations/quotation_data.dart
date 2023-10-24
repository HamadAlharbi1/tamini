import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/components/quotations/quotation_card.dart';
import 'package:tamini_app/components/quotations/quotation_card_item.dart';
import 'package:tamini_app/components/quotations/quotations_model.dart';
import 'package:tamini_app/common/util.dart';

class QuotationData extends StatelessWidget {
  const QuotationData({super.key, required this.request});
  final Quotations request;
  @override
  Widget build(BuildContext context) {
    final requestDate = DateTime.parse(request.requestDate);
    return Column(
      children: [
        DecoratedRowCard(
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
        DecoratedRowCard(
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
        DecoratedRowCard(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              QuotationCardItem(
                itemDescription: "phone_number".i18n(),
                itemValue: fixNumber(request.phoneNumber),
              ),
              QuotationCardItem(
                itemDescription: "Governemnt_ID/Iqama_ID".i18n(),
                itemValue: request.nationalId.i18n(),
              ),
            ],
          ),
        ),
        const Divider(),
        DecoratedRowCard(
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
