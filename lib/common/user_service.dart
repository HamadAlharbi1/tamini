// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/common/enum.dart';
import 'package:tamini_app/common/util.dart';
import 'package:tamini_app/components/constants.dart';
import 'package:tamini_app/components/otp_input_widget.dart';
import 'package:tamini_app/components/user_model.dart';

class UserService {
  /// Gets an instance of Firebase Firestore
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  /// Gets an instance of Firebase Auth
  final FirebaseAuth auth = FirebaseAuth.instance;

  /// Auth credential for phone authentication
  late AuthCredential _credential;

  /// Creates a new user document in Firestore
  Future<void> createUser(UserData user) async {
    // Get latest guest number
    DocumentSnapshot doc = await fireStore.collection('metadata').doc('guestNumber').get();
    int latestNumber;
    if (!doc.exists) {
      latestNumber = 1000;
      await fireStore.collection('metadata').doc('guestNumber').set({'number': latestNumber});
    } else {
      latestNumber = doc['number'] ?? 1000;
    }

    // Generate guest username
    user.userName = 'guest${latestNumber + 1}';

    // Increment guest number
    await fireStore.collection('metadata').doc('guestNumber').update({'number': latestNumber + 1});

    // Add user document
    await fireStore.collection('users').doc(user.userId).set(user.toMap());
  }

  /// Creates a new user by verifying phone number and saving to Firestore
  Future<void> createNewUserFromMobile(
    BuildContext context,
    String phoneNumber,
  ) async {
    if (phoneNumber.startsWith('05')) {
      phoneNumber = '+9665${phoneNumber.substring(2)}';
    }
    await auth.verifyPhoneNumber(
      timeout: const Duration(seconds: 60),
      phoneNumber: phoneNumber,
      verificationCompleted: (AuthCredential credential) async {
        _credential = credential;
        try {
          auth.signInWithCredential(_credential);
        } catch (e) {
          displayError(context, e);
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        throw e;
      },
      codeSent: (String verificationId, int? resendToken) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('enter_otp'.i18n()),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(maskPhoneNumber(context, phoneNumber)),
                  OtpInputWidget(
                    onOtpEntered: (otp) async {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      String smsCode = otp;
                      _credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
                      auth.signInWithCredential(_credential).then((result) async {
                        bool exists = await userExists(result.user!.uid);
                        if (!exists) {
                          UserData newUser = UserData(
                            userId: result.user!.uid,
                            userName: 'guest',
                            email: result.user!.email ?? '',
                            phoneNumber: phoneNumber,
                            profilePictureUrl: Constants.refundCost,
                            userType: UserType.user.name,
                          );
                          await createUser(newUser);
                          showSnackbar(context, "registration_massage".i18n());
                          context.pop(context);
                          context.replace('/home_page');
                        } else if (exists) {
                          showSnackbar(context, "login_massage".i18n());
                          context.pop(context);
                          context.replace('/home_page');
                        }
                      }).catchError((e) {
                        showSnackbar(context, "Invalid_OTP".i18n());
                      });
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        context.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("time_out".i18n()),
              content: Text("time_out_massage".i18n()),
              actions: <Widget>[
                TextButton(
                  child: Text("ok".i18n()),
                  onPressed: () {
                    context.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// Checks if a user document exists for the given ID
  Future<bool> userExists(String userId) async {
    DocumentSnapshot doc = await fireStore.collection('users').doc(userId).get();
    if (doc.exists) {
      return true;
    } else {
      return false;
    }
  }

  /// Updates an existing user document
  Future<void> updateUser(context, UserData user) async {
    await fireStore.collection('users').doc(user.userId).update(user.toMap());
    showSnackbar(context, "user_account_updated".i18n());
  }

  /// Updates user's phone number after verification
  Future<void> updatePhoneNumber(BuildContext context, String newPhoneNumber, UserData user) async {
    if (newPhoneNumber.startsWith('05')) {
      newPhoneNumber = '+9665${newPhoneNumber.substring(2)}';
    }
    await auth.verifyPhoneNumber(
      phoneNumber: newPhoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          await auth.currentUser!.updatePhoneNumber(credential);
        } catch (e) {
          displayError(context, e);
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        throw e;
      },
      codeSent: (String verificationId, int? resendToken) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('enter_otp'.i18n()),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(maskPhoneNumber(context, newPhoneNumber)),
                  OtpInputWidget(
                    onOtpEntered: (otp) async {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp);
                      try {
                        await auth.currentUser!.updatePhoneNumber(credential);

                        // Update the phone number in Firestore users collection
                        user.phoneNumber = newPhoneNumber;
                        await updateUser(context, user);
                        context.pop(context);
                        context.pop(context);
                      } catch (e) {
                        displayError(context, e);
                      }
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        context.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("time_out".i18n()),
              content: Text("time_out_massage".i18n()),
              actions: <Widget>[
                TextButton(
                  child: Text("ok".i18n()),
                  onPressed: () {
                    context.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// Gets a user data stream
  Stream<UserData> streamUserData(String userId) {
    // Create a reference to the Firestore 'users' collection document for the given userId.
    final userDocRef = fireStore.collection('users').doc(userId);

    // Create a stream that listens to changes in the document.
    final userDocStream = userDocRef.snapshots();

    // Map the snapshots to UserData objects and handle potential errors.
    final userDataStream = userDocStream.asyncMap((doc) async {
      if (doc.exists) {
        return UserData.fromMap(doc.data() as Map<String, dynamic>);
      } else {
        throw Exception('User document not found for ID: $userId');
      }
    });
    return userDataStream; //
  }

  /// Deletes a user document
  Future<void> deleteUser(context, String userId) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete_User'.i18n()),
          content: Text("Delete_User_massage".i18n()),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Cancel'.i18n()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Delete'.i18n()),
              onPressed: () async {
                await fireStore.collection('users').doc(userId).delete();
                context.go('/registration');
                showSnackbar(context, "user_account_deleted".i18n());
              },
            ),
          ],
        );
      },
    );
  }
}
