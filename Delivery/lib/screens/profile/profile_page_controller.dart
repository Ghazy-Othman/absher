//
import 'dart:io';

import 'package:delivery_man/constants/api_constants.dart';
import 'package:delivery_man/screens/login/login_screen.dart';
import 'package:delivery_man/utils/api_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;

  var name = ''.obs;
  var email = ''.obs; // read-only
  var address = ''.obs;
  var city = ''.obs;
  var gender = ''.obs;
  var vehicleType = ''.obs;
  var nationalId = ''.obs;
  var avatar = ''.obs;
  var idCardPhoto = ''.obs;
  var driverLicensePhoto = ''.obs;

  /// Fetch delivery man profile
  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      final response = await ApiHelper.get(
        '${ApiConstants.baseUrl}/delivery/profile',
        needAuth: true,
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        name.value = response.data['user']['name'];
        email.value = response.data['user']['email'];
        address.value = response.data['user']['address'];

        final attr = response.data['attributes'];
        avatar.value = attr['avatar_path'] ?? '';
        city.value = attr['city'] ?? '';
        gender.value = attr['gender'] ?? '';
        vehicleType.value = attr['vehicle_type'] ?? '';
        nationalId.value = attr['national_id'] ?? '';
        idCardPhoto.value = attr['id_card_photo_path'] ?? '';
        driverLicensePhoto.value = attr['driver_license_photo_path'] ?? '';
      }
    } catch (e) {
      Get.snackbar(
        "Server Error",
        "Failed to load user data",
        backgroundColor: Colors.red[100],
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Update profile field
  Future<void> updateField(
    String field,
    dynamic value, {
    bool isImage = false,
  }) async {
    try {
      isLoading.value = true;

      final Map<String, dynamic> data = {};
      final Map<String, File> files = {};
      if (isImage) {
        files[field] = File(value);
      } else {
        data[field] = value;
      }

      final response = await ApiHelper.post(
        '${ApiConstants.baseUrl}/delivery/profile/update',
        data: data,
        files: files,
        needAuth: true,
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        await fetchProfile();
      }
    } catch (e) {
      print("-----");
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Pick image
  Future<void> pickImage(String field) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      await updateField(field, picked.path, isImage: true);
    }
  }

  Future<void> logout() async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();
    Get.offAll(() => LoginScreen());
  }
}
