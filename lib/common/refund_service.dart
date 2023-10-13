import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/common/enum.dart';
import 'package:tamini_app/components/refunds/refunds_model.dart';

class RefundService {
  Future<void> updateRefund(context, String requestId, Map<String, dynamic> updates, String massage) async {
    try {
      await FirebaseFirestore.instance.collection('refunds').doc(requestId).update(updates);
      await showSnackbar(context, massage.i18n());
    } catch (e) {
      await showSnackbar(context, 'Error: $e');
    }
  }

  Future<void> showSnackbar(context, String message) async {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  listenToUserRefunds(uid, updateUI) {
    final collection = FirebaseFirestore.instance.collection('refunds').where('userId', isEqualTo: '$uid').snapshots();
    collection.listen((snapshot) {
      List<Refunds> newList = [];
      for (final doc in snapshot.docs) {
        final refund = Refunds.fromMap(doc.data());
        newList.add(refund);
      }
      newList.sort((b, a) => a.requestId.compareTo(b.requestId));
      updateUI(newList);
    });
  }

  listenToOwnerRefunds(updateUI) {
    final collection = FirebaseFirestore.instance.collection('refunds').snapshots();
    collection.listen((snapshot) {
      List<Refunds> newList = [];
      for (final doc in snapshot.docs) {
        final refund = Refunds.fromMap(doc.data());
        newList.add(refund);
      }
      newList.sort((b, a) => a.requestId.compareTo(b.requestId));
      updateUI(newList);
    });
  }

  Future<void> requestRefund(
    context,
    String idCard,
    String ibanBankAccount,
    String vehicleRegistrationCard,
    String insuranceDocument,
    String uid,
    String phoneNumber,
    String message,
    String companyName,
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

      await FirebaseFirestore.instance.collection('refunds').doc(currentRequestId.toString()).set({
        'idCard': idCard,
        'ibanBankAccount': ibanBankAccount,
        'vehicleRegistrationCard': vehicleRegistrationCard,
        'insuranceDocument': insuranceDocument,
        'userId': uid,
        'status': RequestStatus.newRequest.name,
        'phoneNumber': phoneNumber,
        'requestId': currentRequestId.toString(),
        'requestType': RequestType.refund.name,
        'requestDate': requestDate.toString(),
        'companyName': companyName,
      });
      showSnackbar(context, message);
    } catch (e) {
      showSnackbar(context, 'Error: $e');
    }
  }
}
