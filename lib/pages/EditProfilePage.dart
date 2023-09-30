import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tamini_app/provider/provider.dart';

class EditProfilePage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    nameController.text = userProvider.name ?? '';
    emailController.text = userProvider.email ?? '';
    phoneController.text = userProvider.phoneNumber ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            ElevatedButton(
              onPressed: () {
                // Validate inputs and update user profile
                userProvider.updateUserProfile(
                  nameController.text,
                  emailController.text,
                  phoneController.text,
                );
              },
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
