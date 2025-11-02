//
//
//
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class IDCardPhotoStepController extends ChangeNotifier {
  File? uploadedImage;

  final ImagePicker _picker = ImagePicker();

  bool get isImageUploaded => uploadedImage != null;

  Future<void> pickImage() async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (picked != null) {
      uploadedImage = File(picked.path);
      notifyListeners();
    }
  }
}
