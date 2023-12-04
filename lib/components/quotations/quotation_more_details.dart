import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/common/enum.dart';
import 'package:tamini_app/common/util.dart';
import 'package:tamini_app/components/decorated_row_card.dart';
import 'package:tamini_app/components/quotations/quotation_card_item.dart';
import 'package:tamini_app/components/quotations/quotations_model.dart';

class QuotationMoreDetails extends StatefulWidget {
  final Quotations request;
  const QuotationMoreDetails({required this.request, Key? key}) : super(key: key);

  @override
  State<QuotationMoreDetails> createState() => _QuotationMoreDetailsState();
}

class _QuotationMoreDetailsState extends State<QuotationMoreDetails> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final requestDate = DateTime.parse(widget.request.requestDate);
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
                'more_details'.i18n(),
                style: theme.textTheme.bodyLarge,
              ),
            );
          },
          body: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DecoratedRowCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RequestCardItem(
                        itemDescription: "request_date".i18n(),
                        itemValue: ' ${DateFormat('dd/MM/yyyy').format(requestDate)}',
                      ),
                      RequestCardItem(
                        itemDescription: "quotationType".i18n(),
                        itemValue: widget.request.quotationType.i18n(),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                DecoratedRowCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RequestCardItem(
                        itemDescription: "phone_number".i18n(),
                        itemValue: fixNumber(widget.request.phoneNumber),
                      ),
                      RequestCardItem(
                        itemDescription: "vehicle_serial_number".i18n(),
                        itemValue: widget.request.carSerialNumber.i18n(),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                widget.request.quotationType == QuotationType.transferQuotation.name
                    ? DecoratedRowCard(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RequestCardItem(
                              itemDescription: "seller_birth_date".i18n(),
                              itemValue: widget.request.sellerBirthDate,
                            ),
                            RequestCardItem(
                              itemDescription: "seller_Governemnt_ID/Iqama_ID".i18n(),
                              itemValue: widget.request.sellerNationalId,
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
                const Divider(),
                DecoratedRowCard(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RequestCardItem(
                        itemDescription: widget.request.quotationType == QuotationType.transferQuotation.name
                            ? "buyer_birth_date".i18n()
                            : "birth_date".i18n(),
                        itemValue: widget.request.newOwnerBirthDate.i18n(),
                      ),
                      RequestCardItem(
                        itemDescription: widget.request.quotationType == QuotationType.transferQuotation.name
                            ? "buyer_Governemnt_ID/Iqama_ID".i18n()
                            : "Governemnt_ID/Iqama_ID".i18n(),
                        itemValue: widget.request.newOwnerNationalId.i18n(),
                      ),
                    ],
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
          isExpanded: _isExpanded,
        ),
      ],
    );
  }
}
