//
//
//
import 'package:delivery_man/screens/sign_up_pages/controller/register_controller.dart';
import 'package:delivery_man/widgets/custom_text_field.dart';
import 'package:delivery_man/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GeneralInformationStep extends StatelessWidget {
  final VoidCallback onNext;

  const GeneralInformationStep({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RegisterController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Basic Information',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryBlue,
          ),
        ),
        SizedBox(height: 20.h),

        // Full Name
        CustomTextField(
          label: 'Full Name',
          hint: 'Enter your full name',
          controller: controller.nameController,
        ),
        SizedBox(height: 16.h),

        // Email
        CustomTextField(
          label: 'Email',
          hint: 'Enter your email address',
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 16.h),

        // Password
        CustomTextField(
          label: 'Password',
          hint: 'Enter your password',
          controller: controller.passwordController,
          keyboardType: TextInputType.visiblePassword,
        ),
        SizedBox(height: 16.h),

        // Gender Selector
        Text(
          'Gender',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppTheme.primaryBlue,
          ),
        ),
        SizedBox(height: 6.h),
        Obx(
          () => DropdownButtonFormField<String>(
            value: controller.selectedGender.value,
            items: controller.genders
                .map(
                  (gender) =>
                      DropdownMenuItem(value: gender, child: Text(gender)),
                )
                .toList(),
            onChanged: (value) => controller.selectedGender.value = value!,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.primaryBlue),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 14.h,
              ),
            ),
          ),
        ),
        SizedBox(height: 16.h),

        // National ID
        CustomTextField(
          label: 'National ID',
          hint: 'Enter your ID',
          controller: controller.nationalIdController,
        ),
        SizedBox(height: 16.h),

        // City Selector
        Text(
          'City',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppTheme.primaryBlue,
          ),
        ),

        SizedBox(height: 16.h),
        Obx(
          () => DropdownButtonFormField<String>(
            value: controller.selectedCity.value,
            items: controller.cities
                .map((city) => DropdownMenuItem(value: city, child: Text(city)))
                .toList(),
            onChanged: (value) => controller.selectedCity.value = value!,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.primaryBlue),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 14.h,
              ),
            ),
          ),
        ),
        SizedBox(height: 16.h),
        // Address ID
        CustomTextField(
          label: 'Address',
          hint: 'Enter your address',
          controller: controller.addressController,
        ),
        SizedBox(height: 16.h),
        // Terms Checkbox
        Obx(
          () => Row(
            children: [
              Checkbox(
                value: controller.agreed.value,
                activeColor: AppTheme.primaryBlue,
                onChanged: (value) => controller.agreed.value = value!,
              ),
              Expanded(
                child: Text(
                  "By accepting, you agree to the company terms and conditions",
                  style: TextStyle(fontSize: 12.sp),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),

        // Next Button
        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: Obx(
            () => ElevatedButton(
              onPressed: controller.agreed.value ? onNext : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Next',
                style: TextStyle(fontSize: 16.sp, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
