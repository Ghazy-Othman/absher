import 'package:flutter/material.dart';

import '../widgets/ads_slider.dart';
import '../widgets/first_section.dart';
import '../widgets/recommended_section.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleCategoryPage extends StatefulWidget {
  const SingleCategoryPage({super.key, required this.title});

  final String title;

  @override
  State<SingleCategoryPage> createState() => _SingleCategoryPageState();
}

class _SingleCategoryPageState extends State<SingleCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(fontSize: 18.sp)),
        toolbarHeight: 56.h,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16.h),
            const AdsSlider(),
            SizedBox(height: 16.h),
            FirstSectionWidget(sectionTitle: "Trending", products: []),
            SizedBox(height: 16.h),
            FirstSectionWidget(
              sectionTitle: "New Products",
              products: [],
              hasPrice: true,
              price: 538,
            ),
            SizedBox(height: 16.h),
            RecommendedSectionWidget(
              sectionTitle: "All Products",
              products: [],
            ),
            SizedBox(height: 100.h), // Space for bottom nav
          ],
        ),
      ),
    );
  }
}
