import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/components/refunds/refund_percent_model.dart';

class DurationVsPercentPanel extends StatefulWidget {
  const DurationVsPercentPanel({Key? key}) : super(key: key);

  @override
  State<DurationVsPercentPanel> createState() => _DurationVsPercentPanelState();
}

class _DurationVsPercentPanelState extends State<DurationVsPercentPanel> {
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
                'How_much_is_the_refund_amount?'.i18n(),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          },
          body: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "refund_amount_calculation_mechanism".i18n(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 400,
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: refundPercentList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${refundPercentList[index].days} ',
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    'day'.i18n(),
                                    style: const TextStyle(fontSize: 11),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              Text(
                                '%${refundPercentList[index].refundPercent}',
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'out_of_insurance_amount'.i18n(),
                                style: Theme.of(context).textTheme.bodySmall,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          isExpanded: _isExpanded,
        ),
      ],
    );
  }
}
