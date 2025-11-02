//
//
//
import 'package:mobile/constants/api_constants.dart';
import 'package:mobile/models/cart.dart';
import 'package:mobile/models/order.dart';
import 'package:mobile/utils/api_helper.dart';

class CartService {
  ///
  static Future<List<Cart>> getUserCarts() async {
    try {
      final response = await ApiHelper.get(
        ApiConstants.getUserCart,
        needAuth: true,
      );
      final List<dynamic> data = response.data['data'];
      return data.map((cart) => Cart.fromJson(cart)).toList();
    } catch (e) {
      rethrow;
    }
  }

  ///
  static Future<Cart> getCart(int cartId) async {
    try {
      final response = await ApiHelper.get(
        ApiConstants.getCart(cartId),
        needAuth: true,
      );
      final data = response.data['data'];
      return Cart.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  ///
  static Future<void> deleteCart(int cartId) async {
    try {
      await ApiHelper.delete(ApiConstants.deleteCart(cartId), needAuth: true);
    } catch (e) {
      rethrow;
    }
  }

  ///
  static Future<Order> checkout(int cartId) async {
    try {
      final response = await ApiHelper.post(
        ApiConstants.checkout(cartId),
        needAuth: true,
        data: {"delivery_address": "Customer address"},
      );
      final data = response.data['data'];
      return Order.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }
}
