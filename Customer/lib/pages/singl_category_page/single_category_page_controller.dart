import 'package:get/get.dart';
import 'package:mobile/models/product.dart';
import 'package:mobile/services/product_service.dart';

class SingleCategoryController extends GetxController {
  final int categoryId;

  SingleCategoryController({required this.categoryId});

  var isLoading = false.obs;
  var products = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;

      final res = await ProductService.getProductsByCategory(categoryId);
      products.value = res;
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to load products",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
