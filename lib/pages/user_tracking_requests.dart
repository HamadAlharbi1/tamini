import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/components/quotation_card.dart';
import 'package:tamini_app/components/quotations_model.dart';

class UserTrackingRequests extends StatefulWidget {
  const UserTrackingRequests({Key? key}) : super(key: key);

  @override
  State<UserTrackingRequests> createState() => _UserTrackingRequestsState();
}

class _UserTrackingRequestsState extends State<UserTrackingRequests> {
  List<Quotations> quotations = [];
  listenRequestQuotations() async {
    final collection =
        FirebaseFirestore.instance.collection('quotations').where('userId', isEqualTo: '$uid').snapshots();
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
        title: Text('Tracking_Requests'.i18n()), // Use the i18n() method to get the translated string
      ),
      body: Center(
        child: ListView(
          children: [for (var request in quotations) QuotationCard(request: request)],
        ),
      ),
    );
  }
}
