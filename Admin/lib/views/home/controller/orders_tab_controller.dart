//
//
//

import 'package:admin/models/order.dart';
import 'package:admin/services/order_service.dart';
import 'package:admin/services/web_socket_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class OrdersTabController extends GetxController {
  ///
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var orders = <Order>[].obs;
  var selectedStatus = 'Pending'.obs;

  ///
  WebSocketChannel? channel;
  WebSocketService socketService = WebSocketService();
  Map<String, Function(Map<String, dynamic>)> eventsHandlers = {};

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
    _initEventsHandlers();
    socketService.subscribe("orders_placed", eventsHandlers);
  }

  ///
  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final Map<String, String> fixed = {
        "All": "",
        "Pending": "pending",
        "Cancelled": "cancelled",
        "Published": "published",
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

  ///================================================
  ///================================================
  ///================================================
  ///
  void _initEventsHandlers() {
    final currentUserId = 1;
    eventsHandlers = {
      "order.placed": (data) {
        Order placedOrder = Order.fromJson(data['order']);
        if (placedOrder.vendorId == currentUserId) {
          orders.insert(0, placedOrder);
          Get.snackbar(
            placedOrder.customer!.name,
            "New order has been placed",
            backgroundColor: Colors.green[100],
          );
        }
      },
    };
  }
}
