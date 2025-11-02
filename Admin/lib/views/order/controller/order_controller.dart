//
//
//
import 'dart:async';

import 'package:admin/models/order.dart';
import 'package:admin/services/order_service.dart';
import 'package:admin/services/otp_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  ///
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var order = Rxn<Order?>(null);

  OrderController(Order order) {
    this.order.value = order;
  }

  ///
  Future<void> fetchOrderDetails() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await OrderService.getOrderDetails(order.value!.id!);
      order.value = response;
    } catch (e) {
      errorMessage.value =
          "Failed to load order details\nPlease refresh the page..";
    } finally {
      isLoading.value = false;
    }
  }

  ///
  Future<void> publishOrder({required int deliveryCost}) async {
    try {
      ///TODO : Add data
      await OrderService.publishOrder(order.value!.id!, deliveryCost);
      fetchOrderDetails();
    } catch (e) {
      Get.snackbar("Error", "Failed to publish the order\nPlease try again");
    } finally {}
  }

  RxString pickupOtp = ''.obs;
  RxInt remainingSeconds = 180.obs;
  Timer? _timer;

  Future<void> pickupGenerate() async {
    try {
      final response = await OTPService.requestPickUpOtp(order.value!.id ?? 0);
      pickupOtp.value = response;

      // Reset timer
      remainingSeconds.value = 180;
      _timer?.cancel();
      _startCountdown();

      _showOtpDialog();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void _showOtpDialog() {
    Get.dialog(
      Obx(
        () => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text("Pickup OTP"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                pickupOtp.value,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Expires in ${_formatTime(remainingSeconds.value)}",
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _timer?.cancel();
                Get.back();
              },
              child: const Text("Close"),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
