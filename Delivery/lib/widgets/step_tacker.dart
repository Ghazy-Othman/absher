import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StepTracker extends StatelessWidget {
  final int currentStep;

  const StepTracker({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(5, (index) {
        bool isActive = index <= currentStep;
        return Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: theme.colorScheme.primary),
            color: isActive ? theme.colorScheme.primary : Colors.transparent,
          ),
          child: Center(
            child: Text(
              isActive ? '${index + 1}' : '',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }),
    );
  }
}
