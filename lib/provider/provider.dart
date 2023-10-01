import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  String? name;
  String? email;
  String? phoneNumber;

  UserProvider() {
    _user = FirebaseAuth.instance.currentUser;
    _fetchUserProfile();
  }

  User? get user => _user;

  Future<void> _fetchUserProfile() async {
    if (_user != null) {
      DocumentSnapshot userProfile = await FirebaseFirestore.instance.collection('users').doc(_user!.uid).get();
      name = userProfile['name'];
      email = userProfile['email'];
      phoneNumber = userProfile['phoneNumber'];
      notifyListeners();
    }
  }

  Future<void> updateUserProfile(String newName, String newEmail, String newPhoneNumber) async {
    if (_user != null) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(_user!.uid).update({
          'name': newName,
          'email': newEmail,
          'phoneNumber': newPhoneNumber,
        });
        name = newName;
        email = newEmail;
        phoneNumber = newPhoneNumber;
        notifyListeners();
      } catch (e) {
        print('Error updating user profile: $e');
        // Consider notifying the user about the error
      }
    }
  }

  Future<void> requestRefund(String reason) async {
    if (_user != null) {
      await FirebaseFirestore.instance.collection('refundRequests').add({
        'userId': _user!.uid,
        'reason': reason,
        'timestamp': Timestamp.now(),
      });
    }
  }

  Future<bool> get isEligibleForRefund async {
    if (_user != null) {
      DocumentSnapshot userPurchase = await FirebaseFirestore.instance.collection('purchases').doc(_user!.uid).get();
      return userPurchase.exists && userPurchase['hasActiveSubscription'] == true;
    }
    return false;
  }
}
