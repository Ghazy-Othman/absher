import 'package:admin/services/auth_service.dart';
import 'package:admin/views/main/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  ///
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();

  ///
  var isLoading = false.obs;

  ///
  Future<void> signUp() async {
    if (fullNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        addressController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill all fields",
        backgroundColor: Colors.red[100],
      );
      return;
    }

    try {
      isLoading.value = true;
      final Map<String, dynamic> data = {
        "name": fullNameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "address": addressController.text.trim(),
        "role": "vendor",
      };

      await AuthService.register(data);
      Get.snackbar(
        "Success",
        "Account created successfully!",
        backgroundColor: Colors.greenAccent,
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
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
