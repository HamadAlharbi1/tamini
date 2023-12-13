// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/common/enum.dart';
import 'package:tamini_app/common/util.dart';
import 'package:tamini_app/components/quotations/quotations_model.dart';

class QuotationService {
  /// updates is used to update any special fields for example  {'status': QuotationStatus.reject.name}
  /// Updates the quotation with the given requestId using the provided updates map.
  /// Shows a snackbar with the given message.
  Future<void> updateQuotation(context, String requestId, Map<String, dynamic> updates, String massage) async {
    try {
      await FirebaseFirestore.instance.collection('quotations').doc(requestId).update(updates);
      await showSnackbar(context, massage.i18n());
    } catch (e) {
      displayError(context, e);
    }
  }

  /// Listens to quotations for the given user uid and calls updateUI with the list on each change.
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

  /// Listens to all quotations and calls updateUI with the full list on each change.
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

  /// Requests a new quotation by generating a requestId and adding a document.
  /// Shows a snackbar with the given message on success.
  Future<void> requestQuotation(
    BuildContext context,
    String birthDate,
    String quotationType,
    String nationalId,
    String startInsuranceDate,
    String sellerNationalId,
    String sellerBirthDate,
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
        "quotationType": quotationType,
        'newOwnerNationalId': nationalId,
        'newOwnerBirthDate': birthDate,
        'sellerNationalId': sellerNationalId,
        'sellerBirthDate': sellerBirthDate,
        'carSerialNumber': carSerialNumber,
        'userId': uid,
        'status': QuotationStatus.newRequest.name,
        'phoneNumber': phoneNumber,
        'insuranceAmount': 0.00,
        'requestId': newRequestId.toString(),
        'requestType': RequestType.quotation.name,
        'requestDate': requestDate.toString(),
        "startInsuranceDate": startInsuranceDate
      });
      context.replace('/home_page');
      showSnackbar(context, message);
    } catch (e) {
      displayError(context, e);
    }
  }
}
