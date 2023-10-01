import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/components/custom_button.dart';
import 'package:tamini_app/components/custom_text_field.dart';
import 'package:tamini_app/components/otp_inputput_widget.dart';
import 'package:tamini_app/pages/sign_up_new_user_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({
    Key? key,
  }) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  createNewUserFromMobile(BuildContext context, String phoneNumber) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('enter_otp'.i18n()), // Use the i18n() method to get the translated string
          content: OtpInputWidget(
            onOtpEntered: (otp) {
              // Handle the OTP verification logic here
              if (kDebugMode) {
                // If OTP is correct, navigate to the LoginPage
                Navigator.of(context).pop(); // Close the OTP dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpNewUserPage()),
                );
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
