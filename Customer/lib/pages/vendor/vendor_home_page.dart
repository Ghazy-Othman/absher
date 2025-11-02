import 'package:flutter/material.dart';
import 'package:mobile/widgets/vendor/vendor_home_product_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VendorHomePage extends StatelessWidget {
  const VendorHomePage({super.key});

  final List<Map<String, String>> demoProducts = const [
    {'name': 'ASUS Gaming Laptop', 'image': 'assets/products/product_2.jpg'},
    {'name': 'Smart Watch', 'image': 'assets/products/product_7.jpg'},
    {'name': 'LED Monitor', 'image': 'assets/products/product_1.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(12.w),
      itemCount: demoProducts.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: VendorHomeProductCard(
            navToProductPage: true,
            name: demoProducts[index]['name']!,
            imagePath: demoProducts[index]['image']!,
          ),
        );
      },
    );
  }
}
