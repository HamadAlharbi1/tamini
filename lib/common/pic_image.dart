import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
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

  Future<String> selectAndUploadImage(context, String path, String uid) async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageFile = await picker.pickImage(source: ImageSource.gallery);

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
    return '';
  }
}
