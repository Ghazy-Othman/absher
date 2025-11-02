import 'package:delivery_man/screens/main_page/main_page.dart';
import 'package:delivery_man/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;

  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill in all fields",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;

    try {
      final Map<String, dynamic> data = {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      };

      final res = await AuthService.login(data);
      if (res) {
        Get.snackbar(
          "Success",
          "Welcome Back",
          backgroundColor: Colors.green[100],
        );
        Get.offAll(() => MainPage());
      }
    } catch (e) {
      Get.snackbar(
        "Login Failed",
        e.toString(),
        backgroundColor: Colors.red[100]
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
