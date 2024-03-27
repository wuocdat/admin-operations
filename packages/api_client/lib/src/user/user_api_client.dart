import 'package:api_client/src/api_config.dart';
import 'package:api_client/src/user/models/user.dart';
import 'package:dio/dio.dart';

class UserRequestFailure implements Exception {}

class UserNotFoundFailure implements Exception {}

class UserApiClient {
  UserApiClient({Dio? dio})
      : _dio = dio ?? Dio(ApiConfig.options)
          ..interceptors.add(ApiInterceptors());

  static const userUrl = "/auth/current";

  final Dio _dio;

  Future<User> getUser() async {
    final userResponse = await _dio.get(userUrl);

    if (userResponse.statusCode != 200) throw UserRequestFailure();

    final data = userResponse.data as Map<String, dynamic>;

    return User.fromJson(data);
  }
}
