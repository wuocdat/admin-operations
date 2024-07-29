import 'package:api_client/src/api_config.dart';
import 'package:api_client/src/common/handlers.dart';
import 'package:dio/dio.dart';

class UserRequestFailure implements Exception {}

class UserNotFoundFailure implements Exception {}

class CreateNewUserFailure implements Exception {}

class DeleteUserFailure implements Exception {}

class UserApiClient {
  UserApiClient({Dio? dio})
      : _dio = dio ?? Dio(ApiConfig.options)
          ..interceptors.add(ApiInterceptors());

  static const userUrl = "/auth/current";
  static const searchUser = "/users/all";
  static const userList = "/users";

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

  Future<List> fetchUnitUsers(String unitId, int limit, [int page = 1]) async {
    final response = await _dio.get(userList, queryParameters: {
      "unit": unitId,
      "pageSize": limit,
      "currentPage": page,
    });

    final result = Handler.parseResponse(response) as List;

    return result;
  }

  Future<void> createNewUser(String name, String username, String password,
      String unitId, String role) async {
    final response = await _dio.post(userList, data: {
      "name": name,
      "username": username,
      "password": password,
      "role": role,
      "unit": unitId,
    });

    if (response.statusCode != 201) throw CreateNewUserFailure();
  }

  Future<void> deleteUser(String userId) async {
    final response = await _dio.patch("$userList/$userId", data: {
      "isActive": false,
    });

    if (response.statusCode != 200) throw DeleteUserFailure();
  }
}
