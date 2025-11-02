//
//
//
import 'package:delivery_man/constants/api_constants.dart';
import 'package:delivery_man/models/delivery_request.dart';
import 'package:delivery_man/models/order.dart';
import 'package:delivery_man/services/delivery_request_service.dart';
import 'package:delivery_man/services/order_service.dart';
import 'package:delivery_man/services/web_socket_service.dart';
import 'package:delivery_man/utils/api_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController {
  ///
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var mode = 'published'.obs;
  var assignedOrder = Rxn<Order>();
  var assignedRequest = Rxn<DeliveryRequest>();
  var currentRequest = Rxn<DeliveryRequest>();
  var isActionLoading = false.obs;
  var orders = <Order>[].obs;
  var pendingRequestOrderId = Rxn<int>();
  var selectedStatus = "Published".obs;

  ///
  WebSocketService socketService = WebSocketService();
  Map<String, Function(Map<String, dynamic>)> eventsHandlers = {};

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
    _initEventsHandlers();
    socketService.subscribe("orders_published", eventsHandlers);
    socketService.subscribe("orders_assigned", eventsHandlers);
  }

  ///
  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final res = await OrderService.getMainPageOrders();
      if (res['mode'] == 'assigned') {
        mode.value = 'assigned';
        currentRequest.value = res['request'];
      } else {
        mode.value = 'published';
        currentRequest.value = null;
        orders.value = (res['orders'] as List).isEmpty ? [] : res['orders'];
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  ///
  Future<void> sendRequest(int orderId) async {
    try {
      isLoading.value = true;
      await DeliveryRequestService.sendDeliveryRequest(orderId);
      await fetchOrders();
      //
      await fetchOrders();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  ///
  Future<void> pickupAssignedOrder(String otp) async {
    if (currentRequest.value == null) return;
    final orderId = currentRequest.value!.orderId;
    try {
      isActionLoading.value = true;
      final res = await OrderService.pickupOrder(orderId, otp);
      if (res) {
        Get.back();
        fetchOrders();
      }
    } catch (e) {
      Get.back();
      Get.snackbar(
        "Error",
        "Failed to verify OTP code",
        backgroundColor: Colors.red[100],
      );
    } finally {
      isActionLoading.value = false;
    }
  }

  ///
  Future<void> confirmDeliveryAssignedOrder(String otp) async {
    if (currentRequest.value == null) return;
    final id = currentRequest.value!.orderId;
    try {
      isActionLoading.value = true;
      final res = await OrderService.deliverOrder(id, otp);
      if (res) {
        Get.back();
        fetchOrders();
      }
    } catch (e) {
      Get.back();
      Get.snackbar(
        "Error",
        "Failed to verify OTP code",
        backgroundColor: Colors.red[100],
      );
    } finally {
      isActionLoading.value = false;
    }
  }

  ///
  void _initEventsHandlers() {
    final currentUserId = 2;
    eventsHandlers = {
      "order.published": (data) {
        if (mode.value == "published") {
          Order newPublishedOrder = Order.fromJson(data['order']);
          orders.insert(0, newPublishedOrder);
          Get.snackbar(
            "${newPublishedOrder.vendor!.name} :",
            "New order has been published",
            backgroundColor: Colors.green[100],
          );
        }
      },
      "order.assigned": (data) {
        Order newAssignedOrder = Order.fromJson(data['order']);
        if (newAssignedOrder.deliverymanId != null &&
            newAssignedOrder.deliverymanId == currentUserId) {
          Get.snackbar(
            "Assigned",
            "Your delivery request has been approved",
            backgroundColor: Colors.orange,
          );
        } else {
          Get.snackbar(
            "Declined",
            "Your delivery request has been declined by vendor",
            backgroundColor: Colors.red[100],
          );
        }

        fetchOrders();
      },
    };
  }

  Future<void> cancelOrder(int orderId , int reqId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      await OrderService.cancelOrderRequest(orderId, reqId);
      fetchOrders() ;
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar("Error", "Failed to cancel order");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> cancelRequest(int reqId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final response = await ApiHelper.delete(
        "${ApiConstants.baseUrl}/request-cancel",
        data: {'req_id': reqId},
        needAuth: true,
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        fetchOrders();
        Get.snackbar("Success", "Request canceled successfully");
      }
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar("Error", "Failed to cancel order");
    } finally {
      isLoading.value = false;
    }
  }
}
