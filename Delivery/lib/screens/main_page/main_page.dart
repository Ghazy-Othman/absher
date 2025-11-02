//
//
//
import 'package:delivery_man/screens/delivery_requests/delivery_requests_page.dart';
import 'package:delivery_man/screens/earnings/earnings_page.dart';
import 'package:delivery_man/screens/main_page/controller/main_page_controller.dart';
import 'package:delivery_man/screens/orders/controller/order_controller.dart';
import 'package:delivery_man/screens/orders/orders_page.dart';
import 'package:delivery_man/screens/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../theme/app_theme.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final MainPageController controller = Get.put(MainPageController());
  final OrdersController ordersController = Get.put(OrdersController());

  final pages = [OrdersTab(), RequestsTab(), EarningsPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[controller.currentIndex.value]),
      bottomNavigationBar: Obx(() {
        final idx = controller.currentIndex.value;
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: idx,
          onTap: controller.changeIndex,
          backgroundColor: AppTheme.darkBlue,
          selectedItemColor: AppTheme.accentBlue,
          unselectedItemColor: Colors.white70,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.list, size: 20.sp),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.delivery_dining, size: 20.sp),
              label: 'Requests',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on, size: 20.sp),
              label: 'Earnings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 20.sp),
              label: 'Profile',
            ),
          ],
        );
      }),
    );
  }
}
