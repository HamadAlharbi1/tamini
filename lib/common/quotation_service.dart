import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/common/enum.dart';
import 'package:tamini_app/components/quotations/quotations_model.dart';

class QuotationService {
  Future<void> updateQuotation(context, String requestId, Map<String, dynamic> updates, String massage) async {
    try {
      await FirebaseFirestore.instance.collection('quotations').doc(requestId).update(updates);
      await showSnackbar(context, massage.i18n());
    } catch (e) {
      await showSnackbar(context, 'Error: $e');
    }
  }

  Future<void> showSnackbar(context, String message) async {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  listenToUserQuotations(uid, updateUI) {
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

  listenToOwnerQuotations(updateUI) {
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

  Future<void> requestQuotation(
    context,
    String nationalId,
    String birthDate,
    String carSerialNumber,
    String uid,
    String phoneNumber,
    String message,
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

      await FirebaseFirestore.instance.collection('metadata').doc('requestId').update({
        'currentRequestId': newRequestId,
      });

      await FirebaseFirestore.instance.collection('quotations').doc(newRequestId.toString()).set({
        'nationalId': nationalId,
        'birthDate': birthDate,
        'carSerialNumber': carSerialNumber,
        'userId': uid,
        'status': QuotationStatus.newRequest.name,
        'phoneNumber': phoneNumber,
        'insuranceAmount': 0.00,
        'requestId': newRequestId.toString(),
        'requestType': RequestType.quotation.name,
        'requestDate': requestDate.toString(),
      });

      showSnackbar(context, message);
    } catch (e) {
      showSnackbar(context, 'Error: $e');
    }
  }
}
