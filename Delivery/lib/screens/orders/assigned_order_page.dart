import 'package:delivery_man/models/delivery_request.dart';
import 'package:delivery_man/models/order.dart';
import 'package:delivery_man/models/user.dart';
import 'package:delivery_man/screens/orders/controller/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssignedOrderPage extends StatelessWidget {
  AssignedOrderPage({super.key});

  final OrdersController controller = Get.find<OrdersController>();

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
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Obx(() {
          final DeliveryRequest req = controller.currentRequest.value!;
          final Order order = req.order;

          return RefreshIndicator(
            onRefresh: controller.fetchOrders,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1) Request info component
                  _requestCard(req),

                  SizedBox(height: 12.h),
                  //
                  // 2) Order info (no cart details)
                  _orderCard(order),
                  //
                  SizedBox(height: 12.h),
                  //
                  // // 3) Vendor & Customer components side by side (responsive: column on small width)
                  _vendorCustomerRow(
                    order.vendor!,
                    "vendor",
                    order.pickupAddress ?? "-",
                  ),
                  //
                  SizedBox(height: 16.h),
                  //
                  _vendorCustomerRow(
                    order.customer!,
                    "customer",
                    order.deliveryAddress ?? "-",
                  ),
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
                  ...?order.cart?.items
                      .map((cartItem) => _productCard(cartItem))
                      .toList(),
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
  Widget _requestCard(DeliveryRequest req) {
    final color = statusColor(req.status);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Request #${req.id}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'Created: ${_formatDate(req.createdAt)}',
                    style: TextStyle(fontSize: 13.sp),
                  ),
                  SizedBox(height: 6.h),
                  req.status.toLowerCase() == "pending"
                      ? InkWell(
                          onTap: () {
                            controller.cancelRequest(req.id);
                          },
                          child: Text(
                            'Cancel Request',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.red,
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: color, width: 1.w),
              ),
              child: Text(
                req.status.toUpperCase(),
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
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
            SizedBox(height: 6.h),
            order.status == "assigned"
                ? InkWell(
                    onTap: () {
                      controller.cancelOrder(
                        order.id,
                        controller.currentRequest.value!.id,
                      );
                    },
                    child: Text(
                      "Cancel Order",
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                : SizedBox(),
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
                  (user.avatar != null && user.avatarPath!.isNotEmpty)
                  ? NetworkImage(user.image) as ImageProvider
                  : null,
              child: (user.avatar == null || user.avatar!.isEmpty)
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
  Widget _userCard(String title, String? name, String? email, String? avatar) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28.r,
              backgroundImage: avatar != null
                  ? NetworkImage(avatar) as ImageProvider
                  : null,
              child: avatar == null ? Icon(Icons.person, size: 20.sp) : null,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    name ?? '-',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    email ?? '-',
                    style: TextStyle(fontSize: 13.sp, color: Colors.grey[700]),
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
}
