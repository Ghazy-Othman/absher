//
//
//
import 'package:admin/models/delivery_request.dart';
import 'package:admin/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class DeliveryRequestCard extends StatelessWidget {
  final DeliveryRequest request;
  final Callback onApprove;

  final Callback onDecline;

  const DeliveryRequestCard({
    super.key,
    required this.request,
    required this.onApprove,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      color: AppTheme.accentBlue.withAlpha((0.2 * 255).round()),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Request ID: ${request.id}",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  request.status!.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: request.status == "pending"
                        ? Colors.orange
                        : (request.status == "declined"
                              ? Colors.red
                              : Colors.green),
                  ),
                ),
              ],
            ),

            SizedBox(height: 4.h),
            Text(
              "Pickup: ${request.order!.pickupAddress}",
              style: TextStyle(fontSize: 12.sp),
            ),
            Text(
              "Delivery: ${request.order!.deliveryAddress}",
              style: TextStyle(fontSize: 12.sp),
            ),
            Text(
              "Cost: ${request.order!.deliveryCost} \$",
              style: TextStyle(fontSize: 12.sp, color: AppTheme.darkBlue),
            ),
            SizedBox(height: 4.h),
            Divider(),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: request.order!.customer!.avatarPath != null
                      ? NetworkImage(request.order!.customer!.image)
                      : null,
                  radius: 20.r,
                  child: request.order!.customer!.avatarPath == null
                      ? Icon(Icons.person)
                      : null,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    request.order!.customer!.name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Divider(),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: request.deliveryMan!.avatar != null
                      ? NetworkImage(request.deliveryMan!.avatar!)
                      : null,
                  radius: 20.r,
                  child: request.deliveryMan!.avatar == null
                      ? Icon(Icons.delivery_dining)
                      : null,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.deliveryMan!.name!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        request.deliveryMan!.email!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            request.status == "pending"
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          onApprove();
                        },
                        child: Text(
                          "Approve",
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      TextButton(
                        onPressed: () {
                          onDecline();
                        },
                        child: Text(
                          "Decline",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
