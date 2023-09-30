import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:tamini_app/CustomComponents/custom_button.dart';

class OtpInputWidget extends StatefulWidget {
  final Function(String) onOtpEntered;

  const OtpInputWidget({super.key, required this.onOtpEntered});

  @override
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
          controller: otpController,
          pinLength: 4,
          decoration: UnderlineDecoration(
            colorBuilder: PinListenColorBuilder(
              const Color.fromARGB(246, 0, 95, 150),
              const Color.fromARGB(246, 0, 95, 150),
            ),
          ),
          autoFocus: true,
          textInputAction: TextInputAction.done,
          onSubmit: (pin) {
            widget.onOtpEntered(pin);
          },
        ),
        const SizedBox(
          height: 8,
        ),
        CustomButton(
          onPressed: () {
            String otp = otpController.text;
            widget.onOtpEntered(otp);
          },
          buttonText: "تحقق",
        )
      ],
    );
  }
}
