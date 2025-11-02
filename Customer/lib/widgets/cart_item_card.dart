//
//
//
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/models/cart.dart';
import 'package:mobile/theme/app_theme.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onDelete;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => Get.to(() => ProductDetailsPage(product: item.product)),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: null,
              // Image.network(
              //   item.product.image,
              //   width: 60.w,
              //   height: 60.w,
              //   fit: BoxFit.cover,
              // ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product!.name!,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryText,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    ///TODO
                    "Total: \$${5}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppTheme.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: onDecrease,
                      icon: Icon(
                        Icons.remove_circle_outline,
                        color: AppTheme.primaryBlue,
                      ),
                      iconSize: 22.sp,
                    ),
                    Text(
                      "${item.quantity}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    IconButton(
                      onPressed: onIncrease,
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: AppTheme.primaryBlue,
                      ),
                      iconSize: 22.sp,
                    ),
                  ],
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: Icon(Icons.delete_outline, color: Colors.red),
                  iconSize: 22.sp,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
