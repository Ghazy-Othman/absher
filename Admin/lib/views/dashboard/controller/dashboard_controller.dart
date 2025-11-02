//
//
//
import 'package:admin/models/vendor_analytics.dart';
import 'package:admin/services/vendor_service.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  ///
  var isLoading = false.obs;
  var analytics = Rxn<VendorAnalytics>();
  var errorMessage = ''.obs;

  ///
  Future<void> load() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      analytics.value = await VendorService.fetchVendorAnalytics();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
