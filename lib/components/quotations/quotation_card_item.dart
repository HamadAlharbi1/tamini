import 'package:flutter/material.dart';

// this widget is used with both refund and quotation requests
class RequestCardItem extends StatelessWidget {
  const RequestCardItem({
    Key? key,
    required this.itemDescription,
    required this.itemValue,
  }) : super(key: key);

  final String itemValue;
  final String itemDescription;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 110,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(itemDescription, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            Text(
              itemValue,
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
