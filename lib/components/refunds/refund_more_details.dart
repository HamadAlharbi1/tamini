import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/common/util.dart';
import 'package:tamini_app/components/decorated_row_card.dart';
import 'package:tamini_app/components/quotations/quotation_card_item.dart';
import 'package:tamini_app/components/refunds/refunds_model.dart';
import 'package:tamini_app/components/refunds/show_file.dart';

class RefundMoreDetails extends StatefulWidget {
  final Refunds request;
  const RefundMoreDetails({required this.request, Key? key}) : super(key: key);

  @override
  State<RefundMoreDetails> createState() => _RefundMoreDetailsState();
}

class _RefundMoreDetailsState extends State<RefundMoreDetails> {
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
          backgroundColor: Theme.of(context).cardColor, // Using primary color from theme,
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
                        itemDescription: "phone_number".i18n(),
                        itemValue: fixNumber(widget.request.phoneNumber),
                      ),
                      RequestCardItem(
                        itemDescription: "request_date".i18n(),
                        itemValue: DateFormat('yyyy/MM/dd').format(requestDate),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                DecoratedRowCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RequestCardItem(
                        itemDescription: "company_name".i18n(),
                        itemValue: fixNumber(widget.request.companyName),
                      ),
                    ],
                  ),
                ),
                ShowFile(file: widget.request.idCard, description: 'ID_card'.i18n()),
                ShowFile(file: widget.request.ibanBankAccount, description: 'IBAN_Bank_Account'.i18n()),
                ShowFile(file: widget.request.vehicleRegistrationCard, description: 'Vehicle_Registration_Card'.i18n()),
                ShowFile(file: widget.request.insuranceDocument, description: 'Insurance_Document'.i18n()),
              ],
            ),
          ),
          isExpanded: _isExpanded,
        ),
      ],
    );
  }
}
