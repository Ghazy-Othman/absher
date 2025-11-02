import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/constants/api_constants.dart';
import 'package:mobile/pages/product/product_view_page.dart';

class DiscountProductCard extends StatelessWidget {
  final int id;

  final String name;
  final String imagePath;
  final double originalPrice;
  final double currentPrice;
  final String discount;

  const DiscountProductCard({
    super.key,
    required this.id,
    required this.name,
    required this.imagePath,
    required this.originalPrice,
    required this.currentPrice,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => ProductViewPage(productId: id)),
        );
      },
      child: Container(
        width: 140.w,
        margin: EdgeInsets.only(right: 12.w),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product image
                  Container(
                    height: 100.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.network(imagePath, fit: BoxFit.cover)
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    name,
                    style: TextStyle(fontSize: 12.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "\$${originalPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Text(
                    "\$${currentPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            // Discount label
            Positioned(
              top: 8.h,
              right: 8.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  discount,
                  style: TextStyle(fontSize: 10.sp, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
