import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/pages/categories_page.dart';
import 'package:mobile/pages/single_category_page.dart';

class SecondSectionWidget extends StatelessWidget {
  const SecondSectionWidget({super.key});

  final List<Map<String, dynamic>> categories = const [
    {'name': 'Fashion', 'icon': Icons.checkroom},
    {'name': 'Sport', 'icon': Icons.sports_soccer},
    {'name': 'Smartphone', 'icon': Icons.smartphone},
    {'name': 'Electronic', 'icon': Icons.electrical_services},
    {'name': 'Health', 'icon': Icons.health_and_safety},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(context, "Categories"),
        SizedBox(
          height: 70.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            itemCount: categories.length,
            itemBuilder: (context, index) {
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
                  width: 70.w,
                  margin: EdgeInsets.only(right: 12.w),
                  decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    categories[index]['icon'],
                    color: Colors.white,
                    size: 32.sp,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTitle(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoriesPage(categories: categories),
                ),
              );
            },
            child: Text("View All", style: TextStyle(fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }
}
