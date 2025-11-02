import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile/pages/singl_category_page/single_category_page_controller.dart';
import 'package:mobile/widgets/ads_slider.dart';
import 'package:mobile/widgets/first_section.dart';
import 'package:mobile/widgets/recommended_section.dart';

class SingleCategoryPage extends StatelessWidget {
  const SingleCategoryPage({super.key, required this.title, required this.categoryId});

  final String title;
  final int categoryId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SingleCategoryController(categoryId: categoryId));

    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(fontSize: 18.sp)),
        toolbarHeight: 56.h,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16.h),
              const AdsSlider(),
              SizedBox(height: 16.h),

              // Example usage of fetched products
              FirstSectionWidget(
                sectionTitle: "Trending",
                products: controller.products.take(5).toList(),
              ),
              SizedBox(height: 16.h),

              FirstSectionWidget(
                sectionTitle: "New Products",
                products: controller.products.take(3).toList(),
                hasPrice: true,
                price: controller.products.isNotEmpty ? controller.products[0].price : 0,
              ),
              SizedBox(height: 16.h),

              RecommendedSectionWidget(
                sectionTitle: "All Products",
                products: controller.products,
              ),
              SizedBox(height: 100.h), // Space for bottom nav
            ],
          ),
        );
      }),
    );
  }
}
