import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tamini_app/pages/EditProfilePage.dart';
import 'package:tamini_app/provider/provider.dart';
// import 'package:tamini_app/pages/RegisterPage.dart'; // Import your RegisterPage

class RefundRequestPage extends StatelessWidget {
  const RefundRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    // Check if the user is registered/logged in
    if (userProvider.user == null) {
      // If not registered, navigate to RegisterPage
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => EditProfilePage()), // Replace with your RegisterPage
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Request for Refund'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Implement your refund logic here
          },
          child: const Text('Request Refund'),
        ),
      ),
    );
  }
}
