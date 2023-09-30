// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAndSetting extends StatelessWidget {
  const AboutAndSetting({Key? key}) : super(key: key);

  // Function to launch URL
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Metadata
            const Text(
              'App Version: 1.0.0',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              'Build Number: 1',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // External Links
            TextButton(
              onPressed: () => _launchURL('https://www.Privacy.com'),
              child: const Text(
                'Privacy Policy',
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
            TextButton(
              onPressed: () => _launchURL('https://www.terms.com'),
              child: const Text(
                'Terms of Service',
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 20),

            // Production Support
            const Text(
              'For support, contact us at:',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              'Email: support@tamini.com',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              'Phone: +1234567890',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
