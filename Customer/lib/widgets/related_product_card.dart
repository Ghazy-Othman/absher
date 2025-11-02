import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile/models/product.dart';
import 'package:mobile/pages/product/product_view_page.dart';

class RelatedProductCard extends StatelessWidget {
  const RelatedProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (product.id != null) {
          Get.to(() => ProductViewPage(productId: product.id!));
        }
      },
      child: Container(
        width: 140.w,
        height: 220.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: 110.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              ),
              child: product.getImage.isNotEmpty
                  ? Image.network(product.getImage, fit: BoxFit.cover)
                  : const Icon(Icons.image),
            ),

            // Product Name
            Padding(
              padding: EdgeInsets.fromLTRB(8.w, 12.h, 8.w, 4.h),
              child: Text(
                product.name ?? "product name",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14.sp),
              ),
            ),

            // Price
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                '\$${product.price}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
