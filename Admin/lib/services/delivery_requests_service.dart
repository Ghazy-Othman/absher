//
//
//
import 'package:admin/constants/api_constants.dart';
import 'package:admin/models/delivery_request.dart';
import 'package:admin/services/vendor_service.dart';
import 'package:admin/utils/api_helper.dart';

class DeliveryRequestsService {
  ///
  static Future<List<DeliveryRequest>> getDeliveryRequests({
    String status = "",
  }) async {
    try {
      final vendorId = await VendorService.vendorId();
      final response = await ApiHelper.get(
        ApiConstant.getAllDeliveryRequests(vendorId),
        queryParams: status.isNotEmpty ? {"status": status} : null,
        needAuth: true,
      );
      final List<dynamic> data = response.data['data'];
      return data.map((dr) => DeliveryRequest.fromJson(dr)).toList();
    } catch (e) {
      rethrow;
    }
  }

  ///
  static Future<DeliveryRequest> updateDeliveryRequestStatus(
    int deliveryRequestId,
    String status,
  ) async {
    try {
      final response = await ApiHelper.put(
        ApiConstant.updateDeliveryRequestStatus(deliveryRequestId),
        data: {'status': status},
        needAuth: true,
      );
      final data = response.data['data'];
      return DeliveryRequest.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }
}
