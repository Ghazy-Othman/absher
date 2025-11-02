//
//
//
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile/pages/auth/controller/verify_code_controller.dart';
import 'package:mobile/theme/app_theme.dart';
import 'package:mobile/widgets/custom_text_field.dart';

class VerifyCodePage extends StatelessWidget {
  const VerifyCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyCodeController());
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Code', style: theme.textTheme.titleLarge),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              Text(
                'We sent a verification code to:',
                style: theme.textTheme.bodyMedium,
              ),
              SizedBox(height: 8.h),
              Text(
                controller.emailFromArgs ?? '',
                style: theme.textTheme.titleMedium,
              ),
              SizedBox(height: 12.h),
              if (controller.otpFromServer != null) ...[
                Text('OTP (for testing):', style: theme.textTheme.bodySmall),
                SizedBox(height: 6.h),
                SelectableText(
                  controller.otpFromServer!,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                SizedBox(height: 12.h),
              ],
              CustomTextField(
                label: 'Enter OTP',
                hint: '6-digit code',
                controller: controller.codeController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 12.h),
              CustomTextField(
                label: 'New Password',
                hint: 'Enter new password',
                controller: controller.passwordController,
                isPassword: true,
              ),
              SizedBox(height: 12.h),
              CustomTextField(
                label: 'Confirm New Password',
                hint: 'Repeat new password',
                controller: controller.passwordConfirmController,
                isPassword: true,
              ),
              SizedBox(height: 20.h),
              Obx(() {
                return SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: controller.isSubmitting.value
                        ? null
                        : controller.resetPassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: controller.isSubmitting.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Reset Password',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
