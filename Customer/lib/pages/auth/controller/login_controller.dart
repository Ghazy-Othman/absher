import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/pages/main/main_page.dart';
import 'package:mobile/services/user_service.dart';

class LoginController extends GetxController {
  ///
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  ///
  var isLoading = false.obs;

  ///
  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar("Error", "Please enter email and password");
      return;
    }
    try {
      isLoading.value = true;
      final Map<String, dynamic> data = {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      };

      await UserService.login(data);

      Get.snackbar(
        "Success",
        "Welcome back!",
        backgroundColor: Colors.green[100],
      );
      Get.offAll(() => MainPage());
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red[100]);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.clear();
    passwordController.clear();
    super.onClose();
  }
}
