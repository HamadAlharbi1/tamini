import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class RefundDescriptionPanel extends StatefulWidget {
  const RefundDescriptionPanel({Key? key}) : super(key: key);

  @override
  State<RefundDescriptionPanel> createState() => _RefundDescriptionPanelState();
}

class _RefundDescriptionPanelState extends State<RefundDescriptionPanel> {
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
                'When_can_you_get_a_refund_on_your_car_insurance?'.i18n(),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          },
          body: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'refund_description'.i18n(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
                DescriptionAndDoc(
                  descriptionKey: 'selling_the_vehicle'.i18n(),
                  docKey: 'selling_the_vehicle_doc'.i18n(),
                ),
                DescriptionAndDoc(
                  descriptionKey: 'got_new_insurance'.i18n(),
                  docKey: 'got_new_insurance_doc'.i18n(),
                ),
                DescriptionAndDoc(
                  descriptionKey: 'selling_process_canceled'.i18n(),
                  docKey: 'selling_process_canceled_doc'.i18n(),
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

class DescriptionAndDoc extends StatelessWidget {
  final String descriptionKey;
  final String docKey;

  const DescriptionAndDoc({
    Key? key,
    required this.descriptionKey,
    required this.docKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            descriptionKey,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            docKey,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
