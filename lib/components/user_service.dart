import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/common/enum.dart';
import 'package:tamini_app/common/error_messages.dart';
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
    if (phoneNumber.startsWith('05')) {
      phoneNumber = '+9665${phoneNumber.substring(2)}';
    }
    await auth.verifyPhoneNumber(
      timeout: const Duration(seconds: 120),
      phoneNumber: phoneNumber,
      verificationCompleted: (AuthCredential credential) async {
        _credential = credential;
        try {
          auth.signInWithCredential(_credential).then((value) => context.go('/registration'));
        } catch (e) {
          ErrorMessages.displayError(context, e);
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
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(
                                  userId: result.user!.uid,
                                )));
                    bool exists = await userExists(result.user!.uid);
                    if (!exists) {
                      UserData newUser = UserData(
                        userId: result.user!.uid,
                        userName: 'guest',
                        email: result.user!.email ?? '',
                        phoneNumber: phoneNumber,
                        profilePictureUrl: 'https://cdn4.iconfinder.com/data/icons/web-ui-color/128/Account-512.png',
                        userType: UserType.user.toString(),
                      );
                      await createUser(newUser);
                    }
                  }).catchError((e) {
                    ErrorMessages.displayError(context, e);
                  });
                },
              ),
            );
          },
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Called when the automatic code retrieval process times out.
      },
    );
  }

  Future<bool> userExists(String userId) async {
    DocumentSnapshot doc = await fireStore.collection('users').doc(userId).get();
    return doc.exists;
  }

  Future<void> updateUser(UserData user) async {
    await fireStore.collection('users').doc(user.userId).update(user.toMap());
  }

  Future<void> updatePhoneNumber(BuildContext context, String newPhoneNumber) async {
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
          // ignore: use_build_context_synchronously
          ErrorMessages.displayError(context, e);
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

                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  } catch (e) {
                    // ignore: use_build_context_synchronously
                    ErrorMessages.displayError(context, e);
                  }
                },
              ),
            );
          },
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Handle the timeout case
      },
    );
  }

  Future<UserData> getUser(String userId) async {
    DocumentSnapshot doc = await fireStore.collection('users').doc(userId).get();
    return UserData.fromMap(doc.data() as Map<String, dynamic>);
  }

  Future<void> deleteUser(String userId) async {
    await fireStore.collection('users').doc(userId).delete();
  }

  Future<void> showSnackbar(context, String message) async {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
