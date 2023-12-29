import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:tamini_app/common/enum.dart';
import 'package:tamini_app/common/user_service.dart';
import 'package:tamini_app/common/util.dart';
import 'package:tamini_app/components/user_model.dart';
import 'package:tamini_app/pages/owner_tracking.dart';
import 'package:tamini_app/pages/profile.dart';
import 'package:tamini_app/pages/request_quotations.dart';
import 'package:tamini_app/pages/request_refund.dart';
import 'package:tamini_app/pages/user_tracking.dart';
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
  int currentIndex = 0; // Add this line to keep track of the selected tab index
  UserData? _userData;
  @override
  void initState() {
    User? user = _auth.currentUser;
    uid = user!.uid;
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    User user = _auth.currentUser!;
    String uid = user.uid;
    UserData userData = await userService.getUserData(uid);
    setState(() {
      _userData = userData;
    });
  }

  void onTabTapped(int index) {
    // Add this method to handle tab tap
    setState(() {
      currentIndex = index;
    });
  }

  final List<Widget> userPages = [
    const RequestQuotations(),
    const RequestRefund(),
    const UserTracking(),
    const ProfilePage(),
  ];
  final List<Widget> ownerPages = [
    const OwnerTracking(),
    const RequestRefund(),
    const RequestQuotations(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    Provider.of<LanguageProvider>(context); // this is added since the language could changes on profile_page
    if (_userData == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    UserData user = _userData!;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        floatingActionButton: user.userType == UserType.user.name && currentIndex == 0
            ? FloatingActionButton(
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
              )
            : null,
        body: user.userType == UserType.user.name
            ? userPages.elementAt(currentIndex)
            : ownerPages.elementAt(currentIndex), // This will display the page based on the user type and current index
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          currentIndex: currentIndex, // This will highlight the selected tab
          onTap: onTabTapped,
          items: [
            user.userType == UserType.user.name
                ? BottomNavigationBarItem(icon: const Icon(Icons.add_moderator), label: 'quotation'.i18n())
                : BottomNavigationBarItem(icon: const Icon(Icons.assignment), label: "owner_tracking".i18n()),
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.rotate_left,
                  size: 30,
                ),
                label: 'refund'.i18n()),
            user.userType == UserType.user.name
                ? BottomNavigationBarItem(icon: const Icon(Icons.assignment), label: "Tracking_Requests".i18n())
                : BottomNavigationBarItem(icon: const Icon(Icons.add_moderator), label: 'quotation'.i18n()),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: "profile_page".i18n(),
            ),
          ],
        ),
      ),
    );
  }
}
