//
//
//
import 'package:admin/models/order.dart';
import 'package:admin/theme/app_theme.dart';
import 'package:admin/views/order/controller/order_controller.dart';
import 'package:admin/views/widgets/order_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderDetailsPage extends StatelessWidget {
  final Order order;

  const OrderDetailsPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    ///
    final controller = Get.put(OrderController(order));

    ///
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details", style: TextStyle(fontSize: 18.sp)),
        backgroundColor: AppTheme.darkBlue,
        actions: [
          Obx(() {
            if (controller.isLoading.isTrue ||
                controller.errorMessage.isNotEmpty) {
              return SizedBox();
            }
            if (controller.order.value!.status == "assigned" ||
                controller.order.value!.status == "pending") {
              return TextButton(
                onPressed: () {
                  if (controller.order.value!.status == "assigned") {
                    controller.pickupGenerate();
                  } else if (controller.order.value!.status == "pending") {
                    _showPublishDialog(context, controller);
                  }
                },
                child: Text(
                  controller.order.value!.status == "assigned"
                      ? "Confirm Pick Up"
                      : "Publish",
                  style: TextStyle(
                    color: AppTheme.accentBlue,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            return SizedBox();
          }),
        ],
      ),
      body: Obx(() {
        ///
        if (controller.isLoading.isTrue) {
          return Center(child: CircularProgressIndicator());
        }

        ///
        if (controller.errorMessage.isNotEmpty) {
          return RefreshIndicator(
            onRefresh: controller.fetchOrderDetails,
            child: ListView(
              physics: AlwaysScrollableScrollPhysics(),
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

        return RefreshIndicator(
          onRefresh: controller.fetchOrderDetails,
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Order details card
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha((0.05 * 255).round()),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Order basic info
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Order #${controller.order.value!.id}",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.darkBlue,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.accentBlue.withAlpha(
                                (0.1 * 255).round(),
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              controller.order.value!.status!,
                              style: TextStyle(
                                color: AppTheme.accentBlue,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Total: \$${controller.order.value!.total}",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      controller.order.value!.deliveryCost != null
                          ? Text(
                              "Delivery Cost: \$${controller.order.value!.deliveryCost}",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : SizedBox(),
                      Divider(height: 20.h),

                      /// Customer info
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20.r,
                            backgroundColor: AppTheme.accentBlue.withAlpha(
                              (0.2 * 255).round(),
                            ),
                            backgroundImage:
                                controller.order.value!.customer!.image.isNotEmpty
                                ? NetworkImage(
                                    controller.order.value!.customer!.image,
                                  )
                                : null,
                            child:
                                controller.order.value!.customer!.image.isEmpty
                                ? Icon(Icons.person, color: AppTheme.darkBlue)
                                : null,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            controller.order.value!.customer!.name,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.darkBlue,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),

                      /// Addresses
                      _buildAddressRow(
                        icon: Icons.store,
                        label: "Pickup Address",
                        value: controller.order.value!.pickupAddress!,
                      ),
                      SizedBox(height: 8.h),
                      _buildAddressRow(
                        icon: Icons.location_on,
                        label: "Delivery Address",
                        value: controller.order.value!.deliveryAddress!,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                /// Products Title
                Text(
                  "Products",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkBlue,
                  ),
                ),
                SizedBox(height: 8.h),

                /// Products list
                Expanded(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: controller.order.value!.cart!.items.length,
                    itemBuilder: (context, index) {
                      final item = controller.order.value!.cart!.items[index];
                      return OrderProductCard(item: item);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  ///
  void _showPublishDialog(BuildContext context, OrderController controller) {
    final costController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: Text("Publish Order", style: TextStyle(fontSize: 16.sp)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Delivery cost field
            TextField(
              controller: costController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Delivery cost"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // close dialog
            },
            child: Text("Cancel", style: TextStyle(color: AppTheme.darkBlue)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accentBlue,
            ),
            onPressed: () {
              controller.publishOrder(
                deliveryCost: int.tryParse(costController.text) ?? 0,
              );
              Get.back();
            },
            child: const Text("Done"),
          ),
        ],
      ),
    );
  }

  ///
  Widget _buildAddressRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20.sp, color: AppTheme.accentBlue),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: TextStyle(fontSize: 13.sp, color: Colors.black87),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
