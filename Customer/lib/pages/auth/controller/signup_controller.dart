import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/pages/main/main_page.dart';
import 'package:mobile/services/user_service.dart';

class SignUpController extends GetxController {
  ///
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();

  ///
  var isLoading = false.obs;

  ///
  Future<void> signUp() async {
    if (fullNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty||
        addressController.text.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    try {
      isLoading.value = true;
      final Map<String, dynamic> data = {
        "name": fullNameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "address": addressController.text.trim(),
        "role": "customer",
      };

      await UserService.signUp(data);
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
