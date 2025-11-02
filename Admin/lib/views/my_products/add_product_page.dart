import 'dart:io';
import 'package:admin/theme/app_theme.dart';
import 'package:admin/views/my_products/controller/add_product_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(AddProductController());
    final theme = Theme.of(context);

    final cats = [
      "fashion",
      "sport",
      "smart_phones",
      "food",
      "electronic",
      "gaming",
      "books",
      "health"
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('New Product', style: theme.textTheme.titleLarge),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: c.pickImage,
                child: Container(
                  height: 180.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppTheme.divider,
                  ),
                  child: c.imageFile.value == null
                      ? Center(
                    child: Icon(
                      Icons.photo_camera,
                      size: 48.r,
                      color: AppTheme.primaryBlue,
                    ),
                  )
                      : Image.file(
                    File(c.imageFile.value!.path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              TextField(
                onChanged: (v) => c.name.value = v,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              SizedBox(height: 8.h),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (v) => c.price.value = double.tryParse(v) ?? 0.0,
                decoration: const InputDecoration(labelText: 'Price'),
              ),
              SizedBox(height: 8.h),
              Text('Select Category', style: theme.textTheme.titleMedium),
              SizedBox(height: 8.h),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
                  mainAxisSpacing: 8.h,
                  crossAxisSpacing: 8.w,
                  childAspectRatio: 3,
                ),
                itemCount: cats.length,
                itemBuilder: (context, index) {
                  return Obx(() => GestureDetector(
                    onTap: () {
                      c.categoryId.value = index;
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: c.categoryId.value == index
                            ? AppTheme.primaryBlue
                            : AppTheme.divider,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        cats[index],
                        style: TextStyle(
                          color: c.categoryId.value == index
                              ? Colors.white
                              : AppTheme.primaryText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ));
                },
              ),

              SizedBox(height: 8.h),
              TextField(
                onChanged: (v) => c.description.value = v,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 4,
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryBlue,
                  ),
                  onPressed: c.isLoading.value ? null : c.addProduct,
                  child: c.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Add Product'),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
