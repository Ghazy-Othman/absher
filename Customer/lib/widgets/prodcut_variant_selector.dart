import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/theme/app_theme.dart';

class VariantSelector extends StatefulWidget {
  const VariantSelector({super.key});

  @override
  State<VariantSelector> createState() => _VariantSelectorState();
}

class _VariantSelectorState extends State<VariantSelector> {
  final Map<String, List<String>> variants = {
    'Color': ['Red', 'Green', 'Blue', 'Black'],
  };

  Map<String, String> selected = {};

  @override
  void initState() {
    super.initState();
    selected = {for (var key in variants.keys) key: variants[key]!.first};
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Variant',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.h),
        ...variants.entries.map((entry) {
          final key = entry.key;
          final values = entry.value;

          return Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$key: ${selected[key]}",
                  style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                ),
                SizedBox(height: 8.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: values.map((value) {
                    final isSelected = selected[key] == value;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selected[key] = value;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? AppTheme.accentBlue : Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Text(
                          value,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontSize: 13.sp,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
