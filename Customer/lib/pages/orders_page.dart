import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'order_details_page.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = List.generate(5, (index) {
      return {
        'status': 'Delivered',
        'totalCost': '\$${(50 + index * 20)}',
        'productCount': '${index + 1} items',
        'date': '2025-06-22',
        'id': '#ORD00$index',
      };
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Orders")),
      body: ListView.builder(
        padding: EdgeInsets.all(12.w),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (_) => const OrderDetailsPage()),
              // );
            },
            child: Card(
              margin: EdgeInsets.only(bottom: 12.h),
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Status: ${order['status']}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Total Cost: ${order['totalCost']}",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    Text(
                      "Products: ${order['productCount']}",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    Text(
                      "Date: ${order['date']}",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
