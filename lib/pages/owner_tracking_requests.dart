import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/components/quotations_model.dart';
import 'package:tamini_app/components/update_qutation_card.dart';

class OwnerTrackingRequests extends StatefulWidget {
  const OwnerTrackingRequests({Key? key}) : super(key: key);

  @override
  State<OwnerTrackingRequests> createState() => _OwnerTrackingRequestsState();
}

class _OwnerTrackingRequestsState extends State<OwnerTrackingRequests> {
  List<Quotations> quotations = [];
  listenRequestQuotations() async {
    final collection = FirebaseFirestore.instance.collection('quotations').snapshots();
    collection.listen((snapshot) {
      List<Quotations> newList = [];
      for (final doc in snapshot.docs) {
        final tDetail = Quotations.fromMap(doc.data());
        newList.add(tDetail);
      }
      quotations = newList;
      setState(() {});
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  dynamic uid;
  @override
  void initState() {
    User? user = _auth.currentUser;
    uid = user?.uid;
    super.initState();
    listenRequestQuotations();
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
          children: [for (var request in quotations) UpdateQuotationCard(request: request)],
        ),
      ),
    );
  }
}
