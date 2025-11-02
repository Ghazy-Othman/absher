import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile/pages/home/controller/home_controller.dart';
import 'package:mobile/theme/app_theme.dart';
import 'package:mobile/widgets/ads_slider.dart';
import 'package:mobile/widgets/categories_grid.dart';
import 'package:mobile/widgets/first_section.dart';
import 'package:mobile/widgets/flash_sale_section.dart';
import 'package:mobile/widgets/recommended_section.dart';
import 'package:mobile/widgets/trending_products_section.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      ///
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      if (controller.errorMessage.isNotEmpty) {
        return RefreshIndicator(
          onRefresh: () async {
            controller.getProducts();
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 200.h),
                  child: Text(controller.errorMessage.value),
                ),
              ),
            ],
          ),
        );
      }
      return Scaffold(
        appBar: AppBar(
          title: Text("Home", style: TextStyle(fontSize: 18.sp)),
          backgroundColor: AppTheme.darkBlue,
        ),
        body: RefreshIndicator(
          onRefresh: controller.getProducts,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 16.h),
                const AdsSlider(),
                SizedBox(height: 16.h),
                FlashSaleSection(
                  products: controller.flashProducts,
                  endTime: DateTime.now().add(Duration(hours: 3, minutes: 50)),
                ),
                SizedBox(height: 16.h),
                CategoryGridSection(
                  categories:
                      controller.categories,
                ),
                SizedBox(height: 16.h),
                TrendingProductsSection(products: controller.trendingProduct),
                SizedBox(height: 16.h),
                FirstSectionWidget(
                  sectionTitle: "Your Last Search",
                  products: controller.lastSearchProduct,
                ),
                SizedBox(height: 16.h),
                RecommendedSectionWidget(
                  sectionTitle: "Recommended",
                  products: controller.recommendedProduct,
                ),
                SizedBox(height: 100.h),
              ],
            ),
          ),
        ),
      );
    });
  }
}
