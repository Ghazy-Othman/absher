//
//
//
import 'package:admin/constants/api_constants.dart';
import 'package:admin/theme/app_theme.dart';
import 'package:admin/views/my_products/controller/product_deatils_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductDetailsPage extends StatelessWidget {
  final int productId;

  const ProductDetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductDetailsController(productId));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details', style: theme.textTheme.titleLarge),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              final confirmed =
                  await Get.dialog<bool>(
                    AlertDialog(
                      title: const Text('Delete product?'),
                      content: const Text('This action cannot be undone.'),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(result: false),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () => Get.back(result: true),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  ) ??
                  false;
              if (confirmed) {
                final res = await controller.deleteProduct();
                if (res) {
                  Get.back();
                }
              }
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final product = controller.product.value;
        if (product == null) {
          return RefreshIndicator(
            onRefresh: controller.fetchProduct,
            child: ListView(
              physics: AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(height: 50.h),
                Center(
                  child: Text(
                    'Product not found',
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 220.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.divider,
                  borderRadius: BorderRadius.circular(8.r),
                  image: product.image != null
                      ? DecorationImage(
                          image: NetworkImage(
                            product.image!.startsWith("products/") ? "${ApiConstant
                              .baseUrl.replaceFirst("api/v1", "")}storage/${product
                              .image}" : product.image!,),
                          fit: BoxFit.fill,
                        )
                      : null,
                ),
                child: product.image == null
                    ? Icon(Icons.photo, size: 64.r, color: AppTheme.primaryBlue)
                    : null,
              ),
              SizedBox(height: 16.h),
              Text(
                product.name!,
                style: theme.textTheme.titleLarge?.copyWith(fontSize: 20.sp),
              ),
              SizedBox(height: 8.h),
              Text('\$${product.price!}', style: theme.textTheme.bodyLarge),
              SizedBox(height: 12.h),
              Text(
                'Category ID: ${product.categoryId}',
                style: theme.textTheme.bodyMedium,
              ),
              SizedBox(height: 12.h),
              Text(product.description!, style: theme.textTheme.bodyMedium),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryBlue,
                  ),
                  onPressed: () =>
                      _showEditDialog(context, controller, product),
                  child: const Text('Edit Product'),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _showEditDialog(
    BuildContext context,
    ProductDetailsController controller,
    dynamic p,
  ) {
    final nameCtrl = TextEditingController(text: p.name);
    final priceCtrl = TextEditingController(text: p.price.toString());
    final descCtrl = TextEditingController(text: p.description);
    final catCtrl = TextEditingController(text: p.categoryId.toString());

    Get.dialog(
      AlertDialog(
        title: const Text('Edit Product'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: priceCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Price'),
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: catCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Category ID'),
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: descCtrl,
                maxLines: 4,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryBlue,
            ),
            onPressed: () async {
              final data = {
                'name': nameCtrl.text,
                'price': double.tryParse(priceCtrl.text) ?? 0.0,
                'description': descCtrl.text,
                'category_id': int.tryParse(catCtrl.text) ?? 0,
              };
              await controller.updateProduct(data);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
