import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/pages/categories_page.dart';
import 'package:mobile/pages/singl_category_page/single_category_page.dart';
import 'package:mobile/theme/app_theme.dart';

class CategoryGridSection extends StatelessWidget {
  const CategoryGridSection({super.key, required this.categories});

  final List<Map<String, dynamic>> categories;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Categories",
                style: TextStyle(
                  fontSize: 18.sp,
                  color: AppTheme.primaryBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.of(context).push(
              //       MaterialPageRoute(builder: (_) =>  CategoriesPage(categories: categories,)),
              //     );
              //   },
              //   child: Text(
              //     "View All",
              //     style: TextStyle(
              //       fontSize: 12.sp,
              //       color: AppTheme.accentBlue,
              //       fontWeight: FontWeight.w500,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        SizedBox(height: 12.h),

        // Grid of Categories
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: categories.length.clamp(0, 8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 12.w,
              childAspectRatio: 0.9,
            ),
            itemBuilder: (context, index) {
              final item = categories[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SingleCategoryPage(title: item['name'] , categoryId: item['id'],),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.all(8.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(item["icon"], size: 24.sp, color: Colors.black87),
                      SizedBox(height: 8.h),
                      Text(
                        item["name"],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
