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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
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
                request: widget.request,
              ),
              widget.request.status == QuotationStatus.pending.name
                  ? const SizedBox()
                  : Column(
                      children: [
                        const Divider(),
                        DecoratedRowCard(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              QuotationCardItem(
                                itemDescription: "insurance_amount".i18n(),
                                itemValue: widget.request.insuranceAmount.toString(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
              widget.request.status == QuotationStatus.pending.name
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomButton(
                              buttonText: '',
                              isText: false,
                              onPressed: () async {
                                await quotationService.updateQuotation(context, widget.request.requestId,
                                    {'status': QuotationStatus.approved.name}, QuotationStatus.approved.name);
                              },
                              child: const Icon(Icons.done),
                            ),
                            DecoratedRowCard(
                              child: QuotationCardItem(
                                itemDescription: "insurance_amount".i18n(),
                                itemValue: widget.request.insuranceAmount.toString(),
                              ),
                            ),
                            CustomButton(
                              buttonText: '',
                              isText: false,
                              onPressed: () async {
                                await quotationService.updateQuotation(context, widget.request.requestId,
                                    {'status': QuotationStatus.reject.name}, QuotationStatus.reject.name);
                              },
                              child: const Icon(
                                Icons.cancel,
                                size: 25,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}

class DecoratedRowCard extends StatelessWidget {
  const DecoratedRowCard({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
