import 'package:delivery_man/constants/api_constants.dart';
import 'package:delivery_man/utils/api_helper.dart';
import 'package:get/get.dart';
import 'package:delivery_man/models/delivery_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestsController extends GetxController {
  var requests = <DeliveryRequest>[].obs;
  var isLoading = false.obs;

  Future<void> fetchRequests({String? status}) async {
    try {
      isLoading.value = true;
      final pref = await SharedPreferences.getInstance();
      final id = pref.get("user_id");
      final response = await ApiHelper.get(
        '${ApiConstants.baseUrl}/delivery-requests/delivery/$id',
        needAuth: true,
        queryParams: status != null ? {'status': status} : {},
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        requests.value = (response.data['data'] as List)
            .map((e) => DeliveryRequest.fromJson(e))
            .toList();
      }
    } catch (e) {
      print("Error fetching requests: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchRequests();
  }
}
