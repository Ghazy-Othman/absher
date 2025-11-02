//
//
//

import 'package:admin/models/delivery_request.dart';
import 'package:admin/services/delivery_requests_service.dart';
import 'package:admin/services/web_socket_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryRequestsTabController extends GetxController {
  ///
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var requests = <DeliveryRequest>[].obs;
  var selectedStatus = 'Pending'.obs;

  ///
  WebSocketService socketService = WebSocketService();
  Map<String, Function(Map<String, dynamic>)> eventsHandlers = {};

  @override
  void onInit() {
    super.onInit();
    fetchRequests();
    _initEventsHandlers();
    socketService.subscribe("delivery_requests", eventsHandlers);
  }

  ///
  Future<void> fetchRequests() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final Map<String, String> fixed = {
        "All": "",
        "Pending": "pending",
        "Declined": "declined",
        "Approved": "approved",
      };
      requests.value = await DeliveryRequestsService.getDeliveryRequests(
        status: fixed[selectedStatus.value] ?? '',
      );
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  ///
  Future<void> updateDeliveryRequestStatus(
    int deliveryRequestId,
    String status,
  ) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      await DeliveryRequestsService.updateDeliveryRequestStatus(
        deliveryRequestId,
        status,
      );
      await fetchRequests();
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
      "delivery.requested": (data) {
        DeliveryRequest newDeliveryRequest = DeliveryRequest.fromJson(
          data['delivery_request'],
        );
        if (newDeliveryRequest.order!.vendorId == currentUserId) {
          requests.insert(0, newDeliveryRequest);
          Get.snackbar(
            "${newDeliveryRequest.deliveryMan!.name}",
            "New delivery request",
            backgroundColor: Colors.blue[100],
          );
        }
      },
    };
  }
}
