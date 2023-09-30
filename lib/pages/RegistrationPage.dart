import 'package:flutter/material.dart';
import 'package:tamini_app/CustomComponents/custom_button.dart';
import 'package:tamini_app/CustomComponents/custom_textField.dart';
import 'package:tamini_app/CustomComponents/otp_inputput_widget.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({
    super.key,
  });

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
          title: const Text('ادخل الرمز المرسل الى جوالك'),
          content: OtpInputWidget(
            onOtpEntered: (otp) {
              // Handle the OTP verification logic here
              if (otp == '1234') {
                // If OTP is correct, navigate to the RegistrationPage
                Navigator.of(context).pop(); // Close the OTP dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegistrationPage()),
                );
              } else {
                // If OTP is incorrect, show an error message
                // You can add error handling logic here
                // For example, displaying an error message to the user
                print('Invalid OTP. Please try again.');
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
        backgroundColor: const Color.fromARGB(255, 0, 83, 109),
        title: const Center(child: Text('التسجيل برقم الجوال ')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomTextField(
                  controller: phoneNumberController,
                  labelText: 'رقم الجوال',
                  hintText: '...ادخل رقم الجوال',
                  keyboardType: TextInputType.phone,
                ),
              ),
            ),
            CustomButton(
              onPressed: () {
                createNewUserFromMobile(context, phoneNumberController.text);
              },
              buttonText: 'تسجيل ',
            ),
          ],
        ),
      ),
    );
  }
}
