import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/pages/payment_page.dart';

class CreateOrderPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems = [
    {
      'image': 'assets/products/product_1.jpg',
      'name': 'Gaming Laptop',
      'quantity': 2,
      'cost': 799,
    },
    {
      'image': 'assets/products/product_2.jpg',
      'name': 'Wireless Mouse',
      'quantity': 1,
      'cost': 49,
    },
  ];

  final double deliveryCost = 5;

  CreateOrderPage({super.key});

  double getTotalCost() {
    double total = deliveryCost;
    for (var item in cartItems) {
      total += item['cost'] * item['quantity'];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    double total = getTotalCost();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Order",
          style: TextStyle(fontSize: 18.sp),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // Address
            TextField(
              decoration: InputDecoration(
                labelText: "Home Address",
                labelStyle: TextStyle(fontSize: 14.sp),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Order List Title
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Order List",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8.h),

            // Product List
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 6.h),
                    child: ListTile(
                      leading: Image.asset(
                        item['image'],
                        width: 50.w,
                        height: 50.h,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        item['name'],
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      subtitle: Text(
                        'Qty: ${item['quantity']}',
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      trailing: Text(
                        "\$${item['cost'] * item['quantity']}",
                        style: TextStyle(fontSize: 13.sp),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 8.h),

            // Delivery Cost
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Delivery: \$${deliveryCost.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
            SizedBox(height: 16.h),

            // Bottom Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total: \$${total.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PaymentPage(total: total),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    backgroundColor: Colors.lightGreen,
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(fontSize: 14.sp),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text("Pay", style: TextStyle(fontSize: 14.sp)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
