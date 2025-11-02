//
import 'dart:io';

//
import 'package:delivery_man/screens/sign_up_pages/controller/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfilePhotoStep extends StatelessWidget {
  final VoidCallback onNext;

  const ProfilePhotoStep({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RegisterController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Profile Photo',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20.h),

        // Image Preview or Placeholder
        Center(
          child: GestureDetector(
            onTap: () => controller.pickProfilePhoto(),
            child: Obx(
              () => Container(
                width: 150.w,
                height: 150.w,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Theme.of(context).dividerColor),
                  image: controller.profilePhoto.value != null
                      ? DecorationImage(
                          image: FileImage(
                            File(controller.profilePhoto.value!.path),
                          ),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                alignment: Alignment.center,
                child: controller.profilePhoto.value == null
                    ? Icon(
                        Icons.person,
                        size: 60.sp,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : null,
              ),
            ),
          ),
        ),
        SizedBox(height: 20.h),

        Row(
          children: [
            Icon(
              Icons.info_outline,
              color: Theme.of(context).colorScheme.primary,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                'Please upload a clear, front-facing photo of yourself.\n'
                'Avoid sunglasses or hats. Make sure your face is fully visible.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),

        // Upload Button
        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: ElevatedButton.icon(
            onPressed: () => controller.pickProfilePhoto(),
            icon: const Icon(Icons.upload_file),
            label: Text(
              'Upload Photo',
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(color: Colors.blue),
            ),
          ),
        ),
        SizedBox(height: 20.h),

        // Next Button
        Obx(
          () => SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: controller.profilePhoto.value != null ? onNext : null,
              child: const Text('Next'),
            ),
          ),
        ),
      ],
    );
  }
}
