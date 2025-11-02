//
//
//
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mobile/services/user_service.dart';

class ApiHelper {
  static final Dio _dio = Dio();

  /// Builds the headers for each request
  static Future<Map<String, String>> _buildHeaders({
    bool needAuth = false,
  }) async {
    final headers = <String, String>{'Accept': 'application/json'};

    if (needAuth) {
      final token = await _getToken();
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return headers;
  }

  ///TODO : Get token from local
  static Future<String?> _getToken() async {
    return await UserService.getToken();
  }

  /// GET request
  static Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParams,
    bool needAuth = false,
  }) async {
    final headers = await _buildHeaders(needAuth: needAuth);

    return await _dio.get(
      url,
      queryParameters: queryParams,
      options: Options(headers: headers),
    );
  }

  /// POST request (with optional files)
  static Future<Response> post(
    String url, {
    Map<String, dynamic>? data,
    Map<String, File>? files,
    bool needAuth = false,
  }) async {
    final headers = await _buildHeaders(needAuth: needAuth);

    dynamic body = data ?? {};

    if (files != null && files.isNotEmpty) {
      final formData = FormData.fromMap(body);

      for (final entry in files.entries) {
        final multipartFile = await MultipartFile.fromFile(
          entry.value.path,
          filename: entry.value.path.split('/').last,
        );
        formData.files.add(MapEntry(entry.key, multipartFile));
      }

      body = formData;
    }

    return await _dio.post(
      url,
      data: body,
      options: Options(headers: headers),
    );
  }

  /// PUT request (with optional files)
  static Future<Response> put(
    String url, {
    Map<String, dynamic>? data,
    Map<String, File>? files,
    bool needAuth = false,
  }) async {
    final headers = await _buildHeaders(needAuth: needAuth);

    dynamic body = data ?? {};

    if (files != null && files.isNotEmpty) {
      final formData = FormData.fromMap(body);

      for (final entry in files.entries) {
        final multipartFile = await MultipartFile.fromFile(
          entry.value.path,
          filename: entry.value.path.split('/').last,
        );
        formData.files.add(MapEntry(entry.key, multipartFile));
      }

      body = formData;
    }

    return await _dio.put(
      url,
      data: body,
      options: Options(headers: headers),
    );
  }

  /// DELETE request
  static Future<Response> delete(
    String url, {
    Map<String, dynamic>? data,
    bool needAuth = false,
  }) async {
    final headers = await _buildHeaders(needAuth: needAuth);

    return await _dio.delete(
      url,
      data: data,
      options: Options(headers: headers),
    );
  }
}
