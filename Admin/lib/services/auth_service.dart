//
//
//
import 'package:admin/constants/api_constants.dart';
import 'package:admin/services/vendor_service.dart';
import 'package:admin/utils/api_helper.dart';

class AuthService {
  ///
  static Future<void> register(Map<String, dynamic> data) async {
    try {
      final response = await ApiHelper.post(ApiConstant.register, data: data);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        //
        await VendorService.setVendorToken(response.data['token']);
        await VendorService.setVendorId(response.data['user']['id']);
        return;
      } else {
        throw "Failed to sign up. Please try again";
      }
    } catch (e) {
      rethrow;
    }
  }

  ///
  static Future<void> login(Map<String, dynamic> data) async {
    try {
      final response = await ApiHelper.post(ApiConstant.login, data: data);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        //
        await VendorService.setVendorToken(response.data['token']);
        await VendorService.setVendorId(response.data['user']['id']);
        return;
      }
      throw "Failed to login. Please try again";
    } catch (e) {
      rethrow;
    }
  }

  ///
  static Future<String> forgetPassword(Map<String, dynamic> data) async {
    try {
      final response = await ApiHelper.post(
        ApiConstant.forgetPassword,
        data: data,
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final data = response.data;
        return data['otp'];
      } else {
        throw Exception("Failed to get OTP code");
      }
    } catch (e) {
      rethrow;
    }
  }

  ///
  static Future<bool> resetPassword(Map<String, dynamic> data) async {
    try {
      final response = await ApiHelper.post(
        ApiConstant.resetPassword,
        data: data,
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }
}
