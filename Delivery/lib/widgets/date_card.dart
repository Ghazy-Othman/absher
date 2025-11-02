//
//
//

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateCard extends StatelessWidget {
  final String date;
  final bool isToday;
  final VoidCallback onPrevious;
  final VoidCallback? onNext;

  const DateCard({
    super.key,
    required this.date,
    required this.isToday,
    required this.onPrevious,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: onPrevious,
              icon: Icon(Icons.arrow_back_ios, size: 18.sp),
            ),
            SizedBox(width: 12.w),
            Text(
              date,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 12.w),
            IconButton(
              onPressed: onNext,
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 18.sp,
                color: isToday ? Colors.grey : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
