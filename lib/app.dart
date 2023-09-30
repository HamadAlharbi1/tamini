import 'package:flutter/material.dart';
import 'package:tamini_app/pages/EditProfilePage.dart';
import 'package:tamini_app/pages/RefundRequestPage.dart';
import 'package:tamini_app/pages/aboutAndSetting.dart';
import 'package:tamini_app/pages/homepage.dart';

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
