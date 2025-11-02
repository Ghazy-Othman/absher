import 'package:admin/models/vendor_analytics.dart';
import 'package:admin/theme/app_theme.dart';
import 'package:admin/views/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  final ctrl = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    ctrl.load();
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard', style: TextStyle(fontSize: 18.sp)),
        backgroundColor: AppTheme.darkBlue,
      ),
      body: Obx(() {
        if (ctrl.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (ctrl.errorMessage.value.isNotEmpty) {
          return RefreshIndicator(
            onRefresh: ctrl.load,
            child: ListView(
              physics: AlwaysScrollableScrollPhysics(),
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 200.h),
                    child: Text(ctrl.errorMessage.value),
                  ),
                ),
              ],
            ),
          );
        }
        final data = ctrl.analytics.value!;
        return RefreshIndicator(
          onRefresh: ctrl.load,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummaryRow(data),
                SizedBox(height: 12.h),
                _buildChartsSection(data),
                SizedBox(height: 12.h),
                _buildTopProducts(data.topProducts),
              ],
            ),
          ),
        );
      }),
    );
  }

  ///
  Widget _buildSummaryRow(VendorAnalytics data) {
    return Row(
      children: [
        _statCard(
          'Total Orders',
          data.totalOrders.toString(),
          AppTheme.accentBlue,
        ),
        SizedBox(width: 8.w),
        _statCard(
          'Published',
          (data.statusCounts['published'] ?? 0).toString(),
          Colors.orange,
        ),
        SizedBox(width: 8.w),
        _statCard(
          'Pending',
          (data.statusCounts['pending'] ?? 0).toString(),
          Colors.redAccent,
        ),
        SizedBox(width: 8.w),
        _statCard(
          'Revenue',
          '\$${data.revenueTotalCents}',
          Colors.green,
        ),
      ],
    );
  }

  ///
  Widget _statCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 12.sp, color: AppTheme.darkBlue),
            ),
            SizedBox(height: 8.h),
            Text(
              value,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///
  Widget _buildChartsSection(VendorAnalytics data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Orders in last 7 days',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        SizedBox(height: 180.h, child: _buildBarChart(data.ordersPerDay)),
        SizedBox(height: 12.h),
        Text(
          'Status Distribution',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        SizedBox(height: 160.h, child: _buildPieChart(data)),
      ],
    );
  }

  Widget _buildBarChart(List<OrdersPerDay> series) {
    if (series.isEmpty) {
      return Center(
        child: Text('No data', style: TextStyle(fontSize: 12.sp)),
      );
    }

    final maxY =
        series
            .map((s) => s.count)
            .fold<int>(0, (prev, e) => e > prev ? e : prev)
            .toDouble() +
        2.0;

    final barGroups = List.generate(series.length, (i) {
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: series[i].count.toDouble(),
            width: 14.w,
            borderRadius: BorderRadius.circular(6.r),
            color: AppTheme.accentBlue,
          ),
        ],
      );
    });

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceBetween,
        maxY: maxY,
        barGroups: barGroups,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) =>
              FlLine(color: Colors.grey, strokeWidth: 1),
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 36,
              // interval: 1,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 36,
              // Modern signature: (double value, TitleMeta meta)
              getTitlesWidget: (double value, TitleMeta meta) {
                final idx = value.toInt();
                if (idx < 0 || idx >= series.length)
                  return const SizedBox.shrink();

                final label = series[idx].day
                    .split('-')
                    .last; // show day number (or format as you like)

                // Simple text widget for compatibility across versions
                return Padding(
                  padding: EdgeInsets.only(top: 6.h),
                  child: Text(
                    label,
                    style: TextStyle(fontSize: 10.sp, color: AppTheme.darkBlue),
                  ),
                );
              },
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final day = series[group.x.toInt()].day;
              return BarTooltipItem(
                '$day\n',
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
                children: [
                  TextSpan(
                    text: '${rod.toY.toInt()} orders',
                    style: TextStyle(color: Colors.white70, fontSize: 11.sp),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPieChart(VendorAnalytics data) {
    final pending = data.statusCounts['pending'] ?? 0;
    final published = data.statusCounts['published'] ?? 0;
    final delivered = data.statusCounts['delivered'] ?? 0;
    final others = data.totalOrders - (pending + published + delivered);

    final sections = <PieChartSectionData>[
      PieChartSectionData(
        value: pending.toDouble(),
        color: Colors.orange,
        title: 'Pending',
      ),
      PieChartSectionData(
        value: published.toDouble(),
        color: AppTheme.accentBlue,
        title: 'Published',
      ),
      PieChartSectionData(
        value: delivered.toDouble(),
        color: Colors.green,
        title: 'Delivered',
      ),
      PieChartSectionData(
        value: others.toDouble(),
        color: Colors.grey,
        title: 'Other',
      ),
    ];

    return PieChart(
      PieChartData(
        sections: sections,
        sectionsSpace: 2,
        centerSpaceRadius: 20.r,
      ),
    );
  }

  Widget _buildTopProducts(List<TopProduct> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top Products',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        ...products.map(
          (p) => ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(p.name, style: TextStyle(fontSize: 13.sp)),
            subtitle: Text('${p.qty} sold', style: TextStyle(fontSize: 11.sp)),
            trailing: Text(
              '\$${(p.priceCents / 100).toStringAsFixed(2)}',
              style: TextStyle(fontSize: 13.sp, color: AppTheme.darkBlue),
            ),
          ),
        ),
      ],
    );
  }
}
