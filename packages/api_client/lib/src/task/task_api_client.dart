import 'package:api_client/src/api_config.dart';
import 'package:api_client/src/common/handlers.dart';
import 'package:api_client/src/task/models/models.dart';
import 'package:api_client/src/task/path.dart';
import 'package:dio/dio.dart';

class TaskRequestFailure implements Exception {}

class TaskNotFoundFailure implements Exception {}

class TaskApiClient {
  TaskApiClient({Dio? dio})
      : _dio = dio ?? Dio(ApiConfig.options)
          ..interceptors.add(ApiInterceptors());

  final Dio _dio;

  Future<Overall> getOverall() async {
    final response = await _dio.get(TaskUrl.overall, queryParameters: {
      'task': true,
    });

    final result = Handler.parseResponse(response);

    if (!result.containsKey('task')) throw TaskNotFoundFailure();

    final taskOverall = result['task'] as Map<String, dynamic>;

    return Overall.fromJson(taskOverall);
  }
}
