import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/common/enum.dart';
import 'package:tamini_app/common/quotation_service.dart';
import 'package:tamini_app/components/custom_button.dart';
import 'package:tamini_app/components/decorated_row_card.dart';
import 'package:tamini_app/components/quotations/quotation_more_details.dart';
import 'package:tamini_app/components/quotations/quotation_card_item.dart';
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
              DecoratedRowCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RequestCardItem(
                      itemDescription: "request_id".i18n(),
                      itemValue: widget.request.requestId,
                    ),
                    RequestCardItem(
                      itemDescription: "request_status".i18n(),
                      itemValue: widget.request.status.i18n(),
                    ),
                  ],
                ),
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
                              RequestCardItem(
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
                              child: RequestCardItem(
                                itemDescription: "insurance_amount".i18n(),
                                itemValue: widget.request.insuranceAmount.toString(),
                              ),
                            ),
                            CustomButton(
                              buttonText: '',
                              isText: false,
                              onPressed: () async {
                                await quotationService.updateQuotation(context, widget.request.requestId,
                                    {'status': QuotationStatus.rejected.name}, QuotationStatus.rejected.name);
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
                  : const SizedBox(),
              const Divider(),
              QuotationMoreDetails(
                request: widget.request,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
