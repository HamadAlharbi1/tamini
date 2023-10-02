import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class RequestRefund extends StatefulWidget {
  const RequestRefund({Key? key}) : super(key: key);

  @override
  State<RequestRefund> createState() => _RequestRefundState();
}

class _RequestRefundState extends State<RequestRefund> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request_Refund'.i18n()), // Use the i18n() method to get the translated string
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
