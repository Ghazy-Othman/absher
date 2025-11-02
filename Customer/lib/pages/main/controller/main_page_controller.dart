//
import 'package:get/get.dart';
import 'package:mobile/pages/carts/carts_tab.dart';
import 'package:mobile/pages/home/home_page.dart';
import 'package:mobile/pages/orders/orders_page.dart';
import 'package:mobile/pages/profile/profile_page.dart';

class MainPageController extends GetxController {
  var currentIndex = 0.obs;
  final pages = [
    HomePage(),
    CartsPage(),
    OrdersPage(),
    ProfileTab(),
  ];

  void changeTab(int index) {
    currentIndex.value = index;
  }
}
