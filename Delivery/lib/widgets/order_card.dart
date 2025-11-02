//
//
//
import 'package:delivery_man/models/order.dart';
import 'package:delivery_man/screens/orders/controller/order_controller.dart';
import 'package:delivery_man/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({super.key, required this.order});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrdersController>();
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: vendor avatar/name + status
            Row(
              children: [
                CircleAvatar(
                  radius: 22.r,
                  backgroundColor: AppTheme.accentBlue.withAlpha(
                    (0.15 * 255).round(),
                  ),
                  backgroundImage: order.vendor!.image.isNotEmpty
                      ? NetworkImage(order.vendor!.image)
                      : null,
                  child: order.vendor!.image.isEmpty
                      ? Icon(Icons.store, color: AppTheme.darkBlue, size: 22.r)
                      : null,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.vendor!.name,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkBlue,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${order.itemsCount} items',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
                // Status pill
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.accentBlue.withAlpha((0.12 * 255).round()),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    order.status.toUpperCase(),
                    style: TextStyle(
                      color: AppTheme.accentBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            // Addresses
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.store_mall_directory,
                  size: 18.sp,
                  color: AppTheme.darkBlue,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    order.pickupAddress!,
                    style: TextStyle(fontSize: 13.sp),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_on, size: 18.sp, color: Colors.redAccent),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    order.deliveryAddress!,
                    style: TextStyle(fontSize: 13.sp),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            // Delivery cost + bottom area
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Delivery cost: \$${order.deliveryCost}',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkBlue,
                    ),
                  ),
                ),
                // Request / Pending UI
                Obx(() {
                  final pendingId = controller.pendingRequestOrderId.value;

                  // If a request already sent and it's not this order -> hide button
                  if (pendingId != null && pendingId != order.id) {
                    return const SizedBox.shrink();
                  }

                  // If this order is the pending one -> show "Pending Request" text
                  if (pendingId == order.id) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.accentBlue.withAlpha(
                          (0.10 * 255).round(),
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        'Pending Request',
                        style: TextStyle(
                          color: AppTheme.accentBlue,
                          fontSize: 12.sp,
                        ),
                      ),
                    );
                  }

                  // Otherwise show Request button
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.accentBlue,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    onPressed: () async {
                      await controller.sendRequest(order.id);
                    },
                    child: Text(
                      'Request',
                      style: TextStyle(fontSize: 14.sp, color: Colors.white),
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
