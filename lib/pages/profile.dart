// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/common/enum.dart';
import 'package:tamini_app/common/pic_image.dart';
import 'package:tamini_app/common/user_service.dart';
import 'package:tamini_app/common/util.dart';
import 'package:tamini_app/components/constants.dart';
import 'package:tamini_app/components/custom_text_field.dart';
import 'package:tamini_app/components/language_changer.dart';
import 'package:tamini_app/components/theme_changer.dart';
import 'package:tamini_app/components/update_phone_number.dart';
import 'package:tamini_app/components/user_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserService userService = UserService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String uid = "";
  final UploadImage uploadImage = UploadImage();

  bool uploading = false;
  @override
  void initState() {
    super.initState();
    User? user = _auth.currentUser;
    uid = user!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserData>(
      stream: userService.streamUserData(uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          UserData user = snapshot.data!;
          return Scaffold(
              appBar: AppBar(
                title: Text('profile_page'.i18n()),
                actions: const <Widget>[
                  ThemeChanger(),
                  LanguageChanger(),
                ],
              ),
              body: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          String? imageUrl =
                              await uploadImage.selectAndUploadImage(context, 'profile_images', uid, (uploading) {
                            setState(() {
                              this.uploading = uploading;
                            });
                          });
                          if (imageUrl.isNotEmpty) {
                            user.profilePictureUrl = imageUrl;
                            await userService.updateUser(context, user);
                          }
                        },
                        child: uploading
                            ? const CircularProgressIndicator()
                            : Container(
                                width: 150,
                                height: 150,
                                clipBehavior: Clip.hardEdge,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: user.profilePictureUrl.isEmpty
                                    ? Image.asset(
                                        fit: BoxFit.cover,
                                        Constants.profileAvatarUrl,
                                      )
                                    : Image.network(
                                        fit: BoxFit.cover,
                                        user.profilePictureUrl,
                                        loadingBuilder:
                                            (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) return child;
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(2),
                                                child: CircularProgressIndicator(
                                                  value: loadingProgress.expectedTotalBytes != null
                                                      ? loadingProgress.cumulativeBytesLoaded /
                                                          loadingProgress.expectedTotalBytes!
                                                      : null,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.person, color: Theme.of(context).primaryColor),
                            title: Text(
                              user.userName,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          Divider(color: Theme.of(context).colorScheme.secondary),
                          ListTile(
                            leading: Icon(Icons.email, color: Theme.of(context).primaryColor),
                            title: Text(
                              user.email,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone, color: Theme.of(context).primaryColor),
                            title: Text(
                              fixNumber(user.phoneNumber),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          user.userType == UserType.user.name
                              ? const SizedBox()
                              : ListTile(
                                  leading: Icon(Icons.group, color: Theme.of(context).primaryColor),
                                  title: Text(user.userType.i18n(), style: Theme.of(context).textTheme.titleMedium),
                                ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      TextEditingController userNameController = TextEditingController(text: user.userName);
                      TextEditingController emailController = TextEditingController(text: user.email);
                      TextEditingController profilePictureUrlController =
                          TextEditingController(text: user.profilePictureUrl);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Update_User'.i18n()),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: [
                                  CustomTextField(
                                    controller: userNameController,
                                    labelText: "user_name".i18n(),
                                    hintText: "enter_user_name".i18n(),
                                    keyboardType: TextInputType.text,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  CustomTextField(
                                    controller: emailController,
                                    labelText: "email".i18n(),
                                    hintText: "enter_email".i18n(),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  UpdatePhoneNumber(userService: userService, user: user),
                                  const SizedBox(height: 10),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                child: Text('Update'.i18n()),
                                onPressed: () async {
                                  user.userName = userNameController.text;
                                  user.email = emailController.text;
                                  user.profilePictureUrl = profilePictureUrlController.text;
                                  await userService.updateUser(context, user);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    ),
                    child: Text('Update_User'.i18n()),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("signOut".i18n()),
                        const SizedBox(
                          width: 4,
                        ),
                        const Icon(Icons.logout_outlined, size: 26),
                      ],
                    ),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      context.go('/registration');
                    },
                  ),
                ],
              ));
        }
      },
    );
  }
}
