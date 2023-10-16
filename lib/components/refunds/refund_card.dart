import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/common/util.dart';
import 'package:tamini_app/components/quotations/quotation_card.dart';
import 'package:tamini_app/components/quotations/quotation_card_item.dart';
import 'package:tamini_app/components/refunds/refunds_model.dart';
import 'package:tamini_app/components/refunds/show_file.dart';

class RefundCard extends StatefulWidget {
  final Refunds request;
  const RefundCard({required this.request, Key? key}) : super(key: key);

  @override
  State<RefundCard> createState() => _RefundCardState();
}

class _RefundCardState extends State<RefundCard> {
  @override
  Widget build(BuildContext context) {
    final requestDate = DateTime.parse(widget.request.requestDate);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecoratedRowCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    QuotationCardItem(
                      itemDescription: "request_id".i18n(),
                      itemValue: widget.request.requestId,
                    ),
                    QuotationCardItem(
                      itemDescription: "request_date".i18n(),
                      itemValue: DateFormat('yyyy/MM/dd').format(requestDate),
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
                      itemValue: widget.request.requestType.i18n(),
                    ),
                    QuotationCardItem(
                      itemDescription: "request_status".i18n(),
                      itemValue: widget.request.status.i18n(),
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
                      itemValue: fixNumber(widget.request.phoneNumber),
                    ),
                  ],
                ),
              ),
              const Divider(),
              ShowFile(file: widget.request.idCard, description: 'ID_card'.i18n()),
              ShowFile(file: widget.request.ibanBankAccount, description: 'IBAN_Bank_Account'.i18n()),
              ShowFile(file: widget.request.vehicleRegistrationCard, description: 'Vehicle_Registration_Card'.i18n()),
              ShowFile(file: widget.request.insuranceDocument, description: 'Insurance_Document'.i18n()),
            ],
          ),
        ),
      ),
    );
  }
}
