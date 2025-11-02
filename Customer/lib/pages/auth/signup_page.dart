import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile/pages/auth/controller/signup_controller.dart';
import 'package:mobile/pages/auth/login_page.dart';
import 'package:mobile/widgets/loader.dart';
import 'package:mobile/theme/app_theme.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Loader();
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50.h,),
                // App Title
                Text(
                  'Absher',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryBlue,
                  ),
                ),
                SizedBox(height: 40.h),

                // Full Name Field
                TextField(
                  controller: controller.fullNameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    labelStyle: TextStyle(color: AppTheme.primaryBlue),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.primaryBlue),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                // Email Field
                TextField(
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: AppTheme.primaryBlue),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.primaryBlue),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                // Address Field
                TextField(
                  controller: controller.addressController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    labelStyle: TextStyle(color: AppTheme.primaryBlue),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.primaryBlue),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                // Password Field
                TextField(
                  controller: controller.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: AppTheme.primaryBlue),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.primaryBlue),
                    ),
                  ),
                ),
                SizedBox(height: 40.h),

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryBlue,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    onPressed: () => controller.signUp(),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                  ),
                ),

                SizedBox(height: 16.h),

                // Log In Prompt
                GestureDetector(
                  onTap: () => Get.offAll(() => const LoginPage()),
                  child: Text(
                    'Already a member? Log in',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppTheme.secondaryText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
