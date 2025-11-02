//
//
//
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/models/order.dart';
import 'package:mobile/services/order_service.dart';
import 'package:mobile/services/otp_service.dart';

class OrderDetailsController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var localError = ''.obs;
  var isActionLoading = false.obs;
  var code = ''.obs;

  var order = Rxn<Order>();

  ///
  Future<void> getOrder(int orderId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final response = await OrderService.getOrder(orderId);
      order.value = response;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  RxString deliveryOtp = ''.obs;
  RxInt remainingSeconds = 180.obs;
  Timer? _timer;

  Future<void> generateDeliveryOtp(int orderId) async {
    try {
      final response = await OTPService.generateDeliverOTP(orderId);
      deliveryOtp.value = response;

      // Reset timer
      remainingSeconds.value = 180;
      _timer?.cancel();
      _startCountdown();

      _showOtpDialog();
    } catch (e) {
      print("sdfsdfsf");
      print(e.toString());
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
          title: const Text("Delivery OTP"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                deliveryOtp.value,
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
                getOrder(order.value!.id);
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
