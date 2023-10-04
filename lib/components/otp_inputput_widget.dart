import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:tamini_app/components/custom_button.dart';

class OtpInputWidget extends StatefulWidget {
  final Function(String) onOtpEntered;

  const OtpInputWidget({super.key, required this.onOtpEntered});

  @override
  // ignore: library_private_types_in_public_api
  _OtpInputWidgetState createState() => _OtpInputWidgetState();
}

class _OtpInputWidgetState extends State<OtpInputWidget> {
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PinInputTextField(
          pinLength: 6,
          decoration: BoxLooseDecoration(
            gapSpace: 2,
            strokeWidth: 1,
            strokeColorBuilder: const FixedColorBuilder(
              Color.fromARGB(255, 50, 122, 128),
            ),
            textStyle: const TextStyle(fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        CustomButton(
          onPressed: () {
            String otp = otpController.text;
            widget.onOtpEntered(otp);
          },
          buttonText: "verify".i18n(),
        )
      ],
    );
  }
}
