//
//
//
import 'dart:io';

import 'package:admin/constants/api_constants.dart';
import 'package:admin/models/product.dart';
import 'package:admin/utils/api_helper.dart';

class ProductService {
  ///
  static Future<List<Product>> getProductsForVendor() async {
    try {
      final response = await ApiHelper.get(
        ApiConstant.products,
        needAuth: true,
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final List<dynamic> data = response.data['data']['products'];
        return data.map((product) => Product.fromJson(product)).toList();
      } else {
        throw Exception("Failed to load products, Please refresh the page");
      }
    } catch (e) {
      rethrow;
    }
  }

  ///
  static Future<Product> getProductById(int id) async {
    try {
      final response = await ApiHelper.get(ApiConstant.productById(id));
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final p = response.data['data']['product'];

        return Product.fromJson(p);
      } else {
        throw Exception("Failed to load product, Please refresh the page");
      }
    } catch (e) {
      rethrow;
    }
  }

  ///
  static Future<bool> updateProduct(int id, Map<String, dynamic> data) async {
    try {
      final response = await ApiHelper.put(
        ApiConstant.updateProduct(id),
        data: data,
        needAuth: true,
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return true;
      } else {
        throw Exception("Failed to load product, Please refresh the page");
      }
    } catch (e) {
      rethrow;
    }
  }

  ///
  static Future<bool> deleteProduct(int id) async {
    try {
      final response = await ApiHelper.delete(ApiConstant.deleteProduct(id) , needAuth: true);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {

        return true;
      } else {
        throw Exception("Failed to load product, Please refresh the page");
      }
    } catch (e) {
      rethrow;
    }
  }

  ///
  static Future<bool> addProduct(
    Map<String, dynamic> data, {
    File? image,
  }) async {
    final response = await ApiHelper.post(
      ApiConstant.storeProduct,
      data: data,
      files: {"image": image!},
      needAuth: true,
    );
    try {
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }
}
