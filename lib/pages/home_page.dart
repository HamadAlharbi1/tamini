import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:tamini_app/common/enum.dart';
import 'package:tamini_app/common/user_service.dart';
import 'package:tamini_app/common/util.dart';
import 'package:tamini_app/components/home_page_actions_container.dart';
import 'package:tamini_app/components/user_model.dart';
import 'package:tamini_app/provider/language_provider.dart';

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

  @override
  Widget build(BuildContext context) {
    Provider.of<LanguageProvider>(context); // this is added since the language could changes on profile_page
    return StreamBuilder<UserData>(
      stream: userService.streamUserData(uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          UserData user = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout_outlined, size: 26),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    // ignore: use_build_context_synchronously
                    context.go('/registration');
                  },
                ),
              ],
              title: Text('Home_Page'.i18n()), // Use the i18n() method to get the translated string
            ),
            body: Center(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  HomePageActionsContainer(
                      onPressed: () {
                        context.go('/request_quotations');
                      },
                      text: "Request_Quotations".i18n()),
                  const SizedBox(height: 16),
                  HomePageActionsContainer(
                      onPressed: () {
                        context.go('/request_refund');
                      },
                      text: "Request_Refund".i18n()),
                  user.userType == UserType.owner.name ? const SizedBox() : const SizedBox(height: 16),
                  user.userType == UserType.owner.name
                      ? const SizedBox()
                      : HomePageActionsContainer(
                          onPressed: () {
                            context.go('/user_tracking');
                          },
                          text: 'Tracking_Requests'.i18n()),
                  user.userType == UserType.owner.name ? const SizedBox(height: 16) : const SizedBox(),
                  user.userType == UserType.owner.name
                      ? HomePageActionsContainer(
                          onPressed: () {
                            context.go('/owner_tracking');
                          },
                          text: "${'Tracking_Requests'.i18n()} ${'for_owner'.i18n()}")
                      : const SizedBox(),
                  const SizedBox(height: 16),
                  HomePageActionsContainer(
                      onPressed: () {
                        context.go('/profile');
                      },
                      text: "${'profile_page'.i18n()} ${''.i18n()}"),
                ],
              ),
            ),
            floatingActionButton: user.userType == UserType.owner.name
                ? null
                : FloatingActionButton(
                    onPressed: () {
                      launchWhatsAppString();
                    },
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255), borderRadius: BorderRadius.circular(12)),
                      child: Image.asset(
                        'assets/whatsapp.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
          );
        }
      },
    );
  }
}
