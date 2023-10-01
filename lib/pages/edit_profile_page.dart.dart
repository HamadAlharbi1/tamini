import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tamini_app/provider/provider.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    nameController.text = userProvider.name ?? '';
    emailController.text = userProvider.email ?? '';
    phoneController.text = userProvider.phoneNumber ?? '';

    //final TextEditingController nameController = TextEditingController(text: userProvider.name ?? '');
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
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
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
