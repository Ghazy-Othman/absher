//
//
//
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryGrid extends StatelessWidget {
  final List<String> categories;
  final List<String> selectedCategories;
  final Function(String) onTap;

  const CategoryGrid({
    super.key,
    required this.categories,
    required this.selectedCategories,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: categories.map((category) {
        final isSelected = selectedCategories.contains(category);
        return GestureDetector(
          onTap: () => onTap(category),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: isSelected ? Colors.lightGreen : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              category,
              style: TextStyle(
                fontSize: 14.sp,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
