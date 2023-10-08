import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import 'package:tamini_app/common/quotation_service.dart';
import 'package:tamini_app/components/quotations/quotation_card.dart';
import 'package:tamini_app/components/quotations/quotations_model.dart';

class UserTrackingRequests extends StatefulWidget {
  const UserTrackingRequests({Key? key}) : super(key: key);

  @override
  State<UserTrackingRequests> createState() => _UserTrackingRequestsState();
}

class _UserTrackingRequestsState extends State<UserTrackingRequests> {
  List<Quotations> userQuotations = [];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  dynamic uid;
  @override
  void initState() {
    User? user = _auth.currentUser;
    uid = user?.uid;
    super.initState();
    // listenRequestQuotations();
    QuotationService.listenToUserQuotations(uid, (quotations) {
      setState(() {
        userQuotations = quotations;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tracking_Requests'.i18n()), // Use the i18n() method to get the translated string
      ),
      body: Center(
        child: ListView(
          children: [for (final request in userQuotations) QuotationCard(request: request)],
        ),
      ),
    );
  }
}
