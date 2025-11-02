import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdsSlider extends StatefulWidget {
  const AdsSlider({super.key});

  @override
  State<AdsSlider> createState() => _AdsSliderState();
}

class _AdsSliderState extends State<AdsSlider> {
  final PageController _adController = PageController();
  int _adPageIndex = 0;
  late Timer _adTimer;
  final List<String> adsImages = [
    "assets/ads/ad_1.jpg",
    "assets/ads/ad_2.jpg",
    "assets/ads/ad_3.jpg",
    "assets/ads/ad_1.jpg",
    "assets/ads/ad_2.jpg",
  ];

  @override
  void initState() {
    super.initState();
    _adTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_adController.hasClients) {
        _adPageIndex++;
        _adController.animateToPage(
          _adPageIndex % 5,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _adTimer.cancel();
    _adController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160.h, // use ScreenUtil here
      child: PageView.builder(
        controller: _adController,
        itemCount: adsImages.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Image.asset(
              adsImages[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
