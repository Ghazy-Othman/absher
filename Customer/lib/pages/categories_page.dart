import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/pages/single_category_page.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key, required this.categories});

  final List<Map<String, dynamic>> categories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories', style: TextStyle(fontSize: 20.sp)),
        backgroundColor: Colors.lightGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16.r),
        itemCount: categories.length,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SingleCategoryPage(title: categories[index]['name']),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
              decoration: BoxDecoration(
                color: Colors.lightGreen[200],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Icon(category['icon'], color: Colors.lightGreen, size: 24.sp),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Text(
                      category['name'],
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16.sp,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
