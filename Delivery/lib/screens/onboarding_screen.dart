import 'package:delivery_man/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _onboardList = [
    {
      'imagePath': 'assets/images/onboard1.jpg',
      'title': 'Fast Delivery',
      'description':
          'Get your items delivered in record time with our optimized routes.',
    },
    {
      'imagePath': 'assets/images/onboard1.jpg',
      'title': 'Real-Time Tracking',
      'description':
          'Track your order status live and stay informed at every step.',
    },
    {
      'imagePath': 'assets/images/onboard1.jpg',
      'title': 'Secure Payment',
      'description':
          'Pay safely through our trusted payment partners and gateways.',
    },
  ];

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  void _nextPage() {
    if (_currentIndex == _onboardList.length - 1) {
      _goToLogin();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              // Skip button
              if (_currentIndex != _onboardList.length - 1)
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: _goToLogin,
                    child: Text(
                      'Skip',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _onboardList.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (_, index) {
                    final data = _onboardList[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          data['imagePath'] ?? "...",
                          width: 250.w,
                          height: 250.h,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          data['title'] ?? "...",
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 22.sp,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          data['description'] ?? '...',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 14.sp,
                            color: theme.hintColor,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 24.h),

              // Next / Start Delivering button
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(AppTheme.primaryBlue)
                  ),
                  child: Text(
                    _currentIndex == _onboardList.length - 1
                        ? 'Start Delivering'
                        : 'Next',
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
