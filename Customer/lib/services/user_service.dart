//
//
//

import 'package:mobile/constants/api_constants.dart';
import 'package:mobile/models/user.dart';
import 'package:mobile/utils/api_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  ///
  static Future<void> signUp(Map<String, dynamic> data) async {
    try {
      final response = await ApiHelper.post(ApiConstants.signUp, data: data);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        //
        await setToken(response.data['token']);
        await setUserID(response.data['user']['id']);
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
      final response = await ApiHelper.post(ApiConstants.login, data: data);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        //
        await setToken(response.data['token']);
        await setUserID(response.data['user']['id']);
        return;
      }
      throw "Failed to login. Please try again";
    } catch (e) {
      rethrow;
    }
  }

  ///TODO
  ///
  static Future<void> forgetPassword() async {
    try {} catch (e) {
      rethrow;
    }
  }

  ///
  static Future<void> resetPassword() async {
    try {} catch (e) {
      rethrow;
    }
  }

  static Future<User?> getUserInfo() async {
    try {
      final res = await ApiHelper.get(ApiConstants.me, needAuth: true);
      print(res.data.toString()) ;
      final data = res.data['user'];
      return User.fromJson(data);
    } catch (e) {
      print("-------------");
      print(e.toString());
      return null;
    }
  }

  ///=======================================================
  ///                 Storage Services
  ///=======================================================
  ///
  static Future<void> setToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString("token", token);
  }

  ///
  static Future<String> getToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString("token") ?? "";
  }

  ///
  static Future<void> setUserID(int userID) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setInt("user_id", userID);
  }

  ///
  static Future<int> getUserID() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getInt("user_id") ?? 0;
  }
}
