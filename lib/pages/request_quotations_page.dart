import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class RequestQuotations extends StatefulWidget {
  const RequestQuotations({Key? key}) : super(key: key);

  @override
  State<RequestQuotations> createState() => _RequestQuotationsState();
}

class _RequestQuotationsState extends State<RequestQuotations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request_Quotations'.i18n()), // Use the i18n() method to get the translated string
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
