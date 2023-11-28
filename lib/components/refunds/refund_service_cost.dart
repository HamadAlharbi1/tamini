import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/components/constants.dart';
import 'package:tamini_app/components/refunds/refund_description_panel.dart';

class RefundServiceCost extends StatefulWidget {
  const RefundServiceCost({Key? key}) : super(key: key);

  @override
  State<RefundServiceCost> createState() => _RefundServiceCostState();
}

class _RefundServiceCostState extends State<RefundServiceCost> {
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
                'Cost_of_refund_service?'.i18n(),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          },
          body: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DescriptionAndDoc(
                  descriptionKey: "${Constants.refundCost} ${"S_R".i18n()} ${"after_complete".i18n()}",
                  docKey: ''.i18n(),
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
