//
//
//
import 'package:admin/constants/api_constants.dart';
import 'package:admin/models/vendor_analytics.dart';
import 'package:admin/utils/api_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VendorService {
  ///
  static Future<VendorAnalytics> fetchVendorAnalytics() async {
    try {
      final vendorId = await VendorService.vendorId();
      final res = await ApiHelper.get(
        ApiConstant.vendorAnalytics(vendorId),
        needAuth: true,
      );
      return VendorAnalytics.fromJson(res.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  ///============================================
  ///               Local Services
  ///============================================
  ///
  static Future<int> vendorId() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getInt("vendor_id")!;
  }

  ///
  static Future<void> setVendorId(int vendorId) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setInt("vendor_id", vendorId);
  }

  ///
  static Future<String> vendorToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString("vendor_token")!;
  }

  ///
  static Future<void> setVendorToken(String vendorToken) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString("vendor_token", vendorToken);
  }

  ///TODO : Add more
}
