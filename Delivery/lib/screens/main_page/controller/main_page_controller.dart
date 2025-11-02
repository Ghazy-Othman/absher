//
//
//
import 'package:get/get.dart';

class MainPageController extends GetxController {
  final currentIndex = 0.obs;

  void changeIndex(int idx) => currentIndex.value = idx;
}
