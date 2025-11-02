import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/pages/vendor/vendor_update_product_page.dart';

class VendorHomeProductCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final bool navToProductPage;

  const VendorHomeProductCard({
    super.key,
    required this.name,
    required this.imagePath,
    required this.navToProductPage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (navToProductPage) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => VendorUpdateProductPage(
                product: {
                  'name': name,
                  'image': imagePath,
                  'cost': 154,
                  'description': "Some text",
                  'discount': 55,
                },
              ),
            ),
          );
        }
      },
      child: Container(
        height: 80.h,
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.lightGreen, width: 1.w),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.asset(
                imagePath,
                width: 80.w,
                height: 80.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
