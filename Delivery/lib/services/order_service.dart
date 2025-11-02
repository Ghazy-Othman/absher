//
//
//

import 'package:delivery_man/constants/api_constants.dart';
import 'package:delivery_man/models/delivery_request.dart';
import 'package:delivery_man/models/order.dart';
import 'package:delivery_man/utils/api_helper.dart';

class OrderService {
  ///
  static Future<Map<String, dynamic>> getMainPageOrders() async {
    try {
      final response = await ApiHelper.get(
        ApiConstants.getMainPageOrders,
        needAuth: true,
      );
      final data = response.data['data'];
      return {
        "mode": data['mode'],
        "orders": data['mode'] == 'published' && data['orders'] != null
            ? ((data['orders'] as List).map(
                (order) => Order.fromJson(order),
              )).toList()
            : [],
        "request": data['mode'] == "assigned"
            ? DeliveryRequest.fromJson(data['request'])
            : null,
      };
    } catch (e) {
      rethrow;
    }
  }

  ///
  static Future<bool> pickupOrder(int orderId, String otp) async {
    try {
      final response = await ApiHelper.post(
        ApiConstants.confirmPickUp.replaceFirst(
          "{order_id}",
          orderId.toString(),
        ),
        data: {"otp": otp},
        needAuth: true,
      );
      final data = response.data['data'];
      return data['status'];
    } catch (e) {
      rethrow;
    }
  }

  ///
  static Future<bool> deliverOrder(int orderId, String otp) async {
    try {
      final response = await ApiHelper.post(
        ApiConstants.confirmDeliver.replaceFirst(
          "{order_id}",
          orderId.toString(),
        ),
        data: {"otp": otp},
        needAuth: true,
      );
      final data = response.data['data'];
      return data['status'];
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> cancelOrderRequest(int orderId , int reqId) async {
    try {
      final response = await ApiHelper.post(
        ApiConstants.cancelOrderRequest,
        data: {'order_id': orderId ,"req_id" : reqId},
        needAuth: true,
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return;
      } else {
        throw Exception("Failed to cancel the order");
      }
    } catch (e) {
      rethrow;
    }
  }
}
