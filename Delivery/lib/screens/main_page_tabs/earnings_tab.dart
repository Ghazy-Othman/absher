//
//
//
import 'package:delivery_man/controllers/earnings_tab_controller.dart';
import 'package:delivery_man/theme/app_theme.dart';
import 'package:delivery_man/widgets/Activity_card.dart';
import 'package:delivery_man/widgets/date_card.dart';
import 'package:delivery_man/widgets/delivery_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EarningsTab extends StatefulWidget {
  const EarningsTab({super.key});

  @override
  State<EarningsTab> createState() => _EarningsTabState();
}

class _EarningsTabState extends State<EarningsTab> {
  final EarningsController controller = EarningsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Earnings"),
        backgroundColor: AppTheme.darkBlue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            DateCard(
              date: controller.formattedDate,
              isToday: controller.isToday,
              onPrevious: () => setState(() => controller.previousDate()),
              onNext: controller.isToday
                  ? null
                  : () => setState(() => controller.nextDate()),
            ),
            SizedBox(height: 16.h),
            ActivityCard(
              earnings: controller.totalEarnings,
              deliveries: controller.totalDeliveries,
            ),
            SizedBox(height: 20.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Deliveries",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: ListView.builder(
                itemCount: controller.deliveries.length,
                itemBuilder: (context, index) {
                  final delivery = controller.deliveries[index];
                  return DeliveryCard(
                    vendor: delivery['vendor'],
                    earning: delivery['earning'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
