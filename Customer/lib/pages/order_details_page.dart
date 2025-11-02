import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class OrderDetailsPage extends StatelessWidget {
//   const OrderDetailsPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     /// TODO : Remove demo data and integrate with API
//     final products = [
//       {
//         'name': 'Gaming Laptop',
//         'cost': 1200,
//         'quantity': 1,
//         'image': 'assets/products/product_1.jpg',
//       },
//       {
//         'name': 'Smart Watch',
//         'cost': 200,
//         'quantity': 2,
//         'image': 'assets/products/product_7.jpg',
//       },
//     ];
//
//     return Scaffold(
//       appBar: AppBar(title: const Text("Order Details")),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// Order Status
//             _buildSectionTitle("Order Info"),
//             SizedBox(height: 8.h),
//             _infoRow("Status", "Delivered"),
//             _infoRow("Order ID", "#ORD001"),
//             _infoRow("Date", "2025-06-22 13:45"),
//             SizedBox(height: 16.h),
//
//             /// Delivery Info
//             _buildSectionTitle("Delivery Details"),
//             SizedBox(height: 8.h),
//             _infoRow("Delivery", "Home Delivery"),
//             _infoRow("Address", "123 Main Street, NY, USA"),
//             SizedBox(height: 16.h),
//
//             /// Payment Info
//             _buildSectionTitle("Payment Information"),
//             SizedBox(height: 8.h),
//             _infoRow("Method", "Credit Card"),
//             _infoRow("Total Price", "\$1600"),
//             SizedBox(height: 16.h),
//
//             /// Products List
//             _buildSectionTitle("Products"),
//             SizedBox(height: 12.h),
//             ...products.map((p) => _buildProductCard(p)).toList(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _infoRow(String key, String value) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 4.h),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             key,
//             style: TextStyle(color: Colors.grey, fontSize: 14.sp),
//           ),
//           Text(
//             value,
//             style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSectionTitle(String title) {
//     return Text(
//       title,
//       style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
//     );
//   }
//
//   Widget _buildProductCard(Map<String, dynamic> product) {
//     final total = product['cost'] * product['quantity'];
//     return Card(
//       margin: EdgeInsets.only(bottom: 12.h),
//       child: Padding(
//         padding: EdgeInsets.all(12.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Image.asset(
//                   product['image'],
//                   width: 60.w,
//                   height: 60.h,
//                   fit: BoxFit.cover,
//                 ),
//                 SizedBox(width: 12.w),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         product['name'],
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16.sp,
//                         ),
//                       ),
//                       SizedBox(height: 4.h),
//                       Text(
//                         "Price: \$${product['cost']}",
//                         style: TextStyle(fontSize: 14.sp),
//                       ),
//                       Text(
//                         "Quantity: ${product['quantity']}",
//                         style: TextStyle(fontSize: 14.sp),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             Divider(height: 20.h, thickness: 1.h),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Total Price",
//                   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
//                 ),
//                 Text(
//                   "\$$total",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
