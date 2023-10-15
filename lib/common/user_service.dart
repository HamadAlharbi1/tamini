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
import 'package:tamini_app/pages/home_page.dart';

class UserService {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  late AuthCredential _credential;
  Future<void> createUser(UserData user) async {
    DocumentSnapshot doc = await fireStore.collection('metadata').doc('guestNumber').get();
    int latestNumber;
    if (!doc.exists) {
      latestNumber = 1000;
      await fireStore.collection('metadata').doc('guestNumber').set({'number': latestNumber});
    } else {
      latestNumber = doc['number'] ?? 1000;
    }
    user.userName = 'guest${latestNumber + 1}';
    await fireStore.collection('metadata').doc('guestNumber').update({'number': latestNumber + 1});
    await fireStore.collection('users').doc(user.userId).set(user.toMap());
  }

  Future<void> createNewUserFromMobile(
    BuildContext context,
    String phoneNumber,
  ) async {
    bool isLogin = false;
    if (phoneNumber.startsWith('05')) {
      phoneNumber = '+9665${phoneNumber.substring(2)}';
    }
    await auth.verifyPhoneNumber(
      timeout: const Duration(seconds: 60),
      phoneNumber: phoneNumber,
      verificationCompleted: (AuthCredential credential) async {
        _credential = credential;
        try {
          auth.signInWithCredential(_credential).then((value) => context.go('/registration'));
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
              title: Text('enter_otp'.i18n()), // Use the i18n() method to get the translated string
              content: OtpInputWidget(
                onOtpEntered: (otp) async {
                  FirebaseAuth auth = FirebaseAuth.instance;
                  String smsCode = otp;
                  _credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
                  auth.signInWithCredential(_credential).then((result) async {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
                    bool exists = await userExists(result.user!.uid);
                    if (!exists) {
                      UserData newUser = UserData(
                        userId: result.user!.uid,
                        userName: 'guest',
                        email: result.user!.email ?? '',
                        phoneNumber: phoneNumber,
                        profilePictureUrl: Constants.profileAvatarUrl,
                        userType: UserType.user.name,
                      );
                      await createUser(newUser);

                      showSnackbar(context, "registration_massage".i18n());
                      isLogin = true;
                    } else if (exists) {
                      showSnackbar(context, "login_massage".i18n());
                      isLogin = true;
                    }
                  }).catchError((e) {
                    displayError(context, e);
                  });
                },
              ),
            );
          },
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        isLogin ? null : context.pop();
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
                    context.pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<bool> userExists(String userId) async {
    DocumentSnapshot doc = await fireStore.collection('users').doc(userId).get();
    return doc.exists;
  }

  Future<void> updateUser(context, UserData user) async {
    await fireStore.collection('users').doc(user.userId).update(user.toMap());
    showSnackbar(context, "user_account_updated".i18n());
  }

  Future<void> updatePhoneNumber(BuildContext context, String newPhoneNumber, UserData user) async {
    bool isLogin = false;
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
              content: OtpInputWidget(
                onOtpEntered: (otp) async {
                  FirebaseAuth auth = FirebaseAuth.instance;
                  PhoneAuthCredential credential =
                      PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp);
                  try {
                    await auth.currentUser!.updatePhoneNumber(credential);

                    // Update the phone number in Firestore users collection
                    user.phoneNumber = newPhoneNumber;
                    await updateUser(context, user);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    isLogin = true;
                  } catch (e) {
                    displayError(context, e);
                  }
                },
              ),
            );
          },
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        isLogin ? null : context.pop();
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
                    context.pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Stream<UserData> streamUserData(String userId) {
    return fireStore.collection('users').doc(userId).snapshots().map((doc) {
      return UserData.fromMap(doc.data() as Map<String, dynamic>);
    });
  }

  Future<UserData> getUser(String userId) async {
    final document = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    final userData = UserData.fromMap(document.data() as Map<String, dynamic>);
    return userData;
  }

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
