//
//
//
import 'package:flutter/material.dart';
import 'package:mobile/pages/main/controller/main_page_controller.dart';
import '../../../theme/app_theme.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  final controller = Get.put(MainPageController());

  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: controller.pages[controller.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppTheme.darkBlue,
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTab,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppTheme.accentBlue,
          unselectedItemColor: Colors.white70,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: "Carts",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.reorder_sharp),
              label: "Orders",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
