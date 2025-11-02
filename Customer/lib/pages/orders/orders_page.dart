//
//
//

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile/pages/orders/controller/orders_controller.dart';
import 'package:mobile/theme/app_theme.dart';
import 'package:mobile/widgets/order_card.dart';

class OrdersPage extends StatelessWidget {
  OrdersPage({super.key});

  final OrdersController controller = Get.put(OrdersController());

  @override
  Widget build(BuildContext context) {
    controller.fetchOrders() ;
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders", style: TextStyle(fontSize: 18.sp)),
        backgroundColor: AppTheme.darkBlue,
      ),
      body: Obx(() {
        //
        if (controller.isLoading.isTrue) {
          return const Center(child: CircularProgressIndicator());
        }
        //
        if (controller.errorMessage.isNotEmpty) {
          return RefreshIndicator(
            onRefresh: controller.fetchOrders,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 200.h),
                    child: controller.errorMessage.isNotEmpty
                        ? Text(controller.errorMessage.value)
                        : const Text("No orders yet..."),
                  ),
                ),
              ],
            ),
          );
        }

        return buildOrdersTab(controller);
      }),
    );
  }

  ///
  Widget buildOrdersTab(OrdersController ordersController) {
    final List<Map<String, dynamic>> statuses = [
      {"label": "All", "color": const Color(0xFF454747)}, // Orange
      {"label": "Pending", "color": const Color(0xFFFFA500)}, // Orange
      {"label": "Cancelled", "color": const Color(0xFFE53935)}, // Red
      {"label": "Assigned", "color": const Color(0xFF1E88E5)}, // Blue
      {"label": "Picked Up", "color": const Color(0xFF8E24AA)}, // Purple
      {"label": "Published", "color": const Color(0xFF43A047)}, // Green
      {"label": "Delivered", "color": const Color(0xFF2E7D32)}, // Dark Green
    ];
    return Column(
      children: [
        //
        Container(
          height: 40.h,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: statuses.length,
            itemBuilder: (context, index) {
              final status = statuses[index];
              final isSelected =
                  ordersController.selectedStatus.value == status["label"];

              return GestureDetector(
                onTap: () {
                  ordersController.selectedStatus.value = status["label"];
                  ordersController.fetchOrders();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    // vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? status["color"].withOpacity(0.9)
                        : status["color"].withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: isSelected ? status["color"] : Colors.transparent,
                      width: 1.w,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      status["label"],
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        //
        Expanded(
          child: Obx(() {
            if (ordersController.isLoading.isTrue) {
              return const Center(child: CircularProgressIndicator());
            }
            if (ordersController.errorMessage.isNotEmpty ||
                ordersController.orders.isEmpty) {
              return RefreshIndicator(
                onRefresh: ordersController.fetchOrders,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 200.h),
                        child: ordersController.errorMessage.isNotEmpty
                            ? Text(ordersController.errorMessage.value)
                            : const Text("No orders yet..."),
                      ),
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: ordersController.fetchOrders,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 4.h),
                itemCount: ordersController.orders.length,
                itemBuilder: (context, index) {
                  final order = ordersController.orders[index];
                  return OrderCard(order: order);
                },
              ),
            );
          }),
        ),
      ],
    );
  }
}
