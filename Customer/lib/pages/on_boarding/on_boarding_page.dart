import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/pages/auth/login_page.dart';
import 'package:mobile/theme/app_theme.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<String> images = [
    'assets/onboarding/onboarding_1.jpg',
    'assets/onboarding/onboarding_2.jpg',
    'assets/onboarding/onboarding_3.jpg',
  ];

  final List<String> descriptions = [
    'Welcome to Absher! Buy and sell easily with smart shopping tools.',
    'Track your orders, explore deals, and manage your cart with ease.',
    'Let\'s get started and discover amazing products around you.',
  ];

  void _skip() {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginPage()));
  }

  void _nextPage() {
    if (_currentIndex < images.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      _skip();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: images.length,
                onPageChanged: (index) => setState(() => _currentIndex = index),
                itemBuilder: (context, index) {
                  return Center(
                    child: Image.asset(
                      images[index],
                      width: double.infinity,
                      height: 300.h,
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              descriptions[_currentIndex],
              style: TextStyle(fontSize: 14.sp, color: AppTheme.secondaryText),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                images.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  width: _currentIndex == index ? 16.w : 8.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? AppTheme.primaryBlue
                        : AppTheme.divider,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _skip,
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: AppTheme.primaryBlue,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 12.h,
                      ),
                      child: Text(
                        "Next",
                        style: TextStyle(fontSize: 14.sp, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
