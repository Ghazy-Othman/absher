import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/pages/nav_controller.dart';
import 'package:mobile/pages/product/controller/product_controller.dart';
import 'package:mobile/theme/app_theme.dart';
import 'package:mobile/widgets/prodcut_information.dart';
import 'package:mobile/widgets/prodcut_variant_selector.dart';
import 'package:mobile/widgets/related_product_card.dart';

class ProductViewPage extends StatelessWidget {
  final int productId;

  ProductViewPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    //
    final ProductController controller = Get.put(
      ProductController(),
      tag: productId.toString(),
    );

    // Fetch product only once per page
    if (!controller.isInitialized) {
      controller.fetchProduct(productId);
      controller.isInitialized = true;
    }

    final screenHeight = MediaQuery.of(context).size.height.h;
    final lightGreen = AppTheme.accentBlue;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              bottomIndex.value = 2;
              Navigator.pop(context);
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.errorMessage.isNotEmpty ||
            controller.product.value == null) {
          return RefreshIndicator(
            onRefresh: () async {
              await controller.fetchProduct(productId);
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                Center(
                  child: controller.errorMessage.isNotEmpty
                      ? Text(controller.errorMessage.value)
                      : const Text("No product with this id"),
                ),
              ],
            ),
          );
        }

        final product = controller.product.value;
        if (product == null) {
          return const Center(child: Text("No product found"));
        }
        print("=====");
        print(product.vendor);
        print("=====");
        return Stack(
          children: [
            ListView(
              padding: EdgeInsets.only(bottom: 80.h),
              children: [
                // Product Image
                SizedBox(
                  height: screenHeight * 0.5,
                  width: double.infinity,
                  child: product.getImage.isNotEmpty
                      ? Image.network(product.getImage)
                      : const Icon(Icons.production_quantity_limits),
                ),

                // Product Info Section
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Cost & Favorite Icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$${product.price}",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Icon(Icons.star, color: Colors.grey),
                        ],
                      ),

                      // Product Name
                      Text(
                        product.name ?? "product name",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      SizedBox(height: 8.h),

                      Text(
                        "${Random().nextInt(10000)}k sold",
                        style: TextStyle(fontSize: 13.sp, color: Colors.grey),
                      ),

                      GestureDetector(
                        onTap: () {
                          // Vendor profile navigation (future feature)
                        },
                        child: Text(
                          'By: ${product.vendor?.name}',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: AppTheme.primaryBlue,
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Description Section
                      Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        product.description ?? "product description",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),

                      SizedBox(height: 32.h),
                      const VariantSelector(),
                      SizedBox(height: 24.h),
                      const ProductInformation(),
                      SizedBox(height: 24.h),

                      // Related Products Section
                      Text(
                        "Related Products",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12.h),

                      SizedBox(
                        height: 220.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.relatedProducts.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(right: 12.w),
                              child: RelatedProductCard(
                                product: controller.relatedProducts[index],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Add to Cart Button
            Positioned(
              bottom: 16.h,
              left: 16.w,
              right: 16.w,
              child: SizedBox(
                height: 48.h,
                child: OutlinedButton(
                  onPressed: () {
                    controller.addProductToCart(productId);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppTheme.primaryBlue),
                    foregroundColor: lightGreen,
                    backgroundColor: Colors.white,
                    textStyle: TextStyle(fontSize: 16.sp),
                  ),
                  child: const Text("Add to Cart"),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
