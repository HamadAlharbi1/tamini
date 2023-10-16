import 'dart:async';

import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:tamini_app/components/custom_button.dart';

class OtpInputWidget extends StatefulWidget {
  final Function(String) onOtpEntered;

  const OtpInputWidget({Key? key, required this.onOtpEntered}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OtpInputWidgetState createState() => _OtpInputWidgetState();
}

class _OtpInputWidgetState extends State<OtpInputWidget> {
  TextEditingController otpController = TextEditingController();
  int timerSeconds = 60;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (timerSeconds > 0) {
          timerSeconds--;
        } else {
          timer.cancel();
          _showTimeOutDialog();
        }
      });
    });
  }

  void _showTimeOutDialog() {
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("time_out".i18n()),
          content: Text("time_out_massage".i18n()),
          actions: <Widget>[
            TextButton(
              child: Text("ok".i18n()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PinInputTextField(
          pinLength: 6,
          onChanged: (v) => otpController.text = v,
          onSubmit: (v) => otpController.text = v,
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
          height: 4,
        ),
        Text(
          '$timerSeconds',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 4,
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

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
