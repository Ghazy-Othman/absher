//
import 'dart:io';
import 'package:delivery_man/screens/main_page/main_page.dart';
import 'package:delivery_man/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegisterController extends GetxController {
  ///===================================================
  ///                  Step 1
  ///===================================================
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nationalIdController = TextEditingController();
  final addressController = TextEditingController();

  var selectedGender = 'Male'.obs;
  var selectedCity = 'Damascus'.obs;
  var agreed = false.obs;

  final List<String> genders = ['Male', 'Female'];
  final List<String> cities = [
    'Damascus',
    'Aleppo',
    'Homs',
    'Latakia',
    'Tartus',
    'Hama',
    'Daraa',
    'Idlib',
    'Deir ez-Zor',
    'Raqqa',
    'Hasakah',
    'Qamishli',
    'As-Suwayda',
  ];

  final List<String> vehicleTypes = ['Bicycle', 'E-Bike', 'Motorcycle', 'Car'];
  var selectedVehicle = 'Bicycle'.obs;

  ///===================================================
  ///                  Step 2
  ///===================================================
  final ImagePicker _picker = ImagePicker();

  /// Profile photo
  Rx<File?> profilePhoto = Rx<File?>(null);

  Future<void> pickProfilePhoto() async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 80,
    );
    if (picked != null) {
      profilePhoto.value = File(picked.path);
    } else {
      _showErrorSnack(
        'No Image Selected',
        'Please select a photo to continue.',
      );
    }
  }

  ///===================================================
  ///                  Step 3
  ///===================================================

  /// ID card photo
  Rx<File?> idCardPhoto = Rx<File?>(null);

  Future<void> pickIdCardPhoto() async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1280,
      maxHeight: 1280,
      imageQuality: 85,
    );
    if (picked != null) {
      idCardPhoto.value = File(picked.path);
    } else {
      _showErrorSnack('No Image Selected', 'Please select your ID card.');
    }
  }

  ///===================================================
  ///                  Step 4
  ///===================================================

  /// Driver license photo
  Rx<File?> driverLicensePhoto = Rx<File?>(null);

  Future<void> pickDriverLicensePhoto() async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1280,
      maxHeight: 1280,
      imageQuality: 85,
    );
    if (picked != null) {
      driverLicensePhoto.value = File(picked.path);
    } else {
      _showErrorSnack(
        'No Image Selected',
        'Please select your driver license.',
      );
    }
  }

  ///===================================================
  ///                  Step 4
  ///===================================================
  ///
  void selectVehicle(String vehicle) {
    selectedVehicle.value = vehicle;
  }

  ///===================================================
  ///                  Helpers
  ///===================================================
  void _showErrorSnack(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade100,
      colorText: Colors.black,
    );
  }

  /// Reset everything (useful if user cancels registration)
  void resetAll() {
    profilePhoto.value = null;
    idCardPhoto.value = null;
    driverLicensePhoto.value = null;

    nameController.clear();
    emailController.clear();
    nationalIdController.clear();
    passwordController.clear();
    addressController.clear();

    selectedGender.value = 'Male';
    selectedCity.value = 'Damascus';
    selectedVehicle.value = 'Bicycle';
    agreed.value = false;
  }

  ///===================================================
  ///
  var isLoading = false.obs;

  Future<void> register() async {
    try {
      isLoading.value = true;
      final Map<String, dynamic> data = {
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "role": "delivery",
        "national_id": nationalIdController.text.trim(),
        "city": selectedCity.value,
        "gender": selectedGender.value.toLowerCase(),
        "vehicle_type": selectedVehicle.value,
        "address" :addressController.text.trim()
      };

      ///TODO
      final Map<String, File> images = {
        "avatar" : profilePhoto.value!,
        "id_card_photo": idCardPhoto.value!,
        "driver_license_photo": idCardPhoto.value!,
      };
      //
      final res = await AuthService.register(data,images);
      if (res) {
        Get.snackbar("Success", "Welcome", backgroundColor: Colors.green[100]);
        Get.offAll(() => MainPage());
      } else {
        throw Exception("Failed to sign up");
      }
    } catch (e) {
      _showErrorSnack("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
