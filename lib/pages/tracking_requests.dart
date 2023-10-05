import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/components/quotation_card_item.dart';
import 'package:tamini_app/components/quotations_model.dart';

class TrackingRequests extends StatefulWidget {
  const TrackingRequests({Key? key}) : super(key: key);

  @override
  State<TrackingRequests> createState() => _TrackingRequestsState();
}

class _TrackingRequestsState extends State<TrackingRequests> {
  List<Quotations> quotations = [];
  listenRequestQuotations() async {
    final collection =
        FirebaseFirestore.instance.collection('RequestQuotations').where('userId', isEqualTo: '$uid').snapshots();
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [for (var request in quotations) QuotationCard(request: request)],
        ),
      ),
    );
  }
}

class QuotationCard extends StatelessWidget {
  const QuotationCard({
    Key? key,
    required this.request,
  }) : super(key: key);

  final Quotations request;

  @override
  Widget build(BuildContext context) {
    final requestDate = DateTime.parse(request.requestDate);

    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration:
          BoxDecoration(color: const Color.fromARGB(255, 221, 221, 221), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuotationCardItem(
            itemDescription: "request_status".i18n(),
            itemValue: request.status.i18n(),
          ),
          QuotationCardItem(
            itemDescription: "vehicle_serial_number".i18n(),
            itemValue: request.carSerialNumber.i18n(),
          ),
          QuotationCardItem(
            itemDescription: "request_type".i18n(),
            itemValue: request.requestType.i18n(),
          ),
          QuotationCardItem(
            itemDescription: "${"insurance_amount".i18n()}:",
            itemValue: request.insuranceAmount.toString(),
          ),
          QuotationCardItem(
            itemDescription: "${"request_date".i18n()}:",
            itemValue: ' ${DateFormat('dd/MM/yyyy').format(requestDate)}',
          ),
        ],
      ),
    );
  }
}
