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
    });

    if (response.statusCode != 201) {
      throw LoginRequestFailure();
    }

    final bodyJson = response.data as Map<String, dynamic>;

    if (!bodyJson.containsKey("access_token")) throw TokenNotFoundFailure();

    final accessToken = bodyJson['access_token'] as String;

    print(response.headers["set-cookie"]);

    // await _storage.write(key: "access_token", value: accessToken);
  }
}
