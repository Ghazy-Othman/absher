import 'package:delivery_man/constants/images_constants.dart';
import 'package:delivery_man/screens/sign_up_pages/controller/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DriverLicensePhotoStep extends StatelessWidget {
  final VoidCallback onNext;

  const DriverLicensePhotoStep({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RegisterController>();

    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Driver License Photo',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: 20.h),

          // Preview
          Obx(() {
            return Container(
              width: double.infinity,
              height: 200.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade300),
                image: DecorationImage(
                  image: controller.driverLicensePhoto.value != null
                      ? FileImage(controller.driverLicensePhoto.value!)
                      : AssetImage(ImagesConstants.drivingLicenseCard)
                  as ImageProvider,
                  fit: BoxFit.contain,
                ),
              ),
            );
          }),

          SizedBox(height: 20.h),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                size: 20.sp,
                color: Colors.orange,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Ensure the license is not expired, and the details are readable in the photo.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),

          SizedBox(height: 30.h),

          // Upload button
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton.icon(
              onPressed: () => controller.pickDriverLicensePhoto(),
              icon: const Icon(Icons.upload, color: Colors.white),
              label: Text(
                'Upload License Photo',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),

          SizedBox(height: 16.h),

          // Next button
          Obx(() {
            final isUploaded = controller.driverLicensePhoto.value != null;
            return SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                onPressed: isUploaded ? onNext : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  isUploaded ? Theme.of(context).primaryColor : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Next',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: Colors.white),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
