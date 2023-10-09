import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/common/enum.dart';
import 'package:tamini_app/common/quotation_service.dart';
import 'package:tamini_app/components/custom_button.dart';
import 'package:tamini_app/components/custom_text_field.dart';
import 'package:tamini_app/components/quotations/quotation_card_item.dart';
import 'package:tamini_app/components/quotations/quotation_data.dart';
import 'package:tamini_app/components/quotations/quotations_model.dart';

class UpdateQuotationCard extends StatelessWidget {
  const UpdateQuotationCard({
    Key? key,
    required this.request,
  }) : super(key: key);

  final Quotations request;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration:
          BoxDecoration(color: const Color.fromARGB(255, 221, 221, 221), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuotationData(
            request: request,
          ),
          request.status == RequestStatus.pending.toString() || request.status == RequestStatus.newRequest.toString()
              ? UpdateQuotationCardItem(
                  requestId: request.requestId,
                  itemDescription: "insurance_amount".i18n(),
                  itemValue: request.insuranceAmount.toString(),
                )
              : QuotationCardItem(
                  itemDescription: "insurance_amount".i18n(),
                  itemValue: request.insuranceAmount.toString(),
                ),
        ],
      ),
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

  QuotationService quotationService = QuotationService();
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
        CustomButton(
          borderRadius: 4,
          vertical: 8,
          buttonText: '',
          isText: false,
          child: Icon(
            isEdit ? Icons.done : Icons.edit,
            size: isEdit ? 30 : 20,
          ),
          onPressed: () async {
            isEdit
                ? await quotationService.updateQuotation(
                    context,
                    widget.requestId,
                    {
                      "insuranceAmount": double.parse(itemValueController.text),
                      'status': RequestStatus.pending.toString()
                    },
                    RequestStatus.pending.toString())
                : null;
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
