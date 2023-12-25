import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/common/enum.dart';
import 'package:tamini_app/common/user_service.dart';
import 'package:tamini_app/components/decorated_row_card.dart';
import 'package:tamini_app/components/quotations/quotation_card_item.dart';
import 'package:tamini_app/components/refunds/refund_more_details.dart';
import 'package:tamini_app/components/refunds/refunds_model.dart';
import 'package:tamini_app/components/refunds/update_refund_status.dart';

class RefundCard extends StatefulWidget {
  final Refunds request;
  final String userType;
  const RefundCard({required this.userType, required this.request, Key? key}) : super(key: key);

  @override
  State<RefundCard> createState() => _RefundCardState();
}

class _RefundCardState extends State<RefundCard> {
  final UserService userService = UserService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String uid = "";

  @override
  void initState() {
    super.initState();
    User? user = _auth.currentUser;
    uid = user!.uid;
  }

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
                    widget.userType == UserType.user.name
                        ? const SizedBox()
                        : UpdateRefundStatus(
                            requestId: widget.request.requestId,
                          )
                  ],
                ),
              ),
              const Divider(),
              RefundMoreDetails(
                // show more details widget
                request: widget.request,
              )
            ],
          ),
        ),
      ),
    );
  }
}
