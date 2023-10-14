import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/common/enum.dart';
import 'package:tamini_app/common/quotation_service.dart';
import 'package:tamini_app/components/custom_button.dart';
import 'package:tamini_app/components/custom_text_field.dart';
import 'package:tamini_app/components/quotations/quotation_card.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QuotationData(
                request: request,
              ),
              request.status == QuotationStatus.pending.name || request.status == QuotationStatus.newRequest.name
                  ? Column(
                      children: [
                        const Divider(),
                        Tcard(
                          child: UpdateQuotationCardItem(
                            requestId: request.requestId,
                            itemDescription: "insurance_amount".i18n(),
                            itemValue: request.insuranceAmount.toString(),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        const Divider(),
                        Tcard(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              QuotationCardItem(
                                itemDescription: "insurance_amount".i18n(),
                                itemValue: request.insuranceAmount.toString(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
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
                    {"insuranceAmount": double.parse(itemValueController.text), 'status': QuotationStatus.pending.name},
                    QuotationStatus.pending.name)
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
