//
//
//
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/models/order.dart';
import 'package:mobile/models/user.dart';
import 'package:mobile/pages/orders/controller/order_details_controller.dart';
import 'package:mobile/theme/app_theme.dart';

enum OtpMode { pickup, deliver }

class OrderDetailsPage extends StatelessWidget {
  OrderDetailsPage({super.key, required this.orderId});

  final int orderId;

  final OrderDetailsController controller = Get.put(OrderDetailsController());

  // status colors mapping
  final Map<String, Color> statusColors = {
    'pending': Colors.orange,
    'approved': Colors.green,
    'assigned': Colors.blue,
    'picked_up': Colors.purple,
    'published': Colors.teal,
    'delivered': Colors.greenAccent,
    'canceled': Colors.red,
  };

  Color statusColor(String status) {
    return statusColors[status.toLowerCase()] ?? Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    controller.getOrder(orderId);
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details", style: TextStyle(fontSize: 18.sp)),
        backgroundColor: AppTheme.darkBlue,
        actions: [
          Obx(() {
            if (controller.order.value == null) {
              return SizedBox();
            } else {
              final orderStatus = controller.order.value!.status.toLowerCase();
              if (orderStatus == 'picked_up') {
                return TextButton(
                  onPressed: () => {controller.generateDeliveryOtp(orderId)},
                  child: Text(
                    'Confirm delivery',
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            }
          }),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Obx(() {
          if (controller.isLoading.isTrue) {
            return Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                controller.getOrder(orderId);
              },
              child: ListView(
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 100.h),
                    child: Center(child: Text(controller.errorMessage.value)),
                  ),
                ],
              ),
            );
          }
          final Order order = controller.order.value!;
          return RefreshIndicator(
            onRefresh: () async {
              controller.getOrder(orderId);
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  _orderCard(order),
                  //
                  SizedBox(height: 12.h),
                  //
                  //
                  _vendorCustomerRow(
                    order.vendor!,
                    "vendor",
                    order.pickupAddress ?? "-",
                  ),
                  //
                  SizedBox(height: 16.h),
                  //
                  order.deliveryMan != null
                      ? _deliveryManRow(order.deliveryMan!)
                      : SizedBox(),
                  //
                  SizedBox(height: 16.h),

                  //
                  // 4) Products list (cards)
                  Text(
                    'Products',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  ...?order.cart?.items!.map(
                    (cartItem) => _productCard(cartItem),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  ///
  Widget _orderCard(Order order) {
    final color = statusColor(order.status);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Order #${order.id}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: color, width: 1.w),
                  ),
                  child: Text(
                    order.status.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            _infoRow('Created', _formatDate(order.createdAt)),
            SizedBox(height: 6.h),
            _infoRow('Total', '\$${order.total.toStringAsFixed(2)}'),
            SizedBox(height: 6.h),
            _infoRow(
              'Delivery cost',
              '\$${order.deliveryCost.toStringAsFixed(2)}',
            ),
            SizedBox(height: 6.h),
            _infoRow('Items count', '${order.itemsCount}'),
          ],
        ),
      ),
    );
  }

  ///
  Widget _deliveryManRow(User user) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 30.r,
              backgroundColor: Colors.grey.shade200,
              backgroundImage:
                  (user.avatarPath != null && user.avatarPath!.isNotEmpty)
                  ? NetworkImage(user.image) as ImageProvider
                  : null,
              child: (user.avatarPath == null || user.avatarPath!.isEmpty)
                  ? Icon(Icons.person, size: 24.sp, color: Colors.grey.shade700)
                  : null,
            ),

            SizedBox(width: 12.w),

            // Info column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    user.name,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),

                  // Email
                  Text(
                    user.email,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///
  Widget _vendorCustomerRow(User user, String role, String address) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 30.r,
              backgroundColor: Colors.grey.shade200,
              backgroundImage:
                  (user.avatarPath != null && user.avatarPath!.isNotEmpty)
                  ? NetworkImage(user.image!) as ImageProvider
                  : null,
              child: (user.avatarPath == null || user.avatarPath!.isEmpty)
                  ? Icon(Icons.person, size: 24.sp, color: Colors.grey.shade700)
                  : null,
            ),

            SizedBox(width: 12.w),

            // Info column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    user.name,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),

                  // Email
                  Text(
                    user.email,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: 8.h),

                  // Address row
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          role == "vendor" ? Icons.sell : Icons.person,
                          size: 16.sp,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              role == "vendor"
                                  ? "Pick up address"
                                  : "Delivery address",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              address.isNotEmpty ? address : '-',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///
  Widget _productCard(dynamic cartItem) {
    final product = cartItem.product;
    final qty = cartItem.quantity;
    final total = cartItem.totalPrice;
    final image = product.image;

    return Card(
      margin: EdgeInsets.only(bottom: 8.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Colors.grey[200],
                image: image != null
                    ? DecorationImage(
                        image: NetworkImage(image),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: image == null
                  ? Icon(Icons.image_not_supported, size: 24.sp)
                  : null,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name ?? '-',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text('Quantity: $qty', style: TextStyle(fontSize: 13.sp)),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              '\$${total.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  ///
  String _formatDate(DateTime dt) {
    // simple formatting
    return '${dt.year}-${_two(dt.month)}-${_two(dt.day)} ${_two(dt.hour)}:${_two(dt.minute)}';
  }

  ///
  String _two(int n) => n.toString().padLeft(2, '0');

  ///
  Widget _infoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: valueColor ?? Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///
  void _showOtpDialog(BuildContext context) {
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
                    'Generating Delivery OTP',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Obx(
                    () => controller.localError.value.isEmpty
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: EdgeInsets.only(top: 4.h, bottom: 8.h),
                            child: Text(
                              controller.localError.value,
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
                    return Text(controller.code.value);
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
