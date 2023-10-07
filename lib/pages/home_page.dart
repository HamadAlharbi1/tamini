import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/components/home_page_actions_container.dart';

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
              context.go('/registration');
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
                  context.go('/request_quotations');
                },
                text: "Request_Quotations".i18n()),
            HomePageActionsContainer(
                onPressed: () {
                  context.go('/request_refund');
                },
                text: "Request_Refund".i18n()),
            HomePageActionsContainer(
                onPressed: () {
                  context.go('/user_tracking_requests');
                },
                text: "${'Tracking_Requests'.i18n()} ${'user'.i18n()}"),
            HomePageActionsContainer(
                onPressed: () {
                  context.go('/owner_tracking_requests');
                },
                text: "${'Tracking_Requests'.i18n()} ${'owner'.i18n()}"),
          ],
        ),
      ),
    );
  }
}
