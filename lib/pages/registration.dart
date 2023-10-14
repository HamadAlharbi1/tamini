import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:tamini_app/app.dart';
import 'package:tamini_app/common/error_messages.dart';
import 'package:tamini_app/common/user_service.dart';
import 'package:tamini_app/components/constants.dart';
import 'package:tamini_app/components/custom_button.dart';
import 'package:tamini_app/components/custom_text_field.dart';

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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<LanguageProvider>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                  child: Image.network(Constants.appLogoUrl),
                ),
                const SizedBox(
                  height: 80,
                ),
                DropdownButton<String>(
                  value: languageProvider.currentLocale.languageCode,
                  items: <String>['en', 'ar'].map((String value) {
                    String displayText = (value == 'en') ? 'English' : 'العربية';
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(displayText),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      Locale newLocale;
                      if (newValue == 'en') {
                        newLocale = const Locale('en', 'US');
                      } else if (newValue == 'ar') {
                        newLocale = const Locale('ar', 'SA');
                      } else {
                        newLocale = const Locale('en', 'US');
                      }
                      languageProvider.changeLanguage(newLocale);
                    });
                  },
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
                      ErrorMessages.displayError(context, e);
                    }
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
