//
import 'package:delivery_man/constants/images_constants.dart';
import 'package:delivery_man/screens/sign_up_pages/controller/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class IDCardPhotoStep extends StatelessWidget {
  final VoidCallback onNext;

  const IDCardPhotoStep({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RegisterController>();

    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Identification Card Photo',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: 20.h),

          /// Image preview
          Obx(() => Container(
            width: double.infinity,
            height: 200.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade300),
              image: DecorationImage(
                image: controller.idCardPhoto.value != null
                    ? FileImage(controller.idCardPhoto.value!)
                    : AssetImage(ImagesConstants.idCard)
                as ImageProvider,
                fit: BoxFit.contain,
              ),
            ),
          )),

          SizedBox(height: 20.h),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline,
                  size: 20.sp, color: Theme.of(context).primaryColor),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Make sure your ID is clearly visible and not blurry. '
                      'Avoid glare and shadows.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 30.h),

          /// Upload button
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton.icon(
              onPressed: () => controller.pickIdCardPhoto(),
              icon: const Icon(Icons.upload, color: Colors.white),
              label: Text(
                'Upload ID Photo',
                style: TextStyle(fontSize: 14.sp, color: Colors.white),
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

          /// Next button
          Obx(() => SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: controller.idCardPhoto.value != null ? onNext : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: controller.idCardPhoto.value != null
                    ? Theme.of(context).primaryColorDark
                    : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Next',
                style: TextStyle(fontSize: 14.sp, color: Colors.white),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
