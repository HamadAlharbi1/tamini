// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/common/user_service.dart';
import 'package:tamini_app/common/util.dart';
import 'package:tamini_app/components/custom_text_field.dart';
import 'package:tamini_app/components/user_model.dart';

class UpdatePhoneNumber extends StatelessWidget {
  const UpdatePhoneNumber({
    super.key,
    required this.userService,
    required this.user,
  });

  final UserService userService;
  final UserData user;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        TextEditingController phoneNumberController = TextEditingController();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('update_phone_number'.i18n(), style: Theme.of(context).textTheme.titleLarge),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    CustomTextField(
                      controller: phoneNumberController,
                      labelText: "phone_number".i18n(),
                      hintText: "enter_phone_number".i18n(),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  child: Text('update_phone_number'.i18n()),
                  onPressed: () async {
                    try {
                      await userService.updatePhoneNumber(context, phoneNumberController.text, user);
                    } catch (e) {
                      displayError(context, e);
                    }
                  },
                ),
              ],
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      ),
      child: Text('update_phone_number'.i18n()),
    );
  }
}
