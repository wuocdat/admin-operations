import 'package:api_client/src/api_config.dart';
import 'package:api_client/src/common/handlers.dart';
import 'package:dio/dio.dart';

class UserRequestFailure implements Exception {}

class UserNotFoundFailure implements Exception {}

class UserApiClient {
  UserApiClient({Dio? dio})
      : _dio = dio ?? Dio(ApiConfig.options)
          ..interceptors.add(ApiInterceptors());

  static const userUrl = "/auth/current";
  static const searchUser = "/users/all";

  final Dio _dio;

  Future<Map<String, dynamic>> getUser() async {
    final userResponse = await _dio.get(userUrl);

    if (userResponse.statusCode != 200) throw UserRequestFailure();

    final data = userResponse.data as Map<String, dynamic>;

    if (!data.containsKey("data")) throw UserNotFoundFailure();

    return data['data'] as Map<String, dynamic>;
  }

  Future<List> searchUsers(String username, int limit,
      [int currentPage = 1]) async {
    final response = await _dio.get(
      searchUser,
      queryParameters: {
        "username": username,
        'limit': limit,
        'page': currentPage,
      },
    );

    final result = Handler.parseResponse(response) as List;

    return result;
  }
}
