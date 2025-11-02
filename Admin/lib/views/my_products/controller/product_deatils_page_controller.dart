//
//
//
import 'package:admin/models/product.dart';
import 'package:admin/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  final int productId;

  ProductDetailsController(this.productId);

  var product = Rxn<Product>();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProduct();
  }

  Future<void> fetchProduct() async {
    try {
      isLoading.value = true;
      final fetched = await ProductService.getProductById(productId);
      product.value = fetched;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load product: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProduct(Map<String, dynamic> data) async {
    try {
      final ok = await ProductService.updateProduct(productId, data);
      if (ok) {
        await fetchProduct();
        Get.back();
        Get.snackbar('Success', 'Product updated' , backgroundColor: Colors.greenAccent);
      } else {
        Get.snackbar('Error', 'Update failed');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteProduct() async {
    try {
      final ok = await ProductService.deleteProduct(productId);
      if (ok) {
        Get.back();
        Get.snackbar('Success', 'Product deleted');
        return true ;
      } else {
        Get.snackbar('Error', 'Delete failed');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
    return false ;
  }
}
