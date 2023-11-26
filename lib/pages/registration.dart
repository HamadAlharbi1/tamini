import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/common/user_service.dart';
import 'package:tamini_app/common/util.dart';
import 'package:tamini_app/components/constants.dart';
import 'package:tamini_app/components/custom_button.dart';
import 'package:tamini_app/components/custom_text_field.dart';
import 'package:tamini_app/components/language_changer.dart';

class Registration extends StatefulWidget {
  const Registration({
    Key? key,
  }) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  final UserService userService = UserService();
  bool? _prevIsEnglish;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bool isEnglish = Localizations.localeOf(context).languageCode == 'en';
    if (_prevIsEnglish != null && _prevIsEnglish != isEnglish) {
      setState(() {});
    }
    _prevIsEnglish = isEnglish;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LanguageChanger(),
          ],
        ),
        automaticallyImplyLeading: false,
        title: Center(child: Text('Login by Phone Number'.i18n())),
      ),
      body: Center(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 7,
                  ),
                  Container(
                    width: 200,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                    ),
                    margin: const EdgeInsets.all(0),
                    child: Image.asset(Constants.appLogoUrl),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Welcome'.i18n(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                    onPressed: () async {
                      try {
                        await userService.createNewUserFromMobile(context, phoneNumberController.text);
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        displayError(context, e);
                      }
                    },
                    buttonText: 'continue'.i18n(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
