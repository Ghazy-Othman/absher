import 'package:admin/theme/app_theme.dart';
import 'package:admin/views/my_products/add_product_page.dart';
import 'package:admin/views/my_products/controller/my_products_page_controller.dart';
import 'package:admin/views/my_products/product_details_page.dart';
import 'package:admin/views/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyProductsPage extends StatelessWidget {
  const MyProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyProductsController());
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Products', style: theme.textTheme.titleLarge),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.products.isEmpty) {
          return RefreshIndicator(
            onRefresh: controller.fetchProducts,
            child: ListView(
              physics: AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(height: 50.h),
                Center(
                  child: Text(
                    'No products yet',
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.fetchProducts,
          child: ListView.separated(
            padding: EdgeInsets.all(12.w),
            itemCount: controller.products.length,
            separatorBuilder: (_, __) => SizedBox(height: 8.h),
            itemBuilder: (context, index) {
              final product = controller.products[index];
              return ProductCard(
                product: product,
                onTap: () {
                  Get.to(() => ProductDetailsPage(productId: product.id!));
                },
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primaryBlue,
        onPressed: () => Get.to(() => const AddProductPage()),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
