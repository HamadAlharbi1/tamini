import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/components/custom_button.dart';
import 'package:tamini_app/components/custom_text_field.dart';
import 'package:tamini_app/components/otp_input_widget.dart';
import 'package:tamini_app/pages/home_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({
    Key? key,
  }) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  late AuthCredential _credential;
  @override
  void initState() {
    super.initState();
  }

  displayError(Object e) {
    final snackBar = SnackBar(
      content: Text('Error: $e'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  createNewUserFromMobile(BuildContext context, String phoneNumber) async {
    // Check if the phone number starts with '05' and replace it with '+9665'
    if (phoneNumber.startsWith('05')) {
      phoneNumber = '+9665${phoneNumber.substring(2)}';
    }
    await auth.verifyPhoneNumber(
      timeout: const Duration(seconds: 120),
      phoneNumber: phoneNumber,
      verificationCompleted: (AuthCredential credential) async {
        try {
          auth
              .signInWithCredential(_credential)
              .then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return const HomePage();
                  })));
        } catch (e) {
          displayError(e);
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(() {
          displayError(e);
        });
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
                  auth.signInWithCredential(_credential).then((result) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
                  }).catchError((e) {
                    displayError(e);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('registration_title'.i18n())),
      ),
      body: Center(
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                  ),
                  margin: const EdgeInsets.all(50),
                  child: Image.network(
                      'https://cdn.discordapp.com/attachments/1083124198827888830/1159214780209434726/image.png?ex=653035e4&is=651dc0e4&hm=e703873e965917a1d19716ea732c2f6383908ed6d89c33444c09213aa64d5dcf&'),
                ),
                const SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomTextField(
                    controller: phoneNumberController,
                    labelText: 'phone_number'.i18n(),
                    hintText: 'enter_phone_number'.i18n(),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                CustomButton(
                  onPressed: () {
                    createNewUserFromMobile(context, phoneNumberController.text);
                  },
                  buttonText: 'continue'.i18n(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
