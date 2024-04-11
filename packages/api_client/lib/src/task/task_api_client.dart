import 'dart:convert';

import 'package:api_client/src/api_config.dart';
import 'package:api_client/src/common/handlers.dart';
import 'package:api_client/src/task/path.dart';
import 'package:dio/dio.dart';

class TaskRequestFailure implements Exception {}

class TaskNotFoundFailure implements Exception {}

class TaskApiClient {
  TaskApiClient({Dio? dio})
      : _dio = dio ?? Dio(ApiConfig.options)
          ..interceptors.add(ApiInterceptors());

  final Dio _dio;

  Future<Map<String, dynamic>> getOverall() async {
    final response = await _dio.get(TaskUrl.overall, queryParameters: {
      'task': true,
    });

    final result = Handler.parseResponse(response) as Map<String, dynamic>;

    if (!result.containsKey('task')) throw TaskNotFoundFailure();

    return result['task'] as Map<String, dynamic>;
  }

  Future<List<Map<String, dynamic>>> getReceivedTasks(
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
      return map;
    }).toList();
  }

  Future<List<Map<String, dynamic>>> getSentTasks(
      String owner, String? text, int limit,
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
      return map;
    }).toList();
  }

  Future<void> createTask(
    String name,
    String type,
    List<String> units,
    String content,
    bool important,
    List<String> filePaths,
  ) async {
    final formData = FormData.fromMap({
      'name': name,
      'type': type,
      'content': content,
      'important': important,
    });

    formData.fields.addAll(units.map((unit) {
      return MapEntry('units[]', unit);
    }));

    if (filePaths.isNotEmpty) {
      formData.files.addAll(await Future.wait(filePaths.map((path) async {
        return MapEntry('files', await MultipartFile.fromFile(path));
      })));
    }

    final response = await _dio.post(
      TaskUrl.original,
      data: formData,
    );

    if (response.statusCode != 201) {
      throw TaskRequestFailure();
    }
  }

  Future<Map<String, dynamic>> fetchSentTaskById(String taskId) async {
    final response = await _dio.get('${TaskUrl.sent}/$taskId');

    final result = Handler.parseResponse(response) as Map<String, dynamic>;

    return result;
  }
}
