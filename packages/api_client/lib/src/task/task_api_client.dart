import 'dart:convert';

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

    final result = Handler.parseResponse(response) as Map<String, dynamic>;

    if (!result.containsKey('task')) throw TaskNotFoundFailure();

    final taskOverall = result['task'] as Map<String, dynamic>;

    return Overall.fromJson(taskOverall);
  }

  Future<List<Task>> getReceivedTasks(
      String progressStatus, String? text, int limit,
      [int currentPage = 1]) async {
    final Map<String, dynamic> queryParameters = {
      "pageSize": limit,
      "currentPage": currentPage,
      "taskProgressStatus": progressStatus,
    };

    if (text != null && text.isNotEmpty) {
      queryParameters["text"] = text;
    }

    final response = await _dio.get(
      TaskUrl.received,
      queryParameters: queryParameters,
    );

    final result = Handler.parseResponse(response) as List;

    return result.map((dynamic json) {
      final map = json as Map<String, dynamic>;
      return Task.fromJson(map);
    }).toList();
  }

  Future<List<Task>> getSentTasks(String owner, String? text, int limit,
      [int currentPage = 1]) async {
    final Map<String, dynamic> queryParameters = {
      "pageSize": limit,
      "currentPage": currentPage,
      "owner": owner,
      "sortBy": jsonEncode({
        "createdAt": -1,
      }),
    };

    if (text != null && text.isNotEmpty) {
      queryParameters["text"] = text;
    }

    final response = await _dio.get(
      TaskUrl.sent,
      queryParameters: queryParameters,
    );

    final result = Handler.parseResponse(response) as List;

    return result.map((dynamic json) {
      final map = json as Map<String, dynamic>;
      return Task.fromJson(map);
    }).toList();
  }
}
