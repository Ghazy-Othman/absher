import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final pageIndex = 0.obs;

  void setPage(int index) => pageIndex.value = index;
}
