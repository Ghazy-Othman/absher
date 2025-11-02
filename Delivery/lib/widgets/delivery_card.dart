//
//
//
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryCard extends StatelessWidget {
  final String vendor;
  final double earning;

  const DeliveryCard({super.key, required this.vendor, required this.earning});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24.r,
            backgroundColor: Colors.green.shade100,
            child: Icon(Icons.store, color: Colors.green),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              vendor,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            "${earning.toStringAsFixed(2)} SP",
            style: TextStyle(fontSize: 15.sp, color: Colors.green.shade700),
          ),
        ],
      ),
    );
  }
}
