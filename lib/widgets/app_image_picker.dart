import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

class AppImagePicker {
  static Future<File?> pickFile(ImageSource source) async {
    EasyLoading.show();
    final picker = ImagePicker();
    File? file;

    try {
      final XFile? photo = await picker.pickImage(source:source);

      if (photo != null) {
        file = File(photo.path);
      }
      EasyLoading.dismiss();

      return file!;
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
      EasyLoading.dismiss();
      return null;
    }
  }
}
