import 'package:delivery_man/screens/login/controller/login_controller.dart';
import 'package:delivery_man/screens/login/forget_password_page.dart';
import 'package:delivery_man/screens/sign_up_pages/sign_up_screen.dart';
import 'package:delivery_man/theme/app_theme.dart';
import 'package:delivery_man/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 30.h),

              // Email
              CustomTextField(
                label: 'Email',
                hint: 'Enter your email',
                controller: controller.emailController,
              ),
              SizedBox(height: 20.h),

              // Password
              CustomTextField(
                label: 'Password',
                hint: 'Enter your password',
                controller: controller.passwordController,
                isPassword: true,
              ),
              SizedBox(height: 12.h),

              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => ForgetPasswordPage()) ;
                  },
                  child: Text(
                    'Forget Password?',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppTheme.accentBlue,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),

              // Login button
              Obx(() {
                return SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () => controller.login(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                  ),
                );
              }),
              SizedBox(height: 20.h),

              // Sign up navigation
              Center(
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => const SignUpScreen());
                  },
                  child: Text(
                    "Don't have an account? Sign Up",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppTheme.accentBlue,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
