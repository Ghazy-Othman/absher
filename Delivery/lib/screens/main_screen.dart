//
//
//
import 'package:delivery_man/controllers/main_page_controller.dart';
import 'package:delivery_man/screens/main_page_tabs/earnings_tab.dart';
import 'package:delivery_man/screens/main_page_tabs/profile_tab.dart';
import 'package:delivery_man/screens/main_page_tabs/requests_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final MainPageController controller = MainPageController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    // controller.generateOrders();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: Padding(
          padding: EdgeInsets.only(top: 40.h, left: 16.w, right: 16.w),
          child: _buildCustomTabBar(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: [EarningsTab(), RequestsTab(), ProfileTab()],
      ),
    );
  }

  Widget _buildCustomTabBar() {
    final tabs = ["Earnings", "Orders", "Profile"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(tabs.length, (index) {
        final isSelected = _tabController.index == index;
        return GestureDetector(
          onTap: () => setState(() => _tabController.index = index),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (isSelected)
                Positioned(
                  bottom: -8.h,
                  child: Container(
                    width: 60.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: Colors.green.shade200,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.lightGreen : Colors.transparent,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  tabs[index],
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
