//
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mobile/pages/auth/verify_code_page.dart';
import 'package:mobile/services/auth_service.dart';

class ForgetPasswordController extends GetxController {
  ///
  final emailController = TextEditingController();
  var isLoading = false.obs;

  Future<void> requestOtp() async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your email',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;
    try {
      final data = {"email": email};
      final res = await AuthService.forgetPassword(data);

      Get.snackbar(
        "Success",
        "OTP code has been sent to your email.",
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.to(() => VerifyCodePage(), arguments: {"email": email, "otp": res});
    } catch (e) {
      Get.snackbar(
        'Error',
        'Network error',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
