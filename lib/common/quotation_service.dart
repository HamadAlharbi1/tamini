import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/components/quotations/quotations_model.dart';

class QuotationService {
  static Future<void> updateQuotation(context, String requestId, Map<String, dynamic> updates, String massage) async {
    try {
      await FirebaseFirestore.instance.collection('quotations').doc(requestId).update(updates);

      await showSnackbar(context, massage.i18n());
    } catch (e) {
      await showSnackbar(context, 'Error: $e');
    }
  }

  static Future<void> showSnackbar(context, String message) async {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static listenToUserQuotations(uid, updateUI) {
    final collection =
        FirebaseFirestore.instance.collection('quotations').where('userId', isEqualTo: '$uid').snapshots();

    collection.listen((snapshot) {
      List<Quotations> newList = [];

      for (final doc in snapshot.docs) {
        final quotation = Quotations.fromMap(doc.data());
        newList.add(quotation);
      }
      newList.sort((b, a) => a.requestId.compareTo(b.requestId));
      updateUI(newList);
    });
  }

  static listenToOwnerQuotations(updateUI) {
    final collection = FirebaseFirestore.instance.collection('quotations').snapshots();
    collection.listen((snapshot) {
      List<Quotations> newList = [];
      for (final doc in snapshot.docs) {
        final quotation = Quotations.fromMap(doc.data());
        newList.add(quotation);
      }
      newList.sort((b, a) => a.requestId.compareTo(b.requestId));
      updateUI(newList);
    });
  }

  static Future<void> showRequestAddedSnackbar(BuildContext context) async {
    final snackBar = SnackBar(
      content: Text('request_added'.i18n()),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Future<void> requestQuotation(
    BuildContext context,
    String nationalId,
    String birthDate,
    String carSerialNumber,
    String uid,
    String phoneNumber,
  ) async {
    final DateTime requestDate = DateTime.now();

    try {
      DocumentSnapshot metadata = await FirebaseFirestore.instance.collection('metadata').doc('requestId').get();
      Map<String, dynamic>? data = metadata.data() as Map<String, dynamic>?;
      int currentRequestId;
      if (data != null && data.containsKey('currentRequestId')) {
        currentRequestId = data['currentRequestId'];
      } else {
        currentRequestId = 1000;
      }

      int newRequestId = currentRequestId + 1;

      await FirebaseFirestore.instance.collection('metadata').doc('requestId').set({
        'currentRequestId': newRequestId,
      });

      await FirebaseFirestore.instance.collection('quotations').doc(newRequestId.toString()).set({
        'nationalId': nationalId,
        'birthDate': birthDate,
        'carSerialNumber': carSerialNumber,
        'userId': uid,
        'status': "under_review",
        'phoneNumber': phoneNumber,
        'insuranceAmount': 0.00,
        'requestId': newRequestId.toString(),
        'requestType': 'quotation',
        'requestDate': requestDate.toString(),
      });

      // ignore: use_build_context_synchronously
      await showSnackbar(context, 'request_added'.i18n());
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackbar(context, 'Error: $e');
    }
  }
}
