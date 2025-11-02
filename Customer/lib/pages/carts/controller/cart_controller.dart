//
//
//
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/models/cart.dart';
import 'package:mobile/services/cart_service.dart';
import 'package:mobile/services/product_service.dart';

class CartController extends GetxController {
  ///
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var cart = Rxn<Cart>();

  ///
  Future<void> fetchCart(int cartId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final response = await CartService.getCart(cartId);
      cart.value = response;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  ///
  Future<void> increaseCartItemQuantity({
    required int cartId,
    required int itemId,
  }) async {
    try {
      final newQnt =
          cart.value!.items!
              .where((element) => element.id == itemId)
              .first
              .quantity! +
          1;
      await ProductService.updateCartItem(cartItemId: itemId, newQnt: newQnt);
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to update product quantity\nPlease try again..",
        backgroundColor: Colors.red,
      );
    } finally {
      fetchCart(cartId);
    }
  }

  ///
  Future<void> decreaseCartItemQuantity({
    required int cartId,
    required int itemId,
  }) async {
    try {
      final newQnt =
          cart.value!.items!
              .where((element) => element.id == itemId)
              .first
              .quantity! -
          1;
      if (newQnt == 0) {
        await ProductService.deleteCartItem(cartItemId: itemId);
      } else {
        await ProductService.updateCartItem(cartItemId: itemId, newQnt: newQnt);
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to update product quantity\nPlease try again..",
        backgroundColor: Colors.red,
      );
    } finally {
      fetchCart(cartId);
    }
  }

  ///
  Future<void> deleteCartItem({
    required int cartId,
    required int itemId,
  }) async {
    try {
      await ProductService.deleteCartItem(cartItemId: itemId);
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to delete cart item\nPlease try again..",
        backgroundColor: Colors.red,
      );
    } finally {
      fetchCart(cartId);
    }
  }

  ///
  Future<void> checkout() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await CartService.checkout(cart.value!.id!);
      Get.back();
      Get.snackbar("Success", "New order has been placed");
    } catch (e) {
      errorMessage.value = "Failed to make order for this cart";
    } finally {
      isLoading.value = false;
    }
  }
}
