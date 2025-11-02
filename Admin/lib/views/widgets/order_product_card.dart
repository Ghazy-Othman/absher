//
//
//
import 'package:admin/constants/api_constants.dart';
import 'package:admin/models/cart.dart';
import 'package:admin/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderProductCard extends StatelessWidget {
  final CartItem item;

  const OrderProductCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 6.h),
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Row(
          children: [

            ///TODO
            /// Product image placeholder
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: item.product.image != null
                  ? Image.network(
                item.product.image!.startsWith("products/") ? "${ApiConstant
                    .baseUrl.replaceFirst("api/v1", "")}storage/${item.product
                    .image}" : item.product.image!,
                fit:BoxFit.fill,
              )
                  : Icon(Icons.shopping_bag, color: AppTheme.darkBlue),
            ),
            SizedBox(width: 12.w),

            /// Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.name ?? "Product Name",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Quantity: ${item.quantity}",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ],
              ),
            ),

            /// Price
            Text(
              "\$${item.totalPrice}",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: AppTheme.accentBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
