//
//
//
import 'package:admin/constants/api_constants.dart';
import 'package:admin/models/order.dart';
import 'package:admin/services/vendor_service.dart';
import 'package:admin/utils/api_helper.dart';

class OrderService {
  ///
  static Future<List<Order>> getOrders({String status = ""}) async {
    try {
      final vendorId = await VendorService.vendorId();
      final response = await ApiHelper.get(
        ApiConstant.getAllOrders(vendorId),
        queryParams: status.isNotEmpty ? {"status": status} : null,
        needAuth: true,
      );
      final List<dynamic> data = response.data['data'];
      return data.map((order) => Order.fromJson(order)).toList();
    } catch (e) {
      rethrow;
    }
  }

  ///
  static Future<Order> getOrderDetails(int orderId) async {
    try {
      final response = await ApiHelper.get(
        ApiConstant.getOrderDetails(orderId),
        needAuth: true,
      );
      final data = response.data;
      return Order.fromJson(data['data']);
    } catch (e) {
      rethrow;
    }
  }

  ///
  static Future<Order> publishOrder(int orderId, int deliveryCost) async {
    try {
      final vendorId = await VendorService.vendorId();
      final response = await ApiHelper.post(
        ApiConstant.publishOrder(orderId, vendorId),
        data: {"delivery_cost": deliveryCost},
        needAuth: true,
      );

      final data = response.data;
      return Order.fromJson(data['data']);
    } catch (e) {
      rethrow;
    }
  }

  ///
  static Future<void> acceptDeliveryRequest() async {}
}
