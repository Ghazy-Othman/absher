import 'package:flutter/material.dart';
import 'package:mobile/pages/main_page.dart';
import 'package:mobile/pages/vendor/vendor_main_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TestingPage extends StatelessWidget {
  const TestingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(14.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "This page is just for testing. In production, the next page will be determined depending on current user role.",
              style: TextStyle(fontSize: 16.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const MainPage()),
                );
              },
              child: Text(
                "Customer",
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const VendorMainPage()),
                );
              },
              child: Text(
                "Vendor",
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
