import 'package:admin/services/auth_service.dart';
import 'package:admin/views/main/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  ///
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  ///
  var isLoading = false.obs;

  ///
  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar("Error", "Please enter email and password" , backgroundColor: Colors.red[100]);
      return;
    }
    try {
      isLoading.value = true;
      final Map<String, dynamic> data = {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      };

      await AuthService.login(data);

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
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
