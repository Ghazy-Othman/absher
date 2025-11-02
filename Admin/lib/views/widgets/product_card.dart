//
//
//
import 'package:admin/constants/api_constants.dart';
import 'package:admin/models/product.dart';
import 'package:admin/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                color: AppTheme.divider,
                borderRadius: BorderRadius.circular(8.r),
                image: product.image != null
                    ? DecorationImage(
                        image: NetworkImage(
                          product.image!.startsWith("http")
                              ? product.image!
                              : "${ApiConstant.baseUrl.replaceFirst("api/v1", "storage")}/${product.image!}",
                        ),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: product.image == null
                  ? Icon(Icons.photo, size: 32.r, color: AppTheme.primaryBlue)
                  : null,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name!,
                    style: theme.textTheme.bodyLarge?.copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    '\$${product.price}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.r,
              color: AppTheme.primaryBlue,
            ),
          ],
        ),
      ),
    );
  }
}
