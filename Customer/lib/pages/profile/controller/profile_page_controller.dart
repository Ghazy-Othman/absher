import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/constants/api_constants.dart';
import 'package:mobile/pages/auth/login_page.dart';
import 'package:mobile/utils/api_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;

  var name = ''.obs;
  var email = ''.obs; // read-only
  var address = ''.obs;
  var avatar = ''.obs;

  /// Fetch profile
  Future<void> fetchProfile(String role) async {
    try {
      isLoading.value = true;
      final response = await ApiHelper.get(
        '${ApiConstants.baseUrl}/$role/profile',
        needAuth: true,
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final data = response.data;
        name.value = data['user']['name'];
        email.value = data['user']['email'];
        address.value = data['user']['address'];
        avatar.value = data['user']['avatar_path'] ?? '';
        if (avatar.value.isNotEmpty) {
          avatar.value = avatar.value.replaceFirst(
            "http://127.0.0.1:8000/",
            ApiConstants.baseUrl.replaceFirst("api/v1", ""),
          );
        }
      }
    } finally {
      isLoading.value = false;
    }
  }

  /// Update profile
  Future<void> updateField(
    String role,
    String field,
    dynamic value, {
    bool isImage = false,
  }) async {
    try {
      isLoading.value = true;
      Map<String, dynamic> data = {};
      Map<String, File> files = {};
      if (isImage) {
        files[field] = File(value);
      } else {
        data[field] = value;
      }

      final response = await ApiHelper.post(
        '${ApiConstants.baseUrl}/$role/profile/update',
        data: data,
        files: files,
        needAuth: true,
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        await fetchProfile(role);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage(String role) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      await updateField(role, "avatar", picked.path, isImage: true);
    }
  }


  Future<void> logout() async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();
    Get.offAll(() => LoginPage());
  }
}
