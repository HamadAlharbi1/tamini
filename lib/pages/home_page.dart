import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/components/home_page_actions_container.dart';
import 'package:tamini_app/pages/request_quotations_page.dart';
import 'package:tamini_app/pages/request_refund.dart';
import 'package:tamini_app/pages/tracking_requests.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home_Page'.i18n()), // Use the i18n() method to get the translated string
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomePageActionsContainer(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const RequestQuotations()));
                },
                text: "Request_Quotations".i18n()),
            HomePageActionsContainer(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const RequestRefund()));
                },
                text: "Request_Refund".i18n()),
            HomePageActionsContainer(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const TrackingRequests()));
                },
                text: "Tracking_Requests".i18n()),
          ],
        ),
      ),
    );
  }
}
