import 'package:flutter/material.dart';
import 'package:tamini_app/pages/aboutAndSetting.dart';
import 'package:tamini_app/pages/homepage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AboutAndSetting(),
    );
  }
}
