import 'dart:convert';

import 'package:api_client/src/api_config.dart';
import 'package:api_client/src/common/handlers.dart';
import 'package:api_client/src/target/path.dart';
import 'package:dio/dio.dart';

class TargetNotFoundFailure implements Exception {}

class TargetApiClient {
  TargetApiClient({Dio? dio})
      : _dio = dio ?? Dio(ApiConfig.options)
          ..interceptors.add(ApiInterceptors());

  final Dio _dio;

  Future<Map<String, dynamic>> getOverall() async {
    final response = await _dio.get(TargetUrl.overall);

    final result = Handler.parseResponse(response) as Map<String, dynamic>;

    if (!result.containsKey('subject')) throw TargetNotFoundFailure();

    return result['subject'] as Map<String, dynamic>;
  }

  Future<List> fetchSubject(int limit, [int page = 1]) async {
    final response = await _dio.get(TargetUrl.list, queryParameters: {
      'typeAc': 0,
      'pageSize': limit,
      'currentPage': page,
      'sortBy': jsonEncode({'name': 1})
    });

    final result = Handler.parseResponse(response) as List;

    return result;
  }
}
