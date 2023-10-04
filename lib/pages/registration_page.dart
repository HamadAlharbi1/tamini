import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/components/custom_button.dart';
import 'package:tamini_app/components/custom_text_field.dart';
import 'package:tamini_app/components/otp_inputput_widget.dart';
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

  phoneAuth() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('enter_otp'.i18n()), // Use the i18n() method to get the translated string
          content: OtpInputWidget(
            onOtpEntered: (otp) async {
              // Handle the OTP verification logic here

              if (kDebugMode) {
                // If OTP is correct, navigate to the LoginPage
              } else {
                // If OTP is incorrect, show an error message
                // You can add error handling logic here
                // For example, displaying an error message to the user
                // print('Invalid OTP. Please try again.');
              }
            },
          ),
        );
      },
    );
  }

  createNewUserFromMobile(BuildContext context, String phoneNumber) async {
    // Check if the phone number starts with '05' and replace it with '+9665'
    if (phoneNumber.startsWith('05')) {
      phoneNumber = '+9665${phoneNumber.substring(2)}';
    }
    await auth.verifyPhoneNumber(
      timeout: const Duration(seconds: 60),
      phoneNumber: phoneNumber,
      verificationCompleted: (AuthCredential credential) async {
        try {
          auth
              .signInWithCredential(_credential)
              .then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return const HomePage();
                  })));
        } catch (e) {
          final snackBar = SnackBar(
            content: Text('Error: $e'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(() {
          final snackBar = SnackBar(
            content: Text('Error: $e'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      },
      codeSent: (String verificationId, int? resendToken) {
        showDialog(
          barrierDismissible: false,
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
                    print(e);
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
                  margin: const EdgeInsets.all(50),
                  padding: const EdgeInsets.all(50),
                  height: 200,
                  width: 200,
                  color: const Color.fromARGB(255, 180, 180, 180),
                  child: const Center(
                      child: Text(
                    "Logo",
                    style: TextStyle(fontSize: 30),
                  )),
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

class VeryFayForm extends StatelessWidget {
  const VeryFayForm({
    super.key,
    required this.veryFayController,
  });

  final TextEditingController veryFayController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'رمز التحقق',
        ),
        TextField(
          controller: veryFayController,
        ),
      ],
    );
  }
}
