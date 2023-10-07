import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/components/home_page_actions_container.dart';
import 'package:tamini_app/pages/owner_tracking_requests.dart';
import 'package:tamini_app/pages/registration_page.dart';
import 'package:tamini_app/pages/request_quotations_page.dart';
import 'package:tamini_app/pages/request_refund.dart';
import 'package:tamini_app/pages/user_tracking_requests.dart';

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
        actions: [
          InkWell(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const RegistrationPage()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Icon(
                Icons.logout_outlined,
                size: 26,
              ),
            ),
          ),
        ],
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const UserTrackingRequests()));
                },
                text: "${'Tracking_Requests'.i18n()} ${'user'.i18n()}"),
            HomePageActionsContainer(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const OwnerTrackingRequests()));
                },
                text: "${'Tracking_Requests'.i18n()} ${'owner'.i18n()}"),
          ],
        ),
      ),
    );
  }
}
