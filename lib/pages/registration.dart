import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/common/user_service.dart';
import 'package:tamini_app/common/util.dart';
import 'package:tamini_app/components/constants.dart';
import 'package:tamini_app/components/custom_button.dart';
import 'package:tamini_app/components/custom_text_field.dart';
import 'package:tamini_app/components/language_dropdown.dart';

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
        automaticallyImplyLeading: false,
        title: Center(child: Text('Login by Phone Number'.i18n())),
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
                const LanguageDropdown(),
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
          ],
        ),
      ),
    );
  }
}
