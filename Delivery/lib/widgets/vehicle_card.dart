import 'package:delivery_man/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VehicleCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final bool selected;

  const VehicleCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: selected ? theme.colorScheme.primary : theme.dividerColor,
          width: 2,
        ),
        color: selected
            ? theme.colorScheme.primary
            : theme.colorScheme.surface,
      ),
      child: Row(
        children: [
          // Text Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: selected ? Colors.black : theme.colorScheme.primary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 13.sp,
                    color: theme.colorScheme.onSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),

          SizedBox(width: 12.w),

          // Image Section
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: selected ? Colors.black : AppTheme.primaryBlue),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
