//
//
//
import 'package:get/get.dart';

class HomePageController extends GetxController {
  var currentTab = 0.obs;

  void changeTab(int index) {
    currentTab.value = index;
  }
}
