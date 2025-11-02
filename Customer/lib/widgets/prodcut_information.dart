import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductInformation extends StatelessWidget {
  const ProductInformation({super.key});

  final Map<String, String> attributes = const {
    'Weight': '1.2kg',
    'Material': 'Aluminum',
    'Warranty': '2 Years',
    'Origin': 'Germany',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Information',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.h),
        ...attributes.entries.map((e) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  e.key,
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[800]),
                ),
                Text(e.value, style: TextStyle(fontSize: 14.sp)),
              ],
            ),
          );
        }),
      ],
    );
  }
}
