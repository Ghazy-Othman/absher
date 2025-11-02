//
//
//
//
import 'package:mobile/constants/api_constants.dart';
import 'package:mobile/utils/api_helper.dart';

class OTPService {
  static Future<String> generateDeliverOTP(int orderId) async {
    try {
      final response = await ApiHelper.post(
        ApiConstants.generateCode.replaceFirst(
          "{order_id}",
          orderId.toString(),
        ),
        needAuth: true,
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        String code = response.data['data']['otp'];
        return code;
      } else {
        throw Exception("Failed to request code");
      }
    } catch (e) {
      rethrow;
    }
  }
}
