import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/components/custom_button.dart';
import 'package:tamini_app/components/custom_text_field.dart';

class QuotationCardItem extends StatelessWidget {
  const QuotationCardItem({
    super.key,
    required this.itemDescription,
    required this.itemValue,
  });

  final String itemValue;
  final String itemDescription;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          itemDescription,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          itemValue,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class UpdateQuotationCardItem extends StatefulWidget {
  const UpdateQuotationCardItem({
    super.key,
    required this.itemDescription,
    required this.itemValue,
    required this.requestId,
  });
  final String requestId;
  final String itemValue;
  final String itemDescription;

  @override
  State<UpdateQuotationCardItem> createState() => _UpdateQuotationCardItemState();
}

class _UpdateQuotationCardItemState extends State<UpdateQuotationCardItem> {
  @override
  void initState() {
    super.initState();
    itemValueController.text = widget.itemValue;
  }

  update(context) async {
    try {
      await FirebaseFirestore.instance.collection('quotations').doc(widget.requestId).update(
        {"insuranceAmount": double.parse(itemValueController.text), 'status': "sent_awaiting_approval".i18n()},
      );
      await showRequestUpdatedSnackbar();
    } catch (e) {
      errorShow(e);
    }
  }

  Future<void> showRequestUpdatedSnackbar() async {
    final snackBar = SnackBar(
      content: Text('request_updated'.i18n()),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> errorShow(dynamic e) async {
    final snackBar = SnackBar(
      content: Text('error:$e'.i18n()),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  TextEditingController itemValueController = TextEditingController();
  bool isEdit = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.itemDescription,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        isEdit
            ? CustomButton(
                borderRadius: 4,
                vertical: 8,
                buttonText: '',
                isText: false,
                child: const Icon(
                  Icons.done,
                  size: 30,
                ),
                onPressed: () async {
                  await update(context);
                  setState(() {
                    isEdit = !isEdit;
                  });
                },
              )
            : CustomButton(
                borderRadius: 4,
                vertical: 8,
                buttonText: '',
                isText: false,
                child: const Icon(
                  Icons.edit,
                ),
                onPressed: () {
                  setState(() {
                    isEdit = !isEdit;
                  });
                },
              ),
        isEdit
            ? SizedBox(
                width: 90,
                child: CustomTextField(
                  controller: itemValueController,
                  labelText: '',
                  hintText: '',
                  keyboardType: TextInputType.number,
                ),
              )
            : Text(
                widget.itemValue,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ],
    );
  }
}
