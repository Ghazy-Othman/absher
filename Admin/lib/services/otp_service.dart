//
//
//
import 'package:admin/constants/api_constants.dart';
import 'package:admin/utils/api_helper.dart';

class OTPService {
  static Future<String> requestPickUpOtp(int orderId) async {
    try {
      final res = await ApiHelper.post(
        ApiConstant.requestPickUpOTP.replaceFirst(
          "{order_id}",
          orderId.toString(),
        ),
        needAuth: true,
      );
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        String otp = res.data['data']['otp'];
        return otp;
      } else {
        throw Exception("Failed to request otp");
      }
    } catch (e) {
      rethrow;
    }
  }
}
