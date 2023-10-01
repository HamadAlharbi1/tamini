import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tamini_app/pages/EditProfilePage.dart';
import 'package:tamini_app/provider/provider.dart';

class RefundRequestPage extends StatefulWidget {
  const RefundRequestPage({super.key});

  @override
  _RefundRequestPageState createState() => _RefundRequestPageState();
}

class _RefundRequestPageState extends State<RefundRequestPage> {
  final TextEditingController _reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _reasonController,
              decoration: const InputDecoration(
                labelText: 'Reason for refund',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Check if the user is eligible for a refund
                if (await userProvider.isEligibleForRefund) {
                  // Implement the refund logic here
                  await userProvider.requestRefund(_reasonController.text);
                  // navigate to a "Thank You" or "Confirmation" page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()), // Or navigate to a "Thank Yuo" page
                  );
                } else {
                  // show a message not eligible for a refund
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('You are not eligible for a refund.')),
                  );
                }
              },
              child: const Text('Request Refund'),
            ),
          ],
        ),
      ),
    );
  }
}
