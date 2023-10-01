// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: AboutAndSetting(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:tamini_app/pages/about_and_setting.dart.dart';
import 'package:tamini_app/pages/edit_profile_page.dart.dart';
import 'package:tamini_app/pages/homepage.dart';
import 'package:tamini_app/pages/refund_request_page.dart.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Default is '/'
      routes: {
        '/': (context) => const MyHomePage(),
        '/aboutAndSetting': (context) => const AboutAndSetting(),
        '/editProfile': (context) => EditProfilePage(),
        '/refundRequest': (context) => const RefundRequestPage()
        // Add more routes as needed
      },
    );
  }
}
