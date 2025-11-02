//
//
//
import 'dart:io';
import 'package:admin/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddProductController extends GetxController {
  var name = ''.obs;
  var description = ''.obs;
  var price = 0.0.obs;
  var categoryId = 0.obs;
  var imageFile = Rxn<File>();
  var isLoading = false.obs;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked != null) imageFile.value = File(picked.path);
  }

  Future<void> addProduct() async {
    if (name.value.isEmpty) {
      Get.snackbar('Error', 'Product name is required');
      return;
    }

    try {
      isLoading.value = true;
      final data = {
        'name': name.value,
        'description': description.value,
        'price': price.value,
        'category_id': categoryId.value + 1 ,
      };

      final success = await ProductService.addProduct(
        data,
        image: imageFile.value,
      );
      if (success) {
        Get.back(result: true);
        Get.snackbar(
          'Success',
          'Product added',
          backgroundColor: Colors.greenAccent,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to add product',
          backgroundColor: Colors.redAccent,
        );
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.redAccent);
    } finally {
      isLoading.value = false;
    }
  }
}
