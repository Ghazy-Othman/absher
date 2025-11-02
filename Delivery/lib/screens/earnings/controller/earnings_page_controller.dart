//
import 'package:delivery_man/constants/api_constants.dart';
import 'package:delivery_man/utils/api_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EarningsController extends GetxController {
  RxString selectedDate =
      DateFormat('yyyy-MM-dd').format(DateTime.now()).obs; // default today
  RxDouble totalEarnings = 0.0.obs;
  RxInt totalDeliveries = 0.obs;
  RxList<Map<String, dynamic>> deliveries = <Map<String, dynamic>>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEarnings();
  }

  Future<void> fetchEarnings() async {
    try {
      isLoading.value = true;
      final response = await ApiHelper.post(
        "${ApiConstants.baseUrl}/delivery/earnings",
        data: {"date": selectedDate.value},
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300 ) {
        totalEarnings.value =
            double.tryParse(response.data['total_earnings'].toString()) ?? 0.0;
        totalDeliveries.value = response.data['total_deliveries'] ?? 0;
        deliveries.value = List<Map<String, dynamic>>.from(
          response.data['deliveries'] ?? [],
        );
      }
    } catch (e) {
      print("sdf");
      print(e.toString()) ;
      Get.snackbar("Error", "Failed to fetch earnings",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickDate(BuildContext context) async {
    DateTime initialDate = DateFormat("yyyy-MM-dd").parse(selectedDate.value);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      selectedDate.value = DateFormat('yyyy-MM-dd').format(picked);
      fetchEarnings();
    }
  }
}
