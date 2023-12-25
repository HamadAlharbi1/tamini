import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:tamini_app/components/constants.dart';
import 'package:tamini_app/provider/language_provider.dart';

class QuotationServiceCost extends StatefulWidget {
  const QuotationServiceCost({Key? key}) : super(key: key);

  @override
  State<QuotationServiceCost> createState() => _QuotationServiceCostState();
}

class _QuotationServiceCostState extends State<QuotationServiceCost> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    Provider.of<LanguageProvider>(context); // this is added since the language could changes on profile_page
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
                'Cost_of_quotation_service?'.i18n(),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          },
          body: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${Constants.quotationCost} ${"S_R".i18n()} ${"after_complete".i18n()}",
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
