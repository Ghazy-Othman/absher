//
//
//
import 'package:get/get.dart';
import 'package:mobile/models/cart.dart';
import 'package:mobile/services/cart_service.dart';

class CartsController extends GetxController {
  ///
  var carts = <Cart>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchCarts();
    super.onInit();
  }

  ///
  Future<void> fetchCarts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await CartService.getUserCarts();
      carts.value = response;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  ///
  Future<void> deleteCart(int cartId) async{}
}
