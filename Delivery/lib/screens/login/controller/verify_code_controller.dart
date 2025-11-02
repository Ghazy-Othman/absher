///
import 'package:delivery_man/screens/login/login_screen.dart';
import 'package:delivery_man/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class VerifyCodeController extends GetxController {
  ///
  final codeController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  var isSubmitting = false.obs;

  ///
  String? emailFromArgs;
  String? otpFromServer;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is Map) {
      emailFromArgs = args['email'] as String?;
      otpFromServer = args['otp']?.toString();
    }
  }

  Future<void> resetPassword() async {
    final codeInput = codeController.text.trim();
    final pass = passwordController.text;
    final passConfirm = passwordConfirmController.text;

    if (emailFromArgs == null) {
      Get.snackbar(
        'Error',
        'Missing email',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (codeInput.isEmpty || pass.isEmpty || passConfirm.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all fields',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (pass != passConfirm) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isSubmitting.value = true;
    try {
      final data = {
        "email": emailFromArgs,
        "otp": otpFromServer,
        "password": pass,
      };
      final res = await AuthService.resetPassword(data);
      if (res) {
        Get.offAll(() => LoginScreen());
      } else {
        Get.snackbar(
          'Error',
          'OTP wrong or expired',
          backgroundColor: Colors.red[100],
        );
        return;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Network error',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  @override
  void onClose() {
    codeController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.onClose();
  }
}
