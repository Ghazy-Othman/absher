//
//
//
import 'package:mobile/constants/api_constants.dart';
import 'package:mobile/models/order.dart';
import 'package:mobile/utils/api_helper.dart';

class OrderService {
  ///
  static Future<List<Order>> getOrders({String status = ""}) async {
    try {
      final response = await ApiHelper.get(
        ApiConstants.getUserOrders,
        queryParams: {"status": status != "" ? status : null},
        needAuth: true,
      );
      final List<dynamic> data = response.data['data'];
      return data.map((order) => Order.fromJson(order)).toList();
    } catch (e) {
      rethrow;
    }
  }

  ///
  static Future<Order> getOrder(int orderId) async {
    try {
      final response = await ApiHelper.get(
        ApiConstants.getOrder.replaceFirst("{order_id}", orderId.toString()),
        needAuth: true,
      );
      final data = response.data['data'];
      return Order.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> generateCode(int orderId) async {
    try {
      final response = await ApiHelper.post(
        ApiConstants.generateCode.replaceFirst(
          "{order_id}",
          orderId.toString(),
        ),
        needAuth: true,
      );
      final data = response.data['data']['otp'];
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
