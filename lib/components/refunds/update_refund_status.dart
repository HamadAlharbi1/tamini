import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/common/enum.dart';
import 'package:tamini_app/common/refund_service.dart';

class UpdateRefundStatus extends StatefulWidget {
  final String requestId;
  const UpdateRefundStatus({super.key, required this.requestId});
  @override
  State<UpdateRefundStatus> createState() => _UpdateRefundStatusState();
}

class _UpdateRefundStatusState extends State<UpdateRefundStatus> {
  final RefundService refundService = RefundService();
  Future<void> _handleMenuItemSelected(BuildContext context, RefundStatus status) async {
    // Construct update map with new status
    final updates = {'status': status.name};
    // Call updateRefund method
    await refundService.updateRefund(
        context, widget.requestId, updates, '${'Status updated to :'.i18n()}${status.name.i18n()}');
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<RefundStatus>(
      onSelected: (status) => _handleMenuItemSelected(context, status),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: RefundStatus.inProgress,
          child: Text('In_Progress'.i18n()),
        ),
        PopupMenuItem(
          value: RefundStatus.pending,
          child: Text('pending'.i18n()),
        ),
        PopupMenuItem(
          value: RefundStatus.approved,
          child: Text('approved'.i18n()),
        ),
        PopupMenuItem(
          value: RefundStatus.rejected,
          child: Text('rejected'.i18n()),
        ),
        PopupMenuItem(
          value: RefundStatus.docsNotAccepted,
          child: Text('docsNotAccepted'.i18n()),
        ),
      ],
    );
  }
}
