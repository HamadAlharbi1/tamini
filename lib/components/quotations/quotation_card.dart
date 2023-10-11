import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/common/enum.dart';
import 'package:tamini_app/common/quotation_service.dart';
import 'package:tamini_app/components/custom_button.dart';
import 'package:tamini_app/components/quotations/quotation_card_item.dart';
import 'package:tamini_app/components/quotations/quotation_data.dart';
import 'package:tamini_app/components/quotations/quotations_model.dart';

class QuotationCard extends StatefulWidget {
  const QuotationCard({
    Key? key,
    required this.request,
  }) : super(key: key);

  final Quotations request;

  @override
  State<QuotationCard> createState() => _QuotationCardState();
}

class _QuotationCardState extends State<QuotationCard> {
  QuotationService quotationService = QuotationService();

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
            request: widget.request,
          ),
          QuotationCardItem(
            itemDescription: "insurance_amount".i18n(),
            itemValue: widget.request.insuranceAmount.toString(),
          ),
          widget.request.status == RequestStatus.pending.name
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomButton(
                      buttonText: '',
                      isText: false,
                      onPressed: () async {
                        await quotationService.updateQuotation(context, widget.request.requestId,
                            {'status': RequestStatus.approved.name}, RequestStatus.approved.name);
                      },
                      child: const Icon(Icons.done),
                    ),
                    CustomButton(
                      buttonText: '',
                      isText: false,
                      onPressed: () async {
                        await quotationService.updateQuotation(context, widget.request.requestId,
                            {'status': RequestStatus.reject.name}, RequestStatus.reject.name);
                      },
                      child: const Text('X'),
                    ),
                  ],
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
