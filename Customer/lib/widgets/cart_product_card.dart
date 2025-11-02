import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartProductCard extends StatefulWidget {
  const CartProductCard({super.key, required this.product});

  final Map<String, String> product;

  @override
  State<CartProductCard> createState() => _CartProductCardState();
}

class _CartProductCardState extends State<CartProductCard> {
  int quantity = 1;
  final double unitPrice = 49.99;

  void _increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double totalPrice = unitPrice * quantity;

    return Card(
      elevation: 3,
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            // Product image
            SizedBox(
              width: 80.w,
              height: 80.h,
              child: Image.asset(widget.product['image'] ?? ""),
            ),
            SizedBox(width: 12.w),
            //
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product['name'] ?? "",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    "Quantity: $quantity",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    "Total: \$${totalPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red, size: 24.sp),
                        onPressed: () {
                          //
                        },
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.remove, size: 24.sp),
                        onPressed: _decreaseQuantity,
                      ),
                      IconButton(
                        icon: Icon(Icons.add, size: 24.sp),
                        onPressed: _increaseQuantity,
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
}
