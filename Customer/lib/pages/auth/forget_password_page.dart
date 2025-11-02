//
//
//
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile/pages/auth/controller/forget_password_controller.dart';
import 'package:mobile/theme/app_theme.dart';
import 'package:mobile/widgets/custom_text_field.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password', style: theme.textTheme.titleLarge),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.h),
            Text('Enter your email to receive a reset code',
                style: TextStyle(
                  color: AppTheme.primaryBlue
                )),
            SizedBox(height: 20.h),
            CustomTextField(
              label: 'Email',
              hint: 'you@example.com',
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20.h),
            Obx(() {
              return SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value ? null : controller.requestOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text('Send Reset Code', style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
