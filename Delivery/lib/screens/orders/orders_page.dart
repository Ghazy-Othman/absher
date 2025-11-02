//
//
//
import 'package:delivery_man/screens/orders/assigned_order_page.dart';
import 'package:delivery_man/screens/orders/controller/order_controller.dart';
import 'package:delivery_man/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../widgets/order_card.dart';

enum OtpMode { pickup, deliver }

class OrdersTab extends StatelessWidget {
  OrdersTab({super.key});

  final OrdersController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrdersController>();

    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          if (controller.mode.value == "published") {
            return Text("Orders");
          }
          return Text("Assigned Order");
        }),
        backgroundColor: AppTheme.darkBlue,
        actions: [
          Obx(() {
            final req = controller.currentRequest.value;
            if (req == null) return const SizedBox.shrink();
            final orderStatus = req.order.status.toLowerCase();
            if (orderStatus == 'assigned') {
              // show Pick Up button (text)
              return TextButton(
                onPressed: () => _showOtpDialog(context, OtpMode.pickup),
                // onPressed: controller.openPickupDialog,
                child: Text(
                  'Pick Up',
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                ),
              );
            } else if (orderStatus == 'picked_up') {
              return TextButton(
                onPressed: () => _showOtpDialog(context, OtpMode.deliver),
                // onPressed: controller.openDeliverDialog,
                child: Text(
                  'Deliver',
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
        ],
      ),
      body: Obx(() {
        ///
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        ///
        if (controller.errorMessage.isNotEmpty) {
          return RefreshIndicator(
            onRefresh: controller.fetchOrders,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 200.h),
                    child: Text(controller.errorMessage.value),
                  ),
                ),
              ],
            ),
          );
        }

        ///
        if (controller.mode.value == 'assigned') {
          return AssignedOrderPage();
        }

        if (controller.orders.isEmpty) {
          return RefreshIndicator(
            onRefresh: controller.fetchOrders,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 200.h),
                    child: Text("No orders yet"),
                  ),
                ),
              ],
            ),
          );
        }

        ///
        return RefreshIndicator(
          onRefresh: controller.fetchOrders,
          child: ListView.builder(
            padding: EdgeInsets.only(top: 4.h),
            itemCount: controller.orders.length,
            itemBuilder: (context, index) {
              final order = controller.orders[index];
              return OrderCard(order: order);
            },
          ),
        );
      }),
    );
  }

  void _showOtpDialog(BuildContext context, OtpMode mode) {
    final TextEditingController otpController = TextEditingController();
    final RxString localError = ''.obs;

    Get.dialog(
      Center(
        child: SizedBox(
          width: 320.w,
          child: Material(
            borderRadius: BorderRadius.circular(12.r),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    mode == OtpMode.pickup
                        ? 'Enter Pickup OTP'
                        : 'Enter Delivery OTP',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  TextField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter OTP code',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 12.w,
                      ),
                    ),
                    maxLength: 6,
                  ),
                  Obx(
                    () => localError.value.isEmpty
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: EdgeInsets.only(top: 4.h, bottom: 8.h),
                            child: Text(
                              localError.value,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                  ),
                  SizedBox(height: 8.h),
                  Obx(() {
                    if (controller.isActionLoading.value) {
                      return SizedBox(
                        height: 42.h,
                        width: double.infinity,
                        child: Center(
                          child: CircularProgressIndicator(strokeWidth: 2.w),
                        ),
                      );
                    }
                    return SizedBox(
                      width: double.infinity,
                      height: 42.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                        ),
                        onPressed: () async {
                          final otp = otpController.text.trim();
                          if (otp.isEmpty) {
                            localError.value = 'Please enter the OTP code';
                            return;
                          }
                          localError.value = '';
                          if (mode == OtpMode.pickup) {
                            await controller.pickupAssignedOrder(otp);
                          } else {
                            await controller.confirmDeliveryAssignedOrder(otp);
                          }
                        },
                        child: Text(
                          'Verify',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: 6.h),
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text('Cancel', style: TextStyle(fontSize: 13.sp)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
