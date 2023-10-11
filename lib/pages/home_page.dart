import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/common/enum.dart';
import 'package:tamini_app/common/user_service.dart';
import 'package:tamini_app/components/home_page_actions_container.dart';
import 'package:tamini_app/components/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserService userService = UserService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String uid = "";

  @override
  void initState() {
    super.initState();
    User? user = _auth.currentUser;
    uid = user!.uid;
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserData>(
      future: userService.getUser(uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          UserData user = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              actions: [
                InkWell(
                  onTap: () {
                    signOut();
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
                  user.userType == UserType.owner.name
                      ? HomePageActionsContainer(
                          onPressed: () {
                            context.go('/owner_tracking_requests');
                          },
                          text: "${'Tracking_Requests'.i18n()} ${'owner'.i18n()}")
                      : const SizedBox(),
                  HomePageActionsContainer(
                      onPressed: () {
                        context.go('/profile');
                      },
                      text: "${'الملف الشخصي'.i18n()} ${''.i18n()}"),
                  // Add more HomePageActionsContainer here based on user features
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
