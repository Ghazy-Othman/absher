import 'package:admin/theme/app_theme.dart';
import 'package:admin/views/Auth/controller/login_controller.dart';
import 'package:admin/views/Auth/signup_page.dart';
import 'package:admin/views/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const CirLoader();
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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

              // Email Field
              TextField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: AppTheme.primaryBlue,
                    fontSize: 16.sp,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.primaryBlue),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 24.h),

              // Password Field
              TextField(
                controller: controller.passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: AppTheme.primaryBlue,
                    fontSize: 16.sp,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.primaryBlue),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 40.h),

              // Login Button
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
                  onPressed: () => controller.login(),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Sign up prompt
              GestureDetector(
                onTap: () => Get.offAll(() => const SignUpPage()),
                child: Text(
                  'No account yet? Create one',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppTheme.secondaryText,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
