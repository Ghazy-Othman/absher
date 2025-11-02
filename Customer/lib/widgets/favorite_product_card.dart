import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteProductCard extends StatelessWidget {
  const FavoriteProductCard({super.key, required this.product});

  final Map<String, String> product;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          children: [
            Row(
              children: [
                // Product Image
                SizedBox(
                  width: 80.w,
                  height: 80.h,
                  child: Image(image: AssetImage(product['image'] ?? "")),
                ),
                SizedBox(width: 12.w),
                //
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['name'] ?? "",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "\$${product['cost']}",
                        style: TextStyle(fontSize: 14.sp, color: Colors.green),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Sold: ${Random().nextInt(11111) + 100}",
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      ),
                      SizedBox(height: 12.h),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red, size: 24.sp),
                  onPressed: () {},
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                    ),
                    child: Text(
                      "Add To Cart",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
