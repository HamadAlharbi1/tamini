import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/common/enum.dart';
import 'package:tamini_app/common/quotation_service.dart';

class UpdateQuotationStatus extends StatefulWidget {
  final String requestId;
  const UpdateQuotationStatus({super.key, required this.requestId});
  @override
  State<UpdateQuotationStatus> createState() => _UpdateQuotationStatusState();
}

class _UpdateQuotationStatusState extends State<UpdateQuotationStatus> {
  final QuotationService quotationService = QuotationService();
  Future<void> _handleMenuItemSelected(BuildContext context, QuotationStatus status) async {
    // Construct update map with new status
    final updates = {'status': status.name};
    // Call updateRefund method
    await quotationService.updateQuotation(
        context, widget.requestId, updates, '${'Status updated to :'.i18n()}${status.name.i18n()}');
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<QuotationStatus>(
      onSelected: (status) => _handleMenuItemSelected(context, status),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: QuotationStatus.pending,
          child: Text('pending'.i18n()),
        ),
        PopupMenuItem(
          value: QuotationStatus.rejected,
          child: Text('RequestRejected'.i18n()),
        ),
        PopupMenuItem(
          value: QuotationStatus.approved,
          child: Text('approved'.i18n()),
        ),
        PopupMenuItem(
          value: QuotationStatus.newRequest,
          child: Text('newRequest'.i18n()),
        ),
      ],
    );
  }
}
