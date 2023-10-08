import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import 'package:tamini_app/common/quotation_service.dart';
import 'package:tamini_app/components/quotations/quotations_model.dart';
import 'package:tamini_app/components/quotations/update_qutation_card.dart';

class OwnerTrackingRequests extends StatefulWidget {
  const OwnerTrackingRequests({Key? key}) : super(key: key);

  @override
  State<OwnerTrackingRequests> createState() => _OwnerTrackingRequestsState();
}

class _OwnerTrackingRequestsState extends State<OwnerTrackingRequests> {
  List<Quotations> ownerQuotations = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? uid;
  @override
  void initState() {
    User? user = _auth.currentUser;
    uid = user?.uid;
    super.initState();
    QuotationService.listenToOwnerQuotations((quotations) {
      setState(() {
        ownerQuotations = quotations;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${'Tracking_Requests'.i18n()} ${'owner'.i18n()}"), // Use the i18n() method to get the translated string
      ),
      body: Center(
        child: ListView(
          children: [for (var request in ownerQuotations) UpdateQuotationCard(request: request)],
        ),
      ),
    );
  }
}
