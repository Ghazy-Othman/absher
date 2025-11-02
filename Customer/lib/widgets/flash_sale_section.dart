import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/models/product.dart';
import 'package:mobile/pages/all_falsh_sales_page.dart';
import 'package:mobile/theme/app_theme.dart';
import 'package:mobile/widgets/discount_product_card.dart';

class FlashSaleSection extends StatefulWidget {
  const FlashSaleSection({
    super.key,
    required this.endTime,
    required this.products,
  });

  final List<Product> products;

  final DateTime endTime;

  @override
  State<FlashSaleSection> createState() => _FlashSaleSectionState();
}

class _FlashSaleSectionState extends State<FlashSaleSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Text(
            "Flash Sale",
            style: TextStyle(color: AppTheme.primaryBlue, fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8.h),

        //
        TimerRow(endTime: widget.endTime),
        SizedBox(height: 12.h),

        //
        SizedBox(
          height: 180.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            itemCount: widget.products.length,
            itemBuilder: (context, index) {
              final product = widget.products[index];
              return DiscountProductCard(
                name: product.name ?? "product_name",
                id: product.id ?? 0,
                imagePath: product.getImage,
                originalPrice: Random().nextDouble() * 10000,
                currentPrice: product.price!.toDouble(),
                discount: "${Random().nextInt(100) + 1}%",
              );
            },
          ),
        ),
      ],
    );
  }
}

// Make this row in separate widget so refresh alone every second
class TimerRow extends StatefulWidget {
  const TimerRow({super.key, required this.endTime});

  final DateTime endTime;

  @override
  State<TimerRow> createState() => _TimerRowState();
}

class _TimerRowState extends State<TimerRow> {
  late Timer _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());
  }

  void _updateTime() {
    // Calc remaining time
    final now = DateTime.now();
    final diff = widget.endTime.difference(now);

    setState(() {
      // if negative, then remaining is zero , else is diff
      _remaining = diff.isNegative ? Duration.zero : diff;
    });

    // If is zero, no timer needed, cancel it
    if (_remaining == Duration.zero) {
      _timer.cancel();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get _hours => _remaining.inHours.toString().padLeft(2, '0');

  String get _minutes => (_remaining.inMinutes % 60).toString().padLeft(2, '0');

  String get _seconds => (_remaining.inSeconds % 60).toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: [
          Text(
            "Flash sale end in :",
            style: TextStyle(fontSize: 12.sp, color: Colors.black),
          ),
          SizedBox(width: 8.w),
          _buildTimerBox(_hours),
          Text(":", style: TextStyle(fontSize: 12.sp)),
          _buildTimerBox(_minutes),
          Text(":", style: TextStyle(fontSize: 12.sp)),
          _buildTimerBox(_seconds),
          // Spacer(),
          // GestureDetector(
          //   onTap: () {
          //     ///TODO : Navigate to flash sale full page
          //     Navigator.pushReplacement(
          //       context,
          //       MaterialPageRoute(builder: (_) => FlashSalesPage()),
          //     );
          //   },
          //   child: Text(
          //     "View All",
          //     style: TextStyle(
          //       fontSize: 12.sp,
          //       color: AppTheme.accentBlue,
          //       fontWeight: FontWeight.w500,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildTimerBox(String time) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      decoration: BoxDecoration(
        color: Colors.red[100],
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        time,
        style: TextStyle(fontSize: 12.sp, color: Colors.red),
      ),
    );
  }
}
