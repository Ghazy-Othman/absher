//
//
//
import 'package:delivery_man/screens/earnings/controller/earnings_page_controller.dart';
import 'package:delivery_man/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EarningsPage extends StatelessWidget {
  const EarningsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final EarningsController controller = Get.put(EarningsController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryBlue,
        title: Text("My Earnings", style: TextStyle(fontSize: 18.sp)),
        toolbarHeight: 56.h,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 📅 Date Picker
              GestureDetector(
                onTap: () => controller.pickDate(context),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Date: ${controller.selectedDate.value}",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const Icon(Icons.calendar_today),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // 📊 Totals
              Row(
                children: [
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          children: [
                            Text(
                              "Total Earnings",
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              "\$${controller.totalEarnings.value.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          children: [
                            Text(
                              "Deliveries",
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              controller.totalDeliveries.value.toString(),
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // 📋 Deliveries List
              Expanded(
                child: controller.deliveries.isEmpty
                    ? Center(
                        child: Text(
                          "No deliveries found",
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      )
                    : ListView.builder(
                        itemCount: controller.deliveries.length,
                        itemBuilder: (context, index) {
                          final item = controller.deliveries[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Text(
                                  item['vendor'] != null &&
                                          item['vendor'].isNotEmpty
                                      ? item['vendor'][0].toUpperCase()
                                      : "?",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(item['vendor'] ?? "Unknown Vendor"),
                              subtitle: Text(
                                "Earning: \$${item['earning'].toString()}",
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
