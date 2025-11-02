//
//
//
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mobile/pages/carts/cart_details_page.dart';
import '../models/cart.dart';
import '../../../theme/app_theme.dart';

class CartCard extends StatelessWidget {
  final Cart cart;
  final Callback onLongPress;

  const CartCard({super.key, required this.cart, required this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => CartDetailsPage(cartId: cart.id!));
      },
      onLongPress: onLongPress,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        color: Colors.white,
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24.r,
                backgroundColor: AppTheme.accentBlue,
                child: Icon(Icons.store, color: Colors.white, size: 20.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cart.vendor!.name!,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryText,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      cart.vendor!.address ?? "Address",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppTheme.secondaryText,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      "${cart.items!.length} items - \$${cart.totalPrice.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.primaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
