import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:api_client/src/api_config.dart';

class LoginRequestFailure implements Exception {}

class TokenNotFoundFailure implements Exception {}

class AuthApiClient {
  AuthApiClient({Dio? dio, FlutterSecureStorage? storage})
      : _dio = dio ?? Dio(ApiConfig.options)
          ..interceptors.add(ApiInterceptors()),
        _storage = storage ?? const FlutterSecureStorage();

  static const loginUrl = "/auth/login";

  final Dio _dio;
  final FlutterSecureStorage _storage;

  Future<void> login(String username, String password) async {
    final response = await _dio.post(loginUrl, data: {
      "username": username,
      "password": password,
      "autoLogin": true,
    });

    if (response.statusCode != 201) {
      throw LoginRequestFailure();
    }

    final rawCookie = response.headers['set-cookie'];

    if (rawCookie != null) {
      for (var cookie in rawCookie) {
        final regex = RegExp(r'token=([^;]+)');
        final match = regex.firstMatch(cookie);
        if (match != null && match.group(1) != null) {
          await _storage.write(key: "access_token", value: match.group(1));
          return;
        }
      }
    }

    throw TokenNotFoundFailure();
  }
}
