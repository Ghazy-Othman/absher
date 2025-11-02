import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/models/product.dart';
import 'package:mobile/services/product_service.dart';

class ProductController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var product = Rxn<Product>();
  var relatedProducts = <Product>[].obs;

  /// Prevent multiple re-fetches during widget rebuilds
  bool isInitialized = false;

  ///
  Future<void> fetchProduct(int productId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final response = await ProductService.getProduct(productId: productId);
      product.value = response['product'];
      relatedProducts.value = response['related_products'];
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  ///
  Future<void> addProductToCart(int productId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      await ProductService.addProductToCart(productId: productId);
      Get.snackbar(
        "Done",
        "Product has been added successfully.",
        backgroundColor: Colors.green[200],
      );
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        "Error",
        "Failed to add product to cart",
        backgroundColor: Colors.red[100],
      );
    } finally {
      isLoading.value = false;
    }
  }
}
