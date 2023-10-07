import 'package:flutter/material.dart';

class QuotationCardItem extends StatelessWidget {
  const QuotationCardItem({
    super.key,
    required this.itemDescription,
    required this.itemValue,
  });

  final String itemValue;
  final String itemDescription;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          itemDescription,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          itemValue,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
