//
//
//
import 'package:get/get.dart';
import 'package:mobile/models/order.dart';
import 'package:mobile/services/order_service.dart';

class OrdersController extends GetxController {
  ///
  var isLoading = false.obs;

  var errorMessage = ''.obs;

  var orders = <Order>[].obs;

  var selectedStatus = 'All'.obs;

  ///
  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final fixed = {
        "All": "",
        "Pending": "pending",
        "Cancelled": "cancelled",
        "Assigned": "assigned",
        "Picked Up": "picked_up",
        "Delivered": "delivered",
      };
      final response = await OrderService.getOrders(
        status: fixed[selectedStatus.value] ?? "",
      );
      orders.value = response;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
