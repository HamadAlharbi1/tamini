import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/components/custom_button.dart';
import 'package:tamini_app/components/custom_text_field.dart';

class SignUpNewUserPage extends StatefulWidget {
  const SignUpNewUserPage({Key? key}) : super(key: key);

  @override
  State<SignUpNewUserPage> createState() => _SignUpNewUserPageState();
}

class _SignUpNewUserPageState extends State<SignUpNewUserPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sign_up_new_user'.i18n()), // Use the i18n() method to get the translated string
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomTextField(
                controller: userNameController,
                labelText: 'user_name'.i18n(),
                hintText: 'enter_user_name'.i18n(),
                keyboardType: TextInputType.phone,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomTextField(
                controller: emailController,
                labelText: 'email'.i18n(),
                hintText: 'enter_email'.i18n(),
                keyboardType: TextInputType.phone,
              ),
            ),
            CustomButton(
              onPressed: () {},
              buttonText: 'register'.i18n(),
            ),
          ],
        ),
      ),
    );
  }
}
