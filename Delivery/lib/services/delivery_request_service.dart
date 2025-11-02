//
//
//
import 'package:delivery_man/constants/api_constants.dart';
import 'package:delivery_man/utils/api_helper.dart';

class DeliveryRequestService {
  ///
  static Future<void> sendDeliveryRequest(int orderId) async {
    try {
      await ApiHelper.post(
        ApiConstants.sendDeliveryRequest,
        data: {"order_id": orderId},
        needAuth: true,
      );
    } catch (e) {
      rethrow;
    }
  }
}
