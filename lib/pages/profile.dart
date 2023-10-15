// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:tamini_app/app.dart';
import 'package:tamini_app/common/enum.dart';
import 'package:tamini_app/common/pic_image.dart';
import 'package:tamini_app/common/user_service.dart';
import 'package:tamini_app/common/util.dart';
import 'package:tamini_app/components/constants.dart';
import 'package:tamini_app/components/custom_text_field.dart';
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

  @override
  void initState() {
    super.initState();
    User? user = _auth.currentUser;
    uid = user!.uid;
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<LanguageProvider>();
    String fixNumber(String number) {
      if (number.startsWith("+966")) {
        return number.replaceFirst("+966", "0");
      }
      return number;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile_Page'.i18n()),
        actions: <Widget>[
          DropdownButton<String>(
            value: languageProvider.currentLocale.languageCode,
            items: <String>['en', 'ar'].map((String value) {
              String displayText = (value == 'en') ? 'English' : 'العربية';
              return DropdownMenuItem<String>(
                value: value,
                child: Text(displayText),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                Locale newLocale;
                if (newValue == 'en') {
                  newLocale = const Locale('en', 'US');
                } else if (newValue == 'ar') {
                  newLocale = const Locale('ar', 'SA');
                } else {
                  newLocale = const Locale('en', 'US'); // default to English if something goes wrong
                }
                languageProvider.changeLanguage(newLocale);
              });
            },
          ),
        ],
      ),
      body: StreamBuilder<UserData>(
        stream: userService.streamUserData(uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            UserData user = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.scaleDown,
                      image: Image.network(
                        user.profilePictureUrl.isEmpty ? Constants.profileAvatarUrl : user.profilePictureUrl,
                      ).image,
                    ),
                  ),
                ),
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
                ElevatedButton(
                  onPressed: () async {
                    String? imageUrl = await uploadImage.selectAndUploadImage(context, 'profile_images', uid);
                    if (imageUrl.isNotEmpty) {
                      user.profilePictureUrl = imageUrl;
                      await userService.updateUser(context, user);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: Text('Update_Profile_Picture'.i18n()),
                ),
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
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: Text('Update_User'.i18n()),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    TextEditingController phoneNumberController = TextEditingController();

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('update_phone_number'.i18n(), style: Theme.of(context).textTheme.titleLarge),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                CustomTextField(
                                  controller: phoneNumberController,
                                  labelText: "phone_number".i18n(),
                                  hintText: "enter_phone_number".i18n(),
                                  keyboardType: TextInputType.phone,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                              child: Text('update_phone_number'.i18n()),
                              onPressed: () async {
                                try {
                                  await userService.updatePhoneNumber(context, phoneNumberController.text, user);
                                } catch (e) {
                                  displayError(context, e);
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: Text('update_phone_number'.i18n()),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    await userService.deleteUser(context, uid);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: Text('Delete_User'.i18n()),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
