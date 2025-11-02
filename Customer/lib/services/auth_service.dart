//
//
//
import 'package:mobile/constants/api_constants.dart';
import 'package:mobile/utils/api_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  ///
  static Future<String> forgetPassword(Map<String, dynamic> data) async {
    try {
      final response = await ApiHelper.post(
        ApiConstants.forgetPassword,
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
        ApiConstants.resetPassword,
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

  ///====================================================
  ///
  static Future<void> setToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString("token", token);
  }

  ///
  static Future<void> setUserId(int userId) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setInt("user_id", userId);
  }

  ///
  static Future<String> getToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString("token") ?? "";
  }

  ///
  static Future<int> getUserId() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getInt("user_id") ?? 0;
  }

}
