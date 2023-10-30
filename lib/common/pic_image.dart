// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localization/localization.dart';
import 'package:tamini_app/common/util.dart';

class UploadImage {
  Future<Uint8List?> picImage(ImageSource source) async {
    final ImagePicker imagepicker = ImagePicker();
    XFile? file = await imagepicker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    }
    return null;
  }

  Future<String> selectAndUploadImage(BuildContext context, String path, String uid) async {
    ImageSource? source = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select_option'.i18n()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text('Camera'.i18n()),
                onTap: () {
                  Navigator.pop(context, ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: Text('Gallery'.i18n()),
                onTap: () {
                  Navigator.pop(context, ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );

    if (source != null) {
      final ImagePicker picker = ImagePicker();
      final XFile? imageFile = await picker.pickImage(source: source);
      if (imageFile != null) {
        File file = File(imageFile.path);
        try {
          // Create a unique file name for the upload
          String fileName = "${DateTime.now().microsecondsSinceEpoch}";
          // Create a reference to the file location
          FirebaseStorage storage = FirebaseStorage.instance;
          Reference ref = storage.ref().child("$uid/$path/$fileName");
          // Upload the file
          UploadTask uploadTask = ref.putFile(file);
          // Get the download URL
          await uploadTask.whenComplete(() {});
          return await ref.getDownloadURL();
        } catch (e) {
          displayError(context, e);
        }
      }
    }
    return '';
  }
}
