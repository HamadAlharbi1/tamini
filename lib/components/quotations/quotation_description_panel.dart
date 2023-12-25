import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class QuotationDescriptionPanel extends StatefulWidget {
  const QuotationDescriptionPanel({Key? key}) : super(key: key);

  @override
  State<QuotationDescriptionPanel> createState() => _QuotationDescriptionPanelState();
}

class _QuotationDescriptionPanelState extends State<QuotationDescriptionPanel> {
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
                'why_should_i_ask_for_quotation?'.i18n(),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          },
          body: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'request_quotation_description'.i18n(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
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
