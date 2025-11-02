//
//
//


import 'package:mobile/constants/api_constants.dart';
import 'package:mobile/models/cart.dart';
import 'package:mobile/models/category.dart';
import 'package:mobile/models/product.dart';
import 'package:mobile/utils/api_helper.dart';

class ProductService {
  ///
  static Future<Map<String, dynamic>> getHomePageProducts() async {
    try {
      final response = await ApiHelper.get(ApiConstants.getProducts);
      final data = response.data['data'];
      final List<Product> prods = (data['products'] as List<dynamic>).map((
          product) => Product.fromJson(product)).toList();
      final List<Category> categories = (data['categories'] as List<dynamic>)
          .map((category) => Category.fromJson(category))
          .toList();
      return {
        "products": prods,
        "categories": categories,
      };
    } catch (e) {
      rethrow;
    }
  }

  ///
  static Future<Map<String, dynamic>> getProduct({
    required int productId,
  }) async {
    try {
      final response = await ApiHelper.get(
        ApiConstants.getProduct.replaceFirst(
          "{product_id}",
          productId.toString(),
        ),
      );
      final data = response.data['data'];
      final ans = {
        'product': Product.fromJson(data['product']),
        'related_products': (data['related_products'] as List)
            .map((p) => Product.fromJson(p))
            .toList(),
      };
      return ans;
    } catch (e) {
      rethrow;
    }
  }

  ///
  static Future<CartItem> addProductToCart({required int productId}) async {
    try {
      final response = await ApiHelper.post(
        ApiConstants.addItemToCart,
        data: {"product_id": productId, "quantity": 1},
        needAuth: true,
      );
      final data = response.data['data'];
      return CartItem.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  ///
  static Future<CartItem> updateCartItem({
    required int cartItemId,
    required int newQnt,
  }) async {
    try {
      final response = await ApiHelper.put(
        ApiConstants.updateCartItemQuantity(cartItemId),
        data: {"quantity": newQnt},
        needAuth: true,
      );
      final data = response.data['data'];
      return CartItem.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  ///
  static Future<void> deleteCartItem({required int cartItemId}) async {
    try {
      await ApiHelper.delete(
        ApiConstants.deleteCartItem(cartItemId),
        needAuth: true,
      );
    } catch (e) {
      rethrow;
    }
  }

  ///
  static Future<List<Product>> getProductsByCategory(int categoryId) async {
    try {
      final response = await ApiHelper.get(
          "${ApiConstants.baseUrl}/products/category/$categoryId");
      final List<dynamic> data = response.data['products'];
      return data.map((pro) => Product.fromJson(pro)).toList();
    } catch (e) {
      return [] ;
    }
  }

}
