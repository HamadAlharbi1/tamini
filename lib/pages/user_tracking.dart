import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/common/enum.dart';
import 'package:tamini_app/common/quotation_service.dart';
import 'package:tamini_app/common/refund_service.dart';
import 'package:tamini_app/components/quotations/quotation_card.dart';
import 'package:tamini_app/components/quotations/quotations_model.dart';
import 'package:tamini_app/components/refunds/refund_card.dart';
import 'package:tamini_app/components/refunds/refunds_model.dart';

class UserTracking extends StatefulWidget {
  const UserTracking({Key? key}) : super(key: key);

  @override
  State<UserTracking> createState() => _UserTrackingState();
}

class _UserTrackingState extends State<UserTracking> with SingleTickerProviderStateMixin {
  QuotationService quotationService = QuotationService();
  RefundService refundService = RefundService();
  StreamSubscription? userQuotationsListener;
  StreamSubscription? userRefundsListener;
  List<Quotations> userQuotations = [];
  List<Refunds> userRefunds = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? uid;
  late TabController _tabController;

  @override
  void initState() {
    User? user = _auth.currentUser;
    uid = user?.uid;
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    userQuotationsListener = quotationService.listenToUserQuotations(uid, (quotations) {
      setState(() {
        userQuotations = quotations;
      });
    });
    userRefundsListener = refundService.listenToUserRefunds(uid, (refunds) {
      setState(() {
        userRefunds = refunds;
      });
    });
  }

  @override
  void dispose() {
    userQuotationsListener?.cancel();
    userRefundsListener?.cancel();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tracking_Requests'.i18n()), // Use the i18n() method to get the translated string
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
                child: Text(
              'Quotations'.i18n(),
            )),
            Tab(
              child: Text(
                'Refunds'.i18n(),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView(
            children: [for (var request in userQuotations) QuotationCard(request: request)],
          ),
          ListView(
            children: [for (var request in userRefunds) RefundCard(userType: UserType.user.name, request: request)],
          ),
        ],
      ),
    );
  }
}
