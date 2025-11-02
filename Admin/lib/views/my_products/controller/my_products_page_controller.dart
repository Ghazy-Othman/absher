//
//
//
import 'package:admin/models/product.dart';
import 'package:admin/services/product_service.dart';
import 'package:get/get.dart';

class MyProductsController extends GetxController {
  var products = <Product>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      final fetched = await ProductService.getProductsForVendor();
      print('----------------');
      print(fetched[0].toJson().toString());
      print('----------------');
      products.assignAll(fetched);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load products: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
