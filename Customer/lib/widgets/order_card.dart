//
//
//
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile/models/order.dart';
import 'package:mobile/pages/orders/order_details_page.dart';
import 'package:mobile/theme/app_theme.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => OrderDetailsPage(orderId: order.id)),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        color: Colors.white,
        shadowColor: AppTheme.accentBlue,
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Top Row: Avatar + Name + Status
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        order.customer != null &&
                            order.customer!.avatarPath != null
                        ? NetworkImage(order.customer!.image)
                        : null,
                    radius: 20.r,
                    child:
                        order.customer != null ||
                            order.customer!.avatarPath != null
                        ? Icon(Icons.person, color: Colors.white)
                        : null,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      order.customer!.name,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    order.status.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: order.status == "pending"
                          ? Colors.orange
                          : Colors.green,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),

              /// Items & Price
              Text(
                "${order.cart!.items!.length} items - Total: ${order.total} \$",
                style: TextStyle(fontSize: 13.sp, color: AppTheme.darkBlue),
              ),
              SizedBox(height: 4.h),

              /// Delivery address
              Text(
                "Delivery: ${order.deliveryAddress}",
                style: TextStyle(fontSize: 12.sp, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
