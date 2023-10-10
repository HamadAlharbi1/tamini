import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/common/enum.dart';
import 'package:tamini_app/common/error_messages.dart';
import 'package:tamini_app/components/custom_text_field.dart';
import 'package:tamini_app/components/user_model.dart';
import 'package:tamini_app/components/user_service.dart';

class ProfilePage extends StatefulWidget {
  final String userId;

  const ProfilePage({super.key, required this.userId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserService _userService = UserService();
  late Future<UserData> _futureUser;

  @override
  void initState() {
    super.initState();
    _futureUser = _userService.getUser(widget.userId);
  }

  final UserService userService = UserService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile_Page'.i18n()),
      ),
      body: FutureBuilder<UserData>(
        future: _futureUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            UserData user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      height: 150,
                      width: 150,
                      child: Image.network(user.profilePictureUrl)),
                  Text('${"user_name".i18n()}: ${user.userName}'),
                  Text('${"email".i18n()}: ${user.email}'),
                  Text('${"phone_number".i18n()}: ${user.phoneNumber}'),
                  user.userType == UserType.user.toString()
                      ? const SizedBox()
                      : Text('${"user_type".i18n()}: ${user.userType.i18n()}'),
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
                                  await _userService.updateUser(user);
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('Update_User'.i18n()),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      TextEditingController phoneNumberController = TextEditingController();

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('update_phone_number'.i18n()),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: [
                                  CustomTextField(
                                    controller: phoneNumberController,
                                    labelText: "phone_number".i18n(),
                                    hintText: "enter_phone_number".i18n(),
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
                                child: Text('update_phone_number'.i18n()),
                                onPressed: () async {
                                  try {
                                    await userService.updatePhoneNumber(
                                      context,
                                      phoneNumberController.text,
                                    );
                                    user.phoneNumber = phoneNumberController.text;
                                    await _userService.updateUser(user);
                                  } catch (e) {
                                    // ignore: use_build_context_synchronously
                                    ErrorMessages.displayError(context, e);
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('update_phone_number'.i18n()),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _userService.deleteUser(user.userId);
                    },
                    child: Text('Delete_User'.i18n()),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
